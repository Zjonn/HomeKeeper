// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:meta/meta.dart';
import 'package:artemis/artemis.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
part 'graphql_api.graphql.g.dart';

@JsonSerializable(explicitToJson: true)
class RegisterUser$Mutation$RegisterPayload$ErrorType with EquatableMixin {
  RegisterUser$Mutation$RegisterPayload$ErrorType();

  factory RegisterUser$Mutation$RegisterPayload$ErrorType.fromJson(
          Map<String, dynamic> json) =>
      _$RegisterUser$Mutation$RegisterPayload$ErrorTypeFromJson(json);

  String field;

  List<String> messages;

  @override
  List<Object> get props => [field, messages];
  Map<String, dynamic> toJson() =>
      _$RegisterUser$Mutation$RegisterPayload$ErrorTypeToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RegisterUser$Mutation$RegisterPayload with EquatableMixin {
  RegisterUser$Mutation$RegisterPayload();

  factory RegisterUser$Mutation$RegisterPayload.fromJson(
          Map<String, dynamic> json) =>
      _$RegisterUser$Mutation$RegisterPayloadFromJson(json);

  String username;

  List<RegisterUser$Mutation$RegisterPayload$ErrorType> errors;

  @override
  List<Object> get props => [username, errors];
  Map<String, dynamic> toJson() =>
      _$RegisterUser$Mutation$RegisterPayloadToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RegisterUser$Mutation with EquatableMixin {
  RegisterUser$Mutation();

  factory RegisterUser$Mutation.fromJson(Map<String, dynamic> json) =>
      _$RegisterUser$MutationFromJson(json);

  RegisterUser$Mutation$RegisterPayload register;

  @override
  List<Object> get props => [register];
  Map<String, dynamic> toJson() => _$RegisterUser$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RegisterInput with EquatableMixin {
  RegisterInput(
      {@required this.username,
      @required this.password1,
      @required this.password2,
      this.email,
      this.clientMutationId});

  factory RegisterInput.fromJson(Map<String, dynamic> json) =>
      _$RegisterInputFromJson(json);

  String username;

  String password1;

  String password2;

  String email;

  String clientMutationId;

  @override
  List<Object> get props =>
      [username, password1, password2, email, clientMutationId];
  Map<String, dynamic> toJson() => _$RegisterInputToJson(this);
}

@JsonSerializable(explicitToJson: true)
class LoginUser$Mutation$ObtainJSONWebToken with EquatableMixin {
  LoginUser$Mutation$ObtainJSONWebToken();

  factory LoginUser$Mutation$ObtainJSONWebToken.fromJson(
          Map<String, dynamic> json) =>
      _$LoginUser$Mutation$ObtainJSONWebTokenFromJson(json);

  String token;

  int refreshExpiresIn;

  @override
  List<Object> get props => [token, refreshExpiresIn];
  Map<String, dynamic> toJson() =>
      _$LoginUser$Mutation$ObtainJSONWebTokenToJson(this);
}

@JsonSerializable(explicitToJson: true)
class LoginUser$Mutation with EquatableMixin {
  LoginUser$Mutation();

  factory LoginUser$Mutation.fromJson(Map<String, dynamic> json) =>
      _$LoginUser$MutationFromJson(json);

  LoginUser$Mutation$ObtainJSONWebToken tokenAuth;

  @override
  List<Object> get props => [tokenAuth];
  Map<String, dynamic> toJson() => _$LoginUser$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RegisterUserArguments extends JsonSerializable with EquatableMixin {
  RegisterUserArguments({@required this.input});

  @override
  factory RegisterUserArguments.fromJson(Map<String, dynamic> json) =>
      _$RegisterUserArgumentsFromJson(json);

  final RegisterInput input;

  @override
  List<Object> get props => [input];
  @override
  Map<String, dynamic> toJson() => _$RegisterUserArgumentsToJson(this);
}

class RegisterUserMutation
    extends GraphQLQuery<RegisterUser$Mutation, RegisterUserArguments> {
  RegisterUserMutation({this.variables});

  @override
  final DocumentNode document = DocumentNode(definitions: [
    OperationDefinitionNode(
        type: OperationType.mutation,
        name: NameNode(value: 'RegisterUser'),
        variableDefinitions: [
          VariableDefinitionNode(
              variable: VariableNode(name: NameNode(value: 'input')),
              type: NamedTypeNode(
                  name: NameNode(value: 'RegisterInput'), isNonNull: true),
              defaultValue: DefaultValueNode(value: null),
              directives: [])
        ],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
              name: NameNode(value: 'register'),
              alias: null,
              arguments: [
                ArgumentNode(
                    name: NameNode(value: 'input'),
                    value: VariableNode(name: NameNode(value: 'input')))
              ],
              directives: [],
              selectionSet: SelectionSetNode(selections: [
                FieldNode(
                    name: NameNode(value: 'username'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null),
                FieldNode(
                    name: NameNode(value: 'errors'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: SelectionSetNode(selections: [
                      FieldNode(
                          name: NameNode(value: 'field'),
                          alias: null,
                          arguments: [],
                          directives: [],
                          selectionSet: null),
                      FieldNode(
                          name: NameNode(value: 'messages'),
                          alias: null,
                          arguments: [],
                          directives: [],
                          selectionSet: null)
                    ]))
              ]))
        ]))
  ]);

  @override
  final String operationName = 'RegisterUser';

  @override
  final RegisterUserArguments variables;

  @override
  List<Object> get props => [document, operationName, variables];
  @override
  RegisterUser$Mutation parse(Map<String, dynamic> json) =>
      RegisterUser$Mutation.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class LoginUserArguments extends JsonSerializable with EquatableMixin {
  LoginUserArguments({@required this.username, @required this.password});

  @override
  factory LoginUserArguments.fromJson(Map<String, dynamic> json) =>
      _$LoginUserArgumentsFromJson(json);

  final String username;

  final String password;

  @override
  List<Object> get props => [username, password];
  @override
  Map<String, dynamic> toJson() => _$LoginUserArgumentsToJson(this);
}

class LoginUserMutation
    extends GraphQLQuery<LoginUser$Mutation, LoginUserArguments> {
  LoginUserMutation({this.variables});

  @override
  final DocumentNode document = DocumentNode(definitions: [
    OperationDefinitionNode(
        type: OperationType.mutation,
        name: NameNode(value: 'LoginUser'),
        variableDefinitions: [
          VariableDefinitionNode(
              variable: VariableNode(name: NameNode(value: 'username')),
              type: NamedTypeNode(
                  name: NameNode(value: 'String'), isNonNull: true),
              defaultValue: DefaultValueNode(value: null),
              directives: []),
          VariableDefinitionNode(
              variable: VariableNode(name: NameNode(value: 'password')),
              type: NamedTypeNode(
                  name: NameNode(value: 'String'), isNonNull: true),
              defaultValue: DefaultValueNode(value: null),
              directives: [])
        ],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
              name: NameNode(value: 'tokenAuth'),
              alias: null,
              arguments: [
                ArgumentNode(
                    name: NameNode(value: 'username'),
                    value: VariableNode(name: NameNode(value: 'username'))),
                ArgumentNode(
                    name: NameNode(value: 'password'),
                    value: VariableNode(name: NameNode(value: 'password')))
              ],
              directives: [],
              selectionSet: SelectionSetNode(selections: [
                FieldNode(
                    name: NameNode(value: 'token'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null),
                FieldNode(
                    name: NameNode(value: 'refreshExpiresIn'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null)
              ]))
        ]))
  ]);

  @override
  final String operationName = 'LoginUser';

  @override
  final LoginUserArguments variables;

  @override
  List<Object> get props => [document, operationName, variables];
  @override
  LoginUser$Mutation parse(Map<String, dynamic> json) =>
      LoginUser$Mutation.fromJson(json);
}
