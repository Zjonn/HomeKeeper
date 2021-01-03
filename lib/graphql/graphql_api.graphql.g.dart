// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'graphql_api.graphql.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

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
