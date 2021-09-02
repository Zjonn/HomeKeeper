import 'package:artemis/schema/graphql_response.dart';
import 'package:home_keeper/abstracts/graphql_result.dart';
import 'package:home_keeper/graphql/graphql_api.dart';

class CreateResult extends GraphqlResult<GraphQLResponse<CreateTeam$Mutation>> {
  CreateResult(GraphQLResponse<CreateTeam$Mutation> response) : super(response);

  @override
  Iterable<GraphqlError> getDataErrors(
      GraphQLResponse<CreateTeam$Mutation> response) {
    return response.data!.createTeam!.errors!
        .map((e) => GraphqlError(e!.messages.join('\n'), field: e.field));
  }

  @override
  void parseData(GraphQLResponse<CreateTeam$Mutation> response) {}
}

class JoinResult extends GraphqlResult<GraphQLResponse<JoinTeam$Mutation>> {
  JoinResult(GraphQLResponse<JoinTeam$Mutation> response) : super(response);

  @override
  Iterable<GraphqlError> getDataErrors(
      GraphQLResponse<JoinTeam$Mutation> response) {
    return [];
  }

  @override
  void parseData(GraphQLResponse<JoinTeam$Mutation> response) {}
}

class LeaveResult extends GraphqlResult<GraphQLResponse<LeaveTeam$Mutation>> {
  LeaveResult(GraphQLResponse<LeaveTeam$Mutation> response) : super(response);

  @override
  Iterable<GraphqlError> getDataErrors(
      GraphQLResponse<LeaveTeam$Mutation> response) {
    return [];
  }

  @override
  void parseData(GraphQLResponse<LeaveTeam$Mutation> response) {}
}
