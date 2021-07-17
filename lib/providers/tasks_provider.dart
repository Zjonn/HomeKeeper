import 'package:artemis/client.dart';
import 'package:artemis/schema/graphql_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:home_keeper/graphql/graphql_api.dart';

class Task {
  Task.fromResp(ListTasks$Query$TaskType resp) {}

  Task.fromCreateResp(CreateTask$Mutation$CreateTaskPayload$TaskType resp) {}
}

class TaskInstance {
  TaskInstance.fromResp(ListTasksInstances$Query$TaskInstanceType resp) {}
}

class TaskCompletion {
  TaskCompletion.fromResp(
      ListTasksCompletions$Query$TaskInstanceCompletionType resp) {}
}

class TaskCreateResult {
  bool status;

  GraphQLResponse<CreateTask$Mutation> response;

  TaskCreateResult(this.status, this.response);
}

class TasksProvider with ChangeNotifier {
  late final ArtemisClient _client;

  List<Task> tasks = [];
  List<TaskInstance> taskInstances = [];
  List<TaskCompletion> taskCompletions = [];

  TasksProvider(this._client);

  Future<void> updateUserTasks(int teamId) async {
    GraphQLResponse<ListTasks$Query> response = await _client
        .execute(ListTasksQuery(variables: ListTasksArguments(teamId: teamId)));
    assert(!response.hasErrors, response.errors.toString());

    List<Task> tasks_ = [
      for (var task in response.data!.tasks!) Task.fromResp(task!)
    ];

    if (listEquals<Task>(tasks, tasks_)) {
      return;
    }

    tasks = tasks_;
    notifyListeners();
  }

  Future<void> updateUserTaskInstances(int teamId) async {
    GraphQLResponse<ListTasksInstances$Query> response = await _client.execute(
        ListTasksInstancesQuery(
            variables: ListTasksInstancesArguments(teamId: teamId)));
    assert(!response.hasErrors, response.errors.toString());

    List<TaskInstance> taskInstances_ = [
      for (var task in response.data!.taskInstances!)
        TaskInstance.fromResp(task!)
    ];

    if (listEquals<TaskInstance>(taskInstances, taskInstances_)) {
      return;
    }

    taskInstances = taskInstances_;
    notifyListeners();
  }

  Future<void> updateUserTaskCompletions(int teamId) async {
    GraphQLResponse<ListTasksCompletions$Query> response =
        await _client.execute(ListTasksCompletionsQuery(
            variables: ListTasksCompletionsArguments(teamId: teamId)));
    assert(!response.hasErrors, response.errors.toString());

    List<TaskCompletion> taskCompletions_ = [
      for (var completion in response.data!.completions!)
        TaskCompletion.fromResp(completion!)
    ];

    if (listEquals<TaskCompletion>(taskCompletions, taskCompletions_)) {
      return;
    }

    taskCompletions = taskCompletions_;
    notifyListeners();
  }

  Future<TaskCreateResult> createTask(String name, String? description, int points,
      int teamId, String refreshInterval, bool isRecurring) async {
    GraphQLResponse<CreateTask$Mutation> response = await _client.execute(
        CreateTaskMutation(
            variables: CreateTaskArguments(
                input: CreateTaskInput(
                    name: name,
                    description: description,
                    team: teamId.toString(),
                    basePointsPrize: points,
                    refreshInterval: refreshInterval,
                    isRecurring: isRecurring))));

    if (!response.hasErrors &&
        (response.data!.createTask!.errors?.isEmpty ?? false)) {
      tasks.add(Task.fromCreateResp(response.data!.createTask!.task!));
      notifyListeners();
    }

    return TaskCreateResult(response.hasErrors, response);
  }
}
