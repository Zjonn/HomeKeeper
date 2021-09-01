import 'package:artemis/schema/graphql_response.dart';
import 'package:home_keeper/abstracts/graphql_result.dart';
import 'package:home_keeper/graphql/graphql_api.dart';

class RegisterResult
    extends GraphqlResult<GraphQLResponse<RegisterUser$Mutation>> {
  RegisterResult(GraphQLResponse<RegisterUser$Mutation> response)
      : super(response);

  @override
  Iterable<GraphqlError> getDataErrors(
      GraphQLResponse<RegisterUser$Mutation> response) {
    return response.data!.register!.errors!
        .map((e) => GraphqlError(e!.messages.join('\n'), field: e.field));
  }

  @override
  void parseData(GraphQLResponse<RegisterUser$Mutation> response) {}
}

class LoginResult extends GraphqlResult<GraphQLResponse<LoginUser$Mutation>> {
  LoginResult(GraphQLResponse<LoginUser$Mutation> response) : super(response);

  @override
  Iterable<GraphqlError> getDataErrors(
      GraphQLResponse<LoginUser$Mutation> response) {
    return [];
  }

  @override
  void parseData(GraphQLResponse<LoginUser$Mutation> response) {}
}
