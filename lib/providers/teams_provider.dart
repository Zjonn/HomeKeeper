// https://medium.com/@afegbua/flutter-thursday-13-building-a-user-registration-and-login-process-with-provider-and-external-api-1bb87811fd1d

import 'dart:async';

import 'package:artemis/artemis.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:home_keeper/config/client.dart';
import 'package:home_keeper/graphql/graphql_api.dart';

class JoinResult {
  bool status;
  GraphQLResponse<JoinTeam$Mutation> response;

  JoinResult({this.status, this.response});
}

class CreateResult {
  bool status;
  GraphQLResponse<CreateTeam$Mutation> response;

  CreateResult({this.status, this.response});
}

enum TeamState {
  ToBeChecked,
  UserIsNotMember,
  UserIsAlreadyMember,
  UserIsJoiningTeam,
  UserJoinedTeam,
  UserIsCreatingTeam,
  UserCreatedTeam
}

class TeamProvider with ChangeNotifier {
  ArtemisClient _client = null;
  FlutterSecureStorage _storage = FlutterSecureStorage();
  TeamState _state = TeamState.ToBeChecked;

  TeamState get state => _state;

  TeamProvider();

  TeamProvider.withMocks(this._client, this._storage);

  Future<ArtemisClient> _getClient() async {
    if (_client == null) {
      String token = await this._storage.read(key: "token");
      if (token == null) {
        throw ("token has to be in storage");
      }
      _client = initializeClient(token);
    }
    return _client;
  }

  Future<bool> isUserMemberOfTeam() async {
    var query = ListUserTeamsQuery();
    print(query.toString());

    GraphQLResponse<ListUserTeams$Query> response =
        await _getClient().then((client) => client.execute(query));

    assert(!response.hasErrors, response.errors.toString());
    bool result = response?.data?.myTeams?.isNotEmpty;
    if (result) {
      this._state = TeamState.UserIsAlreadyMember;
    } else if (result == null) {
      this._state = TeamState.ToBeChecked;
    } else {
      this._state = TeamState.UserIsNotMember;
    }
    notifyListeners();
    return result;
  }

  Future<List<ListTeams$Query$TeamType>> listTeams() async {
    var response =
        await _getClient().then((client) => client.execute(ListTeamsQuery()));
    return response.data.teams;
  }

  Future<JoinResult> joinTeam(int teamId) async {
    this._state = TeamState.UserIsJoiningTeam;
    notifyListeners();

    GraphQLResponse<JoinTeam$Mutation> response = await await _getClient().then(
        (client) => client.execute(
            JoinTeamMutation(variables: JoinTeamArguments(teamId: teamId))));
    if (!response.hasErrors) {
      this._state = TeamState.UserJoinedTeam;
    } else {
      this._state = TeamState.UserIsNotMember;
    }
    notifyListeners();
    return JoinResult(status: !response.hasErrors, response: response);
  }

  Future<CreateResult> createTeam(String name) async {
    GraphQLResponse<CreateTeam$Mutation> response = await _getClient().then(
        (client) => client.execute(CreateTeamMutation(
            variables: CreateTeamArguments(name: name, password: "XD"))));
    this._state = TeamState.UserIsCreatingTeam;
    notifyListeners();

    bool status =
        !response.hasErrors && response.data.createTeam.errors.isNotEmpty;
    if (status) {
      this._state = TeamState.UserCreatedTeam;
    } else {
      this._state = TeamState.UserIsNotMember;
    }
    notifyListeners();
    return CreateResult(status: status, response: response);
  }
}
