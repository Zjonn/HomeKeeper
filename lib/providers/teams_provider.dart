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

  JoinResult(this.status, this.response);
}

class CreateResult {
  bool status;
  GraphQLResponse<CreateTeam$Mutation> response;

  CreateResult(this.status, this.response);
}

class TeamInfo {
  late int id;
  late String name;
  late List<String> teamMembers;

  TeamInfo(this.id, this.name, this.teamMembers);

  TeamInfo.fromResp(ListUserTeamsInfo$Query$TeamType response) {
    id = int.parse(response.id);
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
  late ArtemisClient _client;
  bool _client_init = false;

  FlutterSecureStorage _storage = FlutterSecureStorage();

  TeamState _state = TeamState.ToBeChecked;
  // int? _currentTeam = null;
  // TeamInfo? _teamInfo = null;

  TeamState get state => _state;
  // void set currentTeam(int teamId) {
  //   _currentTeam = teamId;
  // }

  TeamProvider();

  TeamProvider.withMocks(this._client, this._storage);

  Future<bool> isUserMemberOfTeam() async {
    GraphQLResponse<ListUserTeams$Query> response = await _getClient()
        .then((client) => client.execute(ListUserTeamsQuery()));
    assert(!response.hasErrors, response.errors.toString());

    bool? result = response.data?.myTeams?.isNotEmpty;
    var prev_state = _state;
    if (result == null) {
      _state = TeamState.ToBeChecked;
    } else if (result) {
      _state = TeamState.UserIsMember;
    } else {
      _state = TeamState.UserIsNotMember;
    }

    if (prev_state != state) {
      notifyListeners();
    }

    return result ?? false;
  }

  Future<List<TeamInfo>> listUserTeamsInfo() async {
    GraphQLResponse<ListUserTeamsInfo$Query> response = await await _getClient()
        .then((client) => client.execute(ListUserTeamsInfoQuery()));
    assert(!response.hasErrors, response.errors.toString());

    List<TeamInfo> info =
        response.data!.myTeams!.map((e) => TeamInfo.fromResp(e!)).toList();
    return info;
  }

  Future<JoinResult> joinTeam(int teamId, String password) async {
    GraphQLResponse<JoinTeam$Mutation> response = await await _getClient().then(
        (client) => client.execute(JoinTeamMutation(
            variables: JoinTeamArguments(teamId: teamId, password: password))));

    if (!response.hasErrors && _state != TeamState.UserIsMember) {
      _state = TeamState.UserIsMember;
      notifyListeners();
    }

    return JoinResult(!response.hasErrors, response);
  }

  Future<CreateResult> createTeam(String name, String password) async {
    GraphQLResponse<CreateTeam$Mutation> response = await _getClient().then(
        (client) => client.execute(CreateTeamMutation(
            variables: CreateTeamArguments(name: name, password: password))));
    bool hasData = !response.hasErrors &&
        (response.data!.createTeam!.errors?.isEmpty ?? false);

    if (hasData && _state != TeamState.UserIsMember) {
      _state = TeamState.UserIsMember;
      notifyListeners();
    }
    return CreateResult(hasData, response);
  }

  Future<ArtemisClient> _getClient() async {
    if (!_client_init) {
      String? token = await this._storage.read(key: "token");
      if (token == null) {
        throw ("token has to be in storage");
      }
      _client = initializeClient(token);
      _client_init = true;
    }
    return _client;
  }
}
