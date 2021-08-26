import 'package:artemis/schema/graphql_response.dart';
import 'package:home_keeper/graphql/graphql_api.dart';

class CreateResult {
  final bool status;
  final GraphQLResponse<CreateTeam$Mutation> response;

  CreateResult(this.status, this.response);
}
