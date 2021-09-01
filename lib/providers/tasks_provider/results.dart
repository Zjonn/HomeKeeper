import 'package:artemis/schema/graphql_response.dart';
import 'package:home_keeper/abstracts/graphql_result.dart';
import 'package:home_keeper/graphql/graphql_api.dart';

class TaskCreateResult
    extends GraphqlResult<GraphQLResponse<CreateTask$Mutation>> {
  TaskCreateResult(GraphQLResponse<CreateTask$Mutation> response)
      : super(response);

  @override
  Iterable<GraphqlError> getDataErrors(
      GraphQLResponse<CreateTask$Mutation> response) {
    return response.data!.createTask!.errors?.map(
            (e) => GraphqlError(e!.messages.join('\n'), field: e.field)) ??
        [];
  }

  @override
  void parseData(GraphQLResponse<CreateTask$Mutation> response) {}
}

class TaskCompleteResult
    extends GraphqlResult<GraphQLResponse<CompleteTask$Mutation>> {
  late final int? grantedPoints;

  TaskCompleteResult(GraphQLResponse<CompleteTask$Mutation> resp) : super(resp);

  @override
  Iterable<GraphqlError> getDataErrors(
      GraphQLResponse<CompleteTask$Mutation> response) {
    return response.data!.submitTaskInstanceCompletion!.errors?.map(
            (e) => GraphqlError(e!.messages.join('\n'), field: e.field)) ??
        [];
  }

  @override
  void parseData(GraphQLResponse<CompleteTask$Mutation> response) {
    grantedPoints = response.data!.submitTaskInstanceCompletion!
        .taskInstanceCompletion!.pointsGranted;
  }
}

class TaskUpdateResult
    extends GraphqlResult<GraphQLResponse<UpdateTask$Mutation>> {
  late final String? teamId;
  late final bool? isUpdated;

  TaskUpdateResult(GraphQLResponse<UpdateTask$Mutation> response)
      : super(response);

  @override
  Iterable<GraphqlError> getDataErrors(
      GraphQLResponse<UpdateTask$Mutation> response) {
    return response.data!.updateTask!.errors?.map(
            (e) => GraphqlError(e!.messages.join('\n'), field: e.field)) ??
        [];
  }

  @override
  void parseData(GraphQLResponse<UpdateTask$Mutation> response) {
    var updateTask = response.data!.updateTask!;
    print(updateTask);
    teamId = updateTask.task!.team!.id;
    isUpdated = updateTask.ok!;
  }
}

class TaskDeleteResult
    extends GraphqlResult<GraphQLResponse<DeleteTask$Mutation>> {
  late final String? taskId;
  late final String? teamId;
  late final bool? isDeleted;

  TaskDeleteResult(GraphQLResponse<DeleteTask$Mutation> response)
      : super(response);

  @override
  Iterable<GraphqlError> getDataErrors(
      GraphQLResponse<DeleteTask$Mutation> response) {
    return response.data!.deleteTask!.errors?.map(
            (e) => GraphqlError(e!.messages.join('\n'), field: e.field)) ??
        [];
  }

  @override
  void parseData(GraphQLResponse<DeleteTask$Mutation> response) {
    var deleteTask = response.data!.deleteTask!;
    taskId = deleteTask.task!.id;
    teamId = deleteTask.task!.team!.id;
    isDeleted = deleteTask.ok!;
  }
}
