// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:meta/meta.dart';
import 'package:artemis/artemis.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
part 'graphql_api.graphql.g.dart';

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
class ListUserTeams$Query$TeamType with EquatableMixin {
  ListUserTeams$Query$TeamType();

  factory ListUserTeams$Query$TeamType.fromJson(Map<String, dynamic> json) =>
      _$ListUserTeams$Query$TeamTypeFromJson(json);

  String id;

  @override
  List<Object> get props => [id];
  Map<String, dynamic> toJson() => _$ListUserTeams$Query$TeamTypeToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ListUserTeams$Query with EquatableMixin {
  ListUserTeams$Query();

  factory ListUserTeams$Query.fromJson(Map<String, dynamic> json) =>
      _$ListUserTeams$QueryFromJson(json);

  List<ListUserTeams$Query$TeamType> myTeams;

  @override
  List<Object> get props => [myTeams];
  Map<String, dynamic> toJson() => _$ListUserTeams$QueryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ListTeams$Query$TeamType$UserType with EquatableMixin {
  ListTeams$Query$TeamType$UserType();

  factory ListTeams$Query$TeamType$UserType.fromJson(
          Map<String, dynamic> json) =>
      _$ListTeams$Query$TeamType$UserTypeFromJson(json);

  String username;

  @override
  List<Object> get props => [username];
  Map<String, dynamic> toJson() =>
      _$ListTeams$Query$TeamType$UserTypeToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ListTeams$Query$TeamType with EquatableMixin {
  ListTeams$Query$TeamType();

  factory ListTeams$Query$TeamType.fromJson(Map<String, dynamic> json) =>
      _$ListTeams$Query$TeamTypeFromJson(json);

  String id;

  String name;

  ListTeams$Query$TeamType$UserType createdBy;

  @override
  List<Object> get props => [id, name, createdBy];
  Map<String, dynamic> toJson() => _$ListTeams$Query$TeamTypeToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ListTeams$Query with EquatableMixin {
  ListTeams$Query();

  factory ListTeams$Query.fromJson(Map<String, dynamic> json) =>
      _$ListTeams$QueryFromJson(json);

  List<ListTeams$Query$TeamType> teams;

  @override
  List<Object> get props => [teams];
  Map<String, dynamic> toJson() => _$ListTeams$QueryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CreateTeam$Mutation$CreateTeamPayload$TeamType with EquatableMixin {
  CreateTeam$Mutation$CreateTeamPayload$TeamType();

  factory CreateTeam$Mutation$CreateTeamPayload$TeamType.fromJson(
          Map<String, dynamic> json) =>
      _$CreateTeam$Mutation$CreateTeamPayload$TeamTypeFromJson(json);

  String name;

  @override
  List<Object> get props => [name];
  Map<String, dynamic> toJson() =>
      _$CreateTeam$Mutation$CreateTeamPayload$TeamTypeToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CreateTeam$Mutation$CreateTeamPayload$ErrorType with EquatableMixin {
  CreateTeam$Mutation$CreateTeamPayload$ErrorType();

  factory CreateTeam$Mutation$CreateTeamPayload$ErrorType.fromJson(
          Map<String, dynamic> json) =>
      _$CreateTeam$Mutation$CreateTeamPayload$ErrorTypeFromJson(json);

  String field;

  List<String> messages;

  @override
  List<Object> get props => [field, messages];
  Map<String, dynamic> toJson() =>
      _$CreateTeam$Mutation$CreateTeamPayload$ErrorTypeToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CreateTeam$Mutation$CreateTeamPayload with EquatableMixin {
  CreateTeam$Mutation$CreateTeamPayload();

  factory CreateTeam$Mutation$CreateTeamPayload.fromJson(
          Map<String, dynamic> json) =>
      _$CreateTeam$Mutation$CreateTeamPayloadFromJson(json);

  CreateTeam$Mutation$CreateTeamPayload$TeamType team;

  List<CreateTeam$Mutation$CreateTeamPayload$ErrorType> errors;

  @override
  List<Object> get props => [team, errors];
  Map<String, dynamic> toJson() =>
      _$CreateTeam$Mutation$CreateTeamPayloadToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CreateTeam$Mutation with EquatableMixin {
  CreateTeam$Mutation();

  factory CreateTeam$Mutation.fromJson(Map<String, dynamic> json) =>
      _$CreateTeam$MutationFromJson(json);

  CreateTeam$Mutation$CreateTeamPayload createTeam;

  @override
  List<Object> get props => [createTeam];
  Map<String, dynamic> toJson() => _$CreateTeam$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class JoinTeam$Mutation$JoinTeam$TeamType with EquatableMixin {
  JoinTeam$Mutation$JoinTeam$TeamType();

  factory JoinTeam$Mutation$JoinTeam$TeamType.fromJson(
          Map<String, dynamic> json) =>
      _$JoinTeam$Mutation$JoinTeam$TeamTypeFromJson(json);

  String name;

  @override
  List<Object> get props => [name];
  Map<String, dynamic> toJson() =>
      _$JoinTeam$Mutation$JoinTeam$TeamTypeToJson(this);
}

@JsonSerializable(explicitToJson: true)
class JoinTeam$Mutation$JoinTeam with EquatableMixin {
  JoinTeam$Mutation$JoinTeam();

  factory JoinTeam$Mutation$JoinTeam.fromJson(Map<String, dynamic> json) =>
      _$JoinTeam$Mutation$JoinTeamFromJson(json);

  JoinTeam$Mutation$JoinTeam$TeamType team;

  @override
  List<Object> get props => [team];
  Map<String, dynamic> toJson() => _$JoinTeam$Mutation$JoinTeamToJson(this);
}

@JsonSerializable(explicitToJson: true)
class JoinTeam$Mutation with EquatableMixin {
  JoinTeam$Mutation();

  factory JoinTeam$Mutation.fromJson(Map<String, dynamic> json) =>
      _$JoinTeam$MutationFromJson(json);

  JoinTeam$Mutation$JoinTeam joinTeam;

  @override
  List<Object> get props => [joinTeam];
  Map<String, dynamic> toJson() => _$JoinTeam$MutationToJson(this);
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

class ListUserTeamsQuery
    extends GraphQLQuery<ListUserTeams$Query, JsonSerializable> {
  ListUserTeamsQuery();

  @override
  final DocumentNode document = DocumentNode(definitions: [
    OperationDefinitionNode(
        type: OperationType.query,
        name: NameNode(value: 'ListUserTeams'),
        variableDefinitions: [],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
              name: NameNode(value: 'myTeams'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: SelectionSetNode(selections: [
                FieldNode(
                    name: NameNode(value: 'id'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null)
              ]))
        ])),
    OperationDefinitionNode(
        type: OperationType.query,
        name: NameNode(value: 'ListTeams'),
        variableDefinitions: [],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
              name: NameNode(value: 'teams'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: SelectionSetNode(selections: [
                FieldNode(
                    name: NameNode(value: 'id'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null),
                FieldNode(
                    name: NameNode(value: 'name'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null),
                FieldNode(
                    name: NameNode(value: 'createdBy'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: SelectionSetNode(selections: [
                      FieldNode(
                          name: NameNode(value: 'username'),
                          alias: null,
                          arguments: [],
                          directives: [],
                          selectionSet: null)
                    ]))
              ]))
        ])),
    OperationDefinitionNode(
        type: OperationType.mutation,
        name: NameNode(value: 'CreateTeam'),
        variableDefinitions: [
          VariableDefinitionNode(
              variable: VariableNode(name: NameNode(value: 'name')),
              type: NamedTypeNode(
                  name: NameNode(value: 'String'), isNonNull: true),
              defaultValue: DefaultValueNode(value: null),
              directives: [])
        ],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
              name: NameNode(value: 'createTeam'),
              alias: null,
              arguments: [
                ArgumentNode(
                    name: NameNode(value: 'input'),
                    value: ObjectValueNode(fields: [
                      ObjectFieldNode(
                          name: NameNode(value: 'name'),
                          value: VariableNode(name: NameNode(value: 'name')))
                    ]))
              ],
              directives: [],
              selectionSet: SelectionSetNode(selections: [
                FieldNode(
                    name: NameNode(value: 'team'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: SelectionSetNode(selections: [
                      FieldNode(
                          name: NameNode(value: 'name'),
                          alias: null,
                          arguments: [],
                          directives: [],
                          selectionSet: null)
                    ])),
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
        ])),
    OperationDefinitionNode(
        type: OperationType.mutation,
        name: NameNode(value: 'JoinTeam'),
        variableDefinitions: [
          VariableDefinitionNode(
              variable: VariableNode(name: NameNode(value: 'teamId')),
              type:
                  NamedTypeNode(name: NameNode(value: 'Int'), isNonNull: true),
              defaultValue: DefaultValueNode(value: null),
              directives: [])
        ],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
              name: NameNode(value: 'joinTeam'),
              alias: null,
              arguments: [
                ArgumentNode(
                    name: NameNode(value: 'teamId'),
                    value: VariableNode(name: NameNode(value: 'teamId')))
              ],
              directives: [],
              selectionSet: SelectionSetNode(selections: [
                FieldNode(
                    name: NameNode(value: 'team'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: SelectionSetNode(selections: [
                      FieldNode(
                          name: NameNode(value: 'name'),
                          alias: null,
                          arguments: [],
                          directives: [],
                          selectionSet: null)
                    ]))
              ]))
        ]))
  ]);

  @override
  final String operationName = 'ListUserTeams';

  @override
  List<Object> get props => [document, operationName];
  @override
  ListUserTeams$Query parse(Map<String, dynamic> json) =>
      ListUserTeams$Query.fromJson(json);
}

class ListTeamsQuery extends GraphQLQuery<ListTeams$Query, JsonSerializable> {
  ListTeamsQuery();

  @override
  final DocumentNode document = DocumentNode(definitions: [
    OperationDefinitionNode(
        type: OperationType.query,
        name: NameNode(value: 'ListUserTeams'),
        variableDefinitions: [],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
              name: NameNode(value: 'myTeams'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: SelectionSetNode(selections: [
                FieldNode(
                    name: NameNode(value: 'id'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null)
              ]))
        ])),
    OperationDefinitionNode(
        type: OperationType.query,
        name: NameNode(value: 'ListTeams'),
        variableDefinitions: [],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
              name: NameNode(value: 'teams'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: SelectionSetNode(selections: [
                FieldNode(
                    name: NameNode(value: 'id'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null),
                FieldNode(
                    name: NameNode(value: 'name'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null),
                FieldNode(
                    name: NameNode(value: 'createdBy'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: SelectionSetNode(selections: [
                      FieldNode(
                          name: NameNode(value: 'username'),
                          alias: null,
                          arguments: [],
                          directives: [],
                          selectionSet: null)
                    ]))
              ]))
        ])),
    OperationDefinitionNode(
        type: OperationType.mutation,
        name: NameNode(value: 'CreateTeam'),
        variableDefinitions: [
          VariableDefinitionNode(
              variable: VariableNode(name: NameNode(value: 'name')),
              type: NamedTypeNode(
                  name: NameNode(value: 'String'), isNonNull: true),
              defaultValue: DefaultValueNode(value: null),
              directives: [])
        ],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
              name: NameNode(value: 'createTeam'),
              alias: null,
              arguments: [
                ArgumentNode(
                    name: NameNode(value: 'input'),
                    value: ObjectValueNode(fields: [
                      ObjectFieldNode(
                          name: NameNode(value: 'name'),
                          value: VariableNode(name: NameNode(value: 'name')))
                    ]))
              ],
              directives: [],
              selectionSet: SelectionSetNode(selections: [
                FieldNode(
                    name: NameNode(value: 'team'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: SelectionSetNode(selections: [
                      FieldNode(
                          name: NameNode(value: 'name'),
                          alias: null,
                          arguments: [],
                          directives: [],
                          selectionSet: null)
                    ])),
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
        ])),
    OperationDefinitionNode(
        type: OperationType.mutation,
        name: NameNode(value: 'JoinTeam'),
        variableDefinitions: [
          VariableDefinitionNode(
              variable: VariableNode(name: NameNode(value: 'teamId')),
              type:
                  NamedTypeNode(name: NameNode(value: 'Int'), isNonNull: true),
              defaultValue: DefaultValueNode(value: null),
              directives: [])
        ],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
              name: NameNode(value: 'joinTeam'),
              alias: null,
              arguments: [
                ArgumentNode(
                    name: NameNode(value: 'teamId'),
                    value: VariableNode(name: NameNode(value: 'teamId')))
              ],
              directives: [],
              selectionSet: SelectionSetNode(selections: [
                FieldNode(
                    name: NameNode(value: 'team'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: SelectionSetNode(selections: [
                      FieldNode(
                          name: NameNode(value: 'name'),
                          alias: null,
                          arguments: [],
                          directives: [],
                          selectionSet: null)
                    ]))
              ]))
        ]))
  ]);

  @override
  final String operationName = 'ListTeams';

  @override
  List<Object> get props => [document, operationName];
  @override
  ListTeams$Query parse(Map<String, dynamic> json) =>
      ListTeams$Query.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class CreateTeamArguments extends JsonSerializable with EquatableMixin {
  CreateTeamArguments({@required this.name});

  @override
  factory CreateTeamArguments.fromJson(Map<String, dynamic> json) =>
      _$CreateTeamArgumentsFromJson(json);

  final String name;

  @override
  List<Object> get props => [name];
  @override
  Map<String, dynamic> toJson() => _$CreateTeamArgumentsToJson(this);
}

class CreateTeamMutation
    extends GraphQLQuery<CreateTeam$Mutation, CreateTeamArguments> {
  CreateTeamMutation({this.variables});

  @override
  final DocumentNode document = DocumentNode(definitions: [
    OperationDefinitionNode(
        type: OperationType.query,
        name: NameNode(value: 'ListUserTeams'),
        variableDefinitions: [],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
              name: NameNode(value: 'myTeams'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: SelectionSetNode(selections: [
                FieldNode(
                    name: NameNode(value: 'id'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null)
              ]))
        ])),
    OperationDefinitionNode(
        type: OperationType.query,
        name: NameNode(value: 'ListTeams'),
        variableDefinitions: [],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
              name: NameNode(value: 'teams'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: SelectionSetNode(selections: [
                FieldNode(
                    name: NameNode(value: 'id'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null),
                FieldNode(
                    name: NameNode(value: 'name'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null),
                FieldNode(
                    name: NameNode(value: 'createdBy'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: SelectionSetNode(selections: [
                      FieldNode(
                          name: NameNode(value: 'username'),
                          alias: null,
                          arguments: [],
                          directives: [],
                          selectionSet: null)
                    ]))
              ]))
        ])),
    OperationDefinitionNode(
        type: OperationType.mutation,
        name: NameNode(value: 'CreateTeam'),
        variableDefinitions: [
          VariableDefinitionNode(
              variable: VariableNode(name: NameNode(value: 'name')),
              type: NamedTypeNode(
                  name: NameNode(value: 'String'), isNonNull: true),
              defaultValue: DefaultValueNode(value: null),
              directives: [])
        ],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
              name: NameNode(value: 'createTeam'),
              alias: null,
              arguments: [
                ArgumentNode(
                    name: NameNode(value: 'input'),
                    value: ObjectValueNode(fields: [
                      ObjectFieldNode(
                          name: NameNode(value: 'name'),
                          value: VariableNode(name: NameNode(value: 'name')))
                    ]))
              ],
              directives: [],
              selectionSet: SelectionSetNode(selections: [
                FieldNode(
                    name: NameNode(value: 'team'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: SelectionSetNode(selections: [
                      FieldNode(
                          name: NameNode(value: 'name'),
                          alias: null,
                          arguments: [],
                          directives: [],
                          selectionSet: null)
                    ])),
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
        ])),
    OperationDefinitionNode(
        type: OperationType.mutation,
        name: NameNode(value: 'JoinTeam'),
        variableDefinitions: [
          VariableDefinitionNode(
              variable: VariableNode(name: NameNode(value: 'teamId')),
              type:
                  NamedTypeNode(name: NameNode(value: 'Int'), isNonNull: true),
              defaultValue: DefaultValueNode(value: null),
              directives: [])
        ],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
              name: NameNode(value: 'joinTeam'),
              alias: null,
              arguments: [
                ArgumentNode(
                    name: NameNode(value: 'teamId'),
                    value: VariableNode(name: NameNode(value: 'teamId')))
              ],
              directives: [],
              selectionSet: SelectionSetNode(selections: [
                FieldNode(
                    name: NameNode(value: 'team'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: SelectionSetNode(selections: [
                      FieldNode(
                          name: NameNode(value: 'name'),
                          alias: null,
                          arguments: [],
                          directives: [],
                          selectionSet: null)
                    ]))
              ]))
        ]))
  ]);

  @override
  final String operationName = 'CreateTeam';

  @override
  final CreateTeamArguments variables;

  @override
  List<Object> get props => [document, operationName, variables];
  @override
  CreateTeam$Mutation parse(Map<String, dynamic> json) =>
      CreateTeam$Mutation.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class JoinTeamArguments extends JsonSerializable with EquatableMixin {
  JoinTeamArguments({@required this.teamId});

  @override
  factory JoinTeamArguments.fromJson(Map<String, dynamic> json) =>
      _$JoinTeamArgumentsFromJson(json);

  final int teamId;

  @override
  List<Object> get props => [teamId];
  @override
  Map<String, dynamic> toJson() => _$JoinTeamArgumentsToJson(this);
}

class JoinTeamMutation
    extends GraphQLQuery<JoinTeam$Mutation, JoinTeamArguments> {
  JoinTeamMutation({this.variables});

  @override
  final DocumentNode document = DocumentNode(definitions: [
    OperationDefinitionNode(
        type: OperationType.query,
        name: NameNode(value: 'ListUserTeams'),
        variableDefinitions: [],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
              name: NameNode(value: 'myTeams'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: SelectionSetNode(selections: [
                FieldNode(
                    name: NameNode(value: 'id'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null)
              ]))
        ])),
    OperationDefinitionNode(
        type: OperationType.query,
        name: NameNode(value: 'ListTeams'),
        variableDefinitions: [],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
              name: NameNode(value: 'teams'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: SelectionSetNode(selections: [
                FieldNode(
                    name: NameNode(value: 'id'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null),
                FieldNode(
                    name: NameNode(value: 'name'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null),
                FieldNode(
                    name: NameNode(value: 'createdBy'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: SelectionSetNode(selections: [
                      FieldNode(
                          name: NameNode(value: 'username'),
                          alias: null,
                          arguments: [],
                          directives: [],
                          selectionSet: null)
                    ]))
              ]))
        ])),
    OperationDefinitionNode(
        type: OperationType.mutation,
        name: NameNode(value: 'CreateTeam'),
        variableDefinitions: [
          VariableDefinitionNode(
              variable: VariableNode(name: NameNode(value: 'name')),
              type: NamedTypeNode(
                  name: NameNode(value: 'String'), isNonNull: true),
              defaultValue: DefaultValueNode(value: null),
              directives: [])
        ],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
              name: NameNode(value: 'createTeam'),
              alias: null,
              arguments: [
                ArgumentNode(
                    name: NameNode(value: 'input'),
                    value: ObjectValueNode(fields: [
                      ObjectFieldNode(
                          name: NameNode(value: 'name'),
                          value: VariableNode(name: NameNode(value: 'name')))
                    ]))
              ],
              directives: [],
              selectionSet: SelectionSetNode(selections: [
                FieldNode(
                    name: NameNode(value: 'team'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: SelectionSetNode(selections: [
                      FieldNode(
                          name: NameNode(value: 'name'),
                          alias: null,
                          arguments: [],
                          directives: [],
                          selectionSet: null)
                    ])),
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
        ])),
    OperationDefinitionNode(
        type: OperationType.mutation,
        name: NameNode(value: 'JoinTeam'),
        variableDefinitions: [
          VariableDefinitionNode(
              variable: VariableNode(name: NameNode(value: 'teamId')),
              type:
                  NamedTypeNode(name: NameNode(value: 'Int'), isNonNull: true),
              defaultValue: DefaultValueNode(value: null),
              directives: [])
        ],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
              name: NameNode(value: 'joinTeam'),
              alias: null,
              arguments: [
                ArgumentNode(
                    name: NameNode(value: 'teamId'),
                    value: VariableNode(name: NameNode(value: 'teamId')))
              ],
              directives: [],
              selectionSet: SelectionSetNode(selections: [
                FieldNode(
                    name: NameNode(value: 'team'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: SelectionSetNode(selections: [
                      FieldNode(
                          name: NameNode(value: 'name'),
                          alias: null,
                          arguments: [],
                          directives: [],
                          selectionSet: null)
                    ]))
              ]))
        ]))
  ]);

  @override
  final String operationName = 'JoinTeam';

  @override
  final JoinTeamArguments variables;

  @override
  List<Object> get props => [document, operationName, variables];
  @override
  JoinTeam$Mutation parse(Map<String, dynamic> json) =>
      JoinTeam$Mutation.fromJson(json);
}
