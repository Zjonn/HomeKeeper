import 'dart:async';

import 'package:artemis/artemis.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:home_keeper/graphql/graphql_api.dart';
import 'package:home_keeper/providers/teams_provider/team_info.dart';

import 'create_result.dart';
import 'join_result.dart';

enum TeamProviderState {
  InProgress,
  UserIsNotMember,
  UserIsMember,
}

class TeamProvider with ChangeNotifier {
  late final ArtemisClient _client;

  TeamProviderState _state = TeamProviderState.InProgress;
  Map<String, TeamInfo> _teamsInfo = {};

  String? _currentTeam = null;

  TeamProviderState get state => _state;

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

  TeamProvider(this._client) {
    updateUserTeamsInfo();
  }

  Future<void> updateUserTeamsInfo() async {
    GraphQLResponse<ListUserTeamsInfo$Query> response =
        await _client.execute(ListUserTeamsInfoQuery());
    assert(!response.hasErrors, response.errors.toString());

    Map<String, TeamInfo> info = {
      for (var team in response.data!.myTeams!)
        team!.id: TeamInfo.fromResp(team)
    };

    if (mapEquals<String, TeamInfo>(info, _teamsInfo) &&
        _state != TeamProviderState.InProgress) {
      return;
    }
    _teamsInfo = info;

    if (_teamsInfo.isNotEmpty) {
      _state = TeamProviderState.UserIsMember;
      if (_currentTeam == null) {
        _currentTeam = _teamsInfo.entries.first.key;
      }
    } else {
      _state = TeamProviderState.UserIsNotMember;
      _currentTeam = null;
    }
    notifyListeners();
  }

  Future<JoinResult> joinTeam(int teamId, String password) async {
    GraphQLResponse<JoinTeam$Mutation> response = await _client.execute(
        JoinTeamMutation(
            variables: JoinTeamArguments(teamId: teamId, password: password)));

    if (!response.hasErrors && _state != TeamProviderState.UserIsMember) {
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

    if (hasData && _state != TeamProviderState.UserIsMember) {
      await updateUserTeamsInfo();
    }
    return CreateResult(hasData, response);
  }
}
