import 'package:artemis/schema/graphql_response.dart';
import 'package:home_keeper/graphql/graphql_api.dart';

class JoinResult {
  final bool status;
  final GraphQLResponse<JoinTeam$Mutation> response;

  JoinResult(this.status, this.response);
}
