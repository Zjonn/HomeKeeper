// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'graphql_api.graphql.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginUser$Mutation$ObtainJSONWebToken
    _$LoginUser$Mutation$ObtainJSONWebTokenFromJson(Map<String, dynamic> json) {
  return LoginUser$Mutation$ObtainJSONWebToken()
    ..token = json['token'] as String
    ..refreshExpiresIn = json['refreshExpiresIn'] as int;
}

Map<String, dynamic> _$LoginUser$Mutation$ObtainJSONWebTokenToJson(
        LoginUser$Mutation$ObtainJSONWebToken instance) =>
    <String, dynamic>{
      'token': instance.token,
      'refreshExpiresIn': instance.refreshExpiresIn,
    };

LoginUser$Mutation _$LoginUser$MutationFromJson(Map<String, dynamic> json) {
  return LoginUser$Mutation()
    ..tokenAuth = json['tokenAuth'] == null
        ? null
        : LoginUser$Mutation$ObtainJSONWebToken.fromJson(
            json['tokenAuth'] as Map<String, dynamic>);
}

Map<String, dynamic> _$LoginUser$MutationToJson(LoginUser$Mutation instance) =>
    <String, dynamic>{
      'tokenAuth': instance.tokenAuth?.toJson(),
    };

RegisterUser$Mutation$RegisterPayload$ErrorType
    _$RegisterUser$Mutation$RegisterPayload$ErrorTypeFromJson(
        Map<String, dynamic> json) {
  return RegisterUser$Mutation$RegisterPayload$ErrorType()
    ..field = json['field'] as String
    ..messages = (json['messages'] as List)?.map((e) => e as String)?.toList();
}

Map<String, dynamic> _$RegisterUser$Mutation$RegisterPayload$ErrorTypeToJson(
        RegisterUser$Mutation$RegisterPayload$ErrorType instance) =>
    <String, dynamic>{
      'field': instance.field,
      'messages': instance.messages,
    };

