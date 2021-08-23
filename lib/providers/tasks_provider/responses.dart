import 'package:artemis/schema/graphql_response.dart';
import 'package:home_keeper/abstracts/graphql_result.dart';
import 'package:home_keeper/graphql/graphql_api.dart';

class TaskCreateResult
    extends GraphqlResult<GraphQLResponse<CreateTask$Mutation>> {
  TaskCreateResult(GraphQLResponse<CreateTask$Mutation> response)
      : super(response);

  @override
  bool parseResponse(GraphQLResponse<CreateTask$Mutation> response) {
    bool isError = response.hasErrors ||
        (response.data!.createTask!.errors?.isEmpty ?? false);

    if (isError) {
      if (response.hasErrors) {
        errors = response.errors!
            .map((e) => GraphqlError<String, String>(e.message))
            .join('\n');
      } else {
        errors = response.data!.createTask!.errors!
            .map((e) => GraphqlError<String, String>(e!.messages.join('\n'),
                field: e.field))
            .join('\n');
      }
    }
    return !isError;
  }
}

class TaskCompleteResult
    extends GraphqlResult<GraphQLResponse<CompleteTask$Mutation>> {
  late final int grantedPoints;

  TaskCompleteResult(GraphQLResponse<CompleteTask$Mutation> resp) : super(resp);

  @override
  bool parseResponse(GraphQLResponse<CompleteTask$Mutation> response) {
    bool isError = response.hasErrors;

    if (response.hasErrors) {
      errors = response.errors!
          .map((e) => GraphqlError<String, String>(e.message))
          .join('\n');
    } else {
      grantedPoints = response.data!.submitTaskInstanceCompletion!
          .taskInstanceCompletion!.pointsGranted;
    }

    return !isError;
  }
}

class TaskDeleteResult
    extends GraphqlResult<GraphQLResponse<DeleteTask$Mutation>> {
  late final String taskId;
  late final bool isDeleted;
  late final String teamId;

  TaskDeleteResult(GraphQLResponse<DeleteTask$Mutation> response)
      : super(response);

  @override
  bool parseResponse(GraphQLResponse<DeleteTask$Mutation> response) {
    bool isError = response.hasErrors;

    if (response.hasErrors) {
      errors = response.errors!
          .map((e) => GraphqlError<String, String>(e.message))
          .join('\n');
    } else {
      taskId = response.data!.deleteTask!.task!.id;
      teamId = response.data!.deleteTask!.task!.team!.id;
      isDeleted = response.data!.deleteTask!.ok!;
    }

    return !isError;
  }
}
