// https://medium.com/@afegbua/flutter-thursday-13-building-a-user-registration-and-login-process-with-provider-and-external-api-1bb87811fd1d

import 'dart:async';

import 'package:artemis/artemis.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:home_keeper/graphql/graphql_api.dart';

class JoinResult {
  bool status;
  GraphQLResponse<JoinTeam$Mutation> response;

  JoinResult(this.status, this.response);
}

class CreateResult {
  bool status;
  GraphQLResponse<CreateTeam$Mutation> response;

  CreateResult(this.status, this.response);
}

class TeamInfo {
  late final String id;
  late final String name;
  late final List<String> teamMembers;

  TeamInfo(this.id, this.name, this.teamMembers);

  TeamInfo.fromResp(ListUserTeamsInfo$Query$TeamType response) {
    id = response.id;
    name = response.name;
    teamMembers = response.members.map((e) => e.username).toList();
  }
}

enum TeamState {
  ToBeChecked,
  UserIsNotMember,
  UserIsMember,
}

class TeamProvider with ChangeNotifier {
  late final ArtemisClient _client;

  TeamState _state = TeamState.ToBeChecked;
  Map<String, TeamInfo> _teamsInfo = {};

  String? _currentTeam = null;

  TeamState get state => _state;

  TeamInfo get currentTeamInfo => _teamsInfo[_currentTeam]!;

  List<String> get userTeams => _teamsInfo.keys.toList(growable: false);

  void set currentTeam(String teamId) {
    if (!_teamsInfo.containsKey(teamId)) {
      throw "User is not a member of team with ID ${teamId}";
    }
    if (_currentTeam != teamId) {
      _currentTeam = teamId;
      notifyListeners();
    }
  }

  TeamProvider(this._client);

  Future<void> updateUserTeamsInfo() async {
    GraphQLResponse<ListUserTeamsInfo$Query> response =
        await _client.execute(ListUserTeamsInfoQuery());
    assert(!response.hasErrors, response.errors.toString());

    Map<String, TeamInfo> info = {
      for (var team in response.data!.myTeams!)
        team!.id: TeamInfo.fromResp(team)
    };

    if (mapEquals<String, TeamInfo>(info, _teamsInfo) &&
        _state != TeamState.ToBeChecked) {
      return;
    }
    _teamsInfo = info;

    if (_teamsInfo.isNotEmpty) {
      _state = TeamState.UserIsMember;
      if (_currentTeam == null) {
        _currentTeam = _teamsInfo.entries.first.key;
      }
    } else {
      _state = TeamState.UserIsNotMember;
      _currentTeam = null;
    }
    notifyListeners();
  }

  Future<JoinResult> joinTeam(int teamId, String password) async {
    GraphQLResponse<JoinTeam$Mutation> response = await _client.execute(
        JoinTeamMutation(
            variables: JoinTeamArguments(teamId: teamId, password: password)));

    if (!response.hasErrors && _state != TeamState.UserIsMember) {
      await updateUserTeamsInfo();
    }
    return JoinResult(!response.hasErrors, response);
  }

  Future<CreateResult> createTeam(String name, String password) async {
    GraphQLResponse<CreateTeam$Mutation> response = await _client.execute(
        CreateTeamMutation(
            variables: CreateTeamArguments(name: name, password: password)));
    bool hasData = !response.hasErrors &&
        (response.data!.createTeam!.errors?.isEmpty ?? false);

    if (hasData && _state != TeamState.UserIsMember) {
      await updateUserTeamsInfo();
    }
    return CreateResult(hasData, response);
  }
}