RegisterUser$Mutation$RegisterPayload
    _$RegisterUser$Mutation$RegisterPayloadFromJson(Map<String, dynamic> json) {
  return RegisterUser$Mutation$RegisterPayload()
    ..username = json['username'] as String
    ..errors = (json['errors'] as List)
        ?.map((e) => e == null
            ? null
            : RegisterUser$Mutation$RegisterPayload$ErrorType.fromJson(
                e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$RegisterUser$Mutation$RegisterPayloadToJson(
        RegisterUser$Mutation$RegisterPayload instance) =>
    <String, dynamic>{
      'username': instance.username,
      'errors': instance.errors?.map((e) => e?.toJson())?.toList(),
    };

RegisterUser$Mutation _$RegisterUser$MutationFromJson(
    Map<String, dynamic> json) {
  return RegisterUser$Mutation()
    ..register = json['register'] == null
        ? null
        : RegisterUser$Mutation$RegisterPayload.fromJson(
            json['register'] as Map<String, dynamic>);
}

Map<String, dynamic> _$RegisterUser$MutationToJson(
        RegisterUser$Mutation instance) =>
    <String, dynamic>{
      'register': instance.register?.toJson(),
    };

RegisterInput _$RegisterInputFromJson(Map<String, dynamic> json) {
  return RegisterInput(
    username: json['username'] as String,
    password1: json['password1'] as String,
    password2: json['password2'] as String,
    email: json['email'] as String,
    clientMutationId: json['clientMutationId'] as String,
  );
}

Map<String, dynamic> _$RegisterInputToJson(RegisterInput instance) =>
    <String, dynamic>{
      'username': instance.username,
      'password1': instance.password1,
      'password2': instance.password2,
      'email': instance.email,
      'clientMutationId': instance.clientMutationId,
    };

ListUserTeams$Query$TeamType _$ListUserTeams$Query$TeamTypeFromJson(
    Map<String, dynamic> json) {
  return ListUserTeams$Query$TeamType()..id = json['id'] as String;
}

Map<String, dynamic> _$ListUserTeams$Query$TeamTypeToJson(
        ListUserTeams$Query$TeamType instance) =>
    <String, dynamic>{
      'id': instance.id,
    };

ListUserTeams$Query _$ListUserTeams$QueryFromJson(Map<String, dynamic> json) {
  return ListUserTeams$Query()
    ..myTeams = (json['myTeams'] as List)
        ?.map((e) => e == null
            ? null
            : ListUserTeams$Query$TeamType.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$ListUserTeams$QueryToJson(
        ListUserTeams$Query instance) =>
    <String, dynamic>{
      'myTeams': instance.myTeams?.map((e) => e?.toJson())?.toList(),
    };

ListTeams$Query$TeamType$UserType _$ListTeams$Query$TeamType$UserTypeFromJson(
    Map<String, dynamic> json) {
  return ListTeams$Query$TeamType$UserType()
    ..username = json['username'] as String;
}

Map<String, dynamic> _$ListTeams$Query$TeamType$UserTypeToJson(
        ListTeams$Query$TeamType$UserType instance) =>
    <String, dynamic>{
      'username': instance.username,
    };

ListTeams$Query$TeamType _$ListTeams$Query$TeamTypeFromJson(
    Map<String, dynamic> json) {
  return ListTeams$Query$TeamType()
    ..id = json['id'] as String
    ..name = json['name'] as String
    ..createdBy = json['createdBy'] == null
        ? null
        : ListTeams$Query$TeamType$UserType.fromJson(
            json['createdBy'] as Map<String, dynamic>);
}

Map<String, dynamic> _$ListTeams$Query$TeamTypeToJson(
        ListTeams$Query$TeamType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'createdBy': instance.createdBy?.toJson(),
    };

ListTeams$Query _$ListTeams$QueryFromJson(Map<String, dynamic> json) {
  return ListTeams$Query()
    ..teams = (json['teams'] as List)
        ?.map((e) => e == null
            ? null
            : ListTeams$Query$TeamType.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$ListTeams$QueryToJson(ListTeams$Query instance) =>
    <String, dynamic>{
      'teams': instance.teams?.map((e) => e?.toJson())?.toList(),
    };

CreateTeam$Mutation$CreateTeamPayload$TeamType
    _$CreateTeam$Mutation$CreateTeamPayload$TeamTypeFromJson(
        Map<String, dynamic> json) {
  return CreateTeam$Mutation$CreateTeamPayload$TeamType()
    ..name = json['name'] as String;
}

Map<String, dynamic> _$CreateTeam$Mutation$CreateTeamPayload$TeamTypeToJson(
        CreateTeam$Mutation$CreateTeamPayload$TeamType instance) =>
    <String, dynamic>{
      'name': instance.name,
    };

CreateTeam$Mutation$CreateTeamPayload$ErrorType
    _$CreateTeam$Mutation$CreateTeamPayload$ErrorTypeFromJson(
        Map<String, dynamic> json) {
  return CreateTeam$Mutation$CreateTeamPayload$ErrorType()
    ..field = json['field'] as String
    ..messages = (json['messages'] as List)?.map((e) => e as String)?.toList();
}

Map<String, dynamic> _$CreateTeam$Mutation$CreateTeamPayload$ErrorTypeToJson(
        CreateTeam$Mutation$CreateTeamPayload$ErrorType instance) =>
    <String, dynamic>{
      'field': instance.field,
      'messages': instance.messages,
    };

CreateTeam$Mutation$CreateTeamPayload
    _$CreateTeam$Mutation$CreateTeamPayloadFromJson(Map<String, dynamic> json) {
  return CreateTeam$Mutation$CreateTeamPayload()
    ..team = json['team'] == null
        ? null
        : CreateTeam$Mutation$CreateTeamPayload$TeamType.fromJson(
            json['team'] as Map<String, dynamic>)
    ..errors = (json['errors'] as List)
        ?.map((e) => e == null
            ? null
            : CreateTeam$Mutation$CreateTeamPayload$ErrorType.fromJson(
                e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$CreateTeam$Mutation$CreateTeamPayloadToJson(
        CreateTeam$Mutation$CreateTeamPayload instance) =>
    <String, dynamic>{
      'team': instance.team?.toJson(),
      'errors': instance.errors?.map((e) => e?.toJson())?.toList(),
    };

CreateTeam$Mutation _$CreateTeam$MutationFromJson(Map<String, dynamic> json) {
  return CreateTeam$Mutation()
    ..createTeam = json['createTeam'] == null
        ? null
        : CreateTeam$Mutation$CreateTeamPayload.fromJson(
            json['createTeam'] as Map<String, dynamic>);
}

Map<String, dynamic> _$CreateTeam$MutationToJson(
        CreateTeam$Mutation instance) =>
    <String, dynamic>{
      'createTeam': instance.createTeam?.toJson(),
    };

JoinTeam$Mutation$JoinTeam$TeamType
    _$JoinTeam$Mutation$JoinTeam$TeamTypeFromJson(Map<String, dynamic> json) {
  return JoinTeam$Mutation$JoinTeam$TeamType()..name = json['name'] as String;
}

Map<String, dynamic> _$JoinTeam$Mutation$JoinTeam$TeamTypeToJson(
        JoinTeam$Mutation$JoinTeam$TeamType instance) =>
    <String, dynamic>{
      'name': instance.name,
    };

JoinTeam$Mutation$JoinTeam _$JoinTeam$Mutation$JoinTeamFromJson(
    Map<String, dynamic> json) {
  return JoinTeam$Mutation$JoinTeam()
    ..team = json['team'] == null
        ? null
        : JoinTeam$Mutation$JoinTeam$TeamType.fromJson(
            json['team'] as Map<String, dynamic>);
}

Map<String, dynamic> _$JoinTeam$Mutation$JoinTeamToJson(
        JoinTeam$Mutation$JoinTeam instance) =>
    <String, dynamic>{
      'team': instance.team?.toJson(),
    };

JoinTeam$Mutation _$JoinTeam$MutationFromJson(Map<String, dynamic> json) {
  return JoinTeam$Mutation()
    ..joinTeam = json['joinTeam'] == null
        ? null
        : JoinTeam$Mutation$JoinTeam.fromJson(
            json['joinTeam'] as Map<String, dynamic>);
}

Map<String, dynamic> _$JoinTeam$MutationToJson(JoinTeam$Mutation instance) =>
    <String, dynamic>{
      'joinTeam': instance.joinTeam?.toJson(),
    };

LoginUserArguments _$LoginUserArgumentsFromJson(Map<String, dynamic> json) {
  return LoginUserArguments(
    username: json['username'] as String,
    password: json['password'] as String,
  );
}

Map<String, dynamic> _$LoginUserArgumentsToJson(LoginUserArguments instance) =>
    <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
    };

RegisterUserArguments _$RegisterUserArgumentsFromJson(
    Map<String, dynamic> json) {
  return RegisterUserArguments(
    input: json['input'] == null
        ? null
        : RegisterInput.fromJson(json['input'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$RegisterUserArgumentsToJson(
        RegisterUserArguments instance) =>
    <String, dynamic>{
      'input': instance.input?.toJson(),
    };

CreateTeamArguments _$CreateTeamArgumentsFromJson(Map<String, dynamic> json) {
  return CreateTeamArguments(
    name: json['name'] as String,
  );
}

Map<String, dynamic> _$CreateTeamArgumentsToJson(
        CreateTeamArguments instance) =>
    <String, dynamic>{
      'name': instance.name,
    };

JoinTeamArguments _$JoinTeamArgumentsFromJson(Map<String, dynamic> json) {
  return JoinTeamArguments(
    teamId: json['teamId'] as int,
  );
}

Map<String, dynamic> _$JoinTeamArgumentsToJson(JoinTeamArguments instance) =>
    <String, dynamic>{
      'teamId': instance.teamId,
    };
