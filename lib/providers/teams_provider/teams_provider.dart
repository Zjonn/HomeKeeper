import 'dart:async';

import 'package:artemis/artemis.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:home_keeper/config/client.dart';
import 'package:home_keeper/graphql/graphql_api.dart';
import 'package:home_keeper/providers/teams_provider/results.dart';
import 'package:home_keeper/providers/teams_provider/team_info.dart';

enum TeamProviderState {
  Uninitialized,
  UserIsNotMember,
  UserIsMember,
}

class TeamProvider with ChangeNotifier {
  late final ArtemisClientWithTimeout _client;

  TeamProviderState _state = TeamProviderState.Uninitialized;
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
    if (response.hasErrors) {
      return;
    }

    Map<String, TeamInfo> info = {
      for (var team in response.data!.myTeams!)
        team!.id: TeamInfo.fromResp(team)
    };

    if (mapEquals<String, TeamInfo>(info, _teamsInfo) &&
        _state != TeamProviderState.Uninitialized) {
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
    final resp = JoinResult(response);

    if (resp.isSuccessful && _state != TeamProviderState.UserIsMember) {
      await updateUserTeamsInfo();
    }
    return resp;
  }

  Future<CreateResult> createTeam(String name, String password) async {
    GraphQLResponse<CreateTeam$Mutation> response = await _client.execute(
        CreateTeamMutation(
            variables: CreateTeamArguments(name: name, password: password)));
    final resp = CreateResult(response);

    if (resp.isSuccessful && _state != TeamProviderState.UserIsMember) {
      await updateUserTeamsInfo();
    }
    return resp;
  }

  Future<LeaveResult> leaveTeam(int teamId) async {
    GraphQLResponse<LeaveTeam$Mutation> response = await _client.execute(
        LeaveTeamMutation(variables: LeaveTeamArguments(teamId: teamId)));
    final resp = LeaveResult(response);

    if (resp.isSuccessful) {
      _state = TeamProviderState.UserIsNotMember;
      await updateUserTeamsInfo();
    }
    return resp;
  }
}
