import 'package:artemis/schema/graphql_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:home_keeper/config/client.dart';
import 'package:home_keeper/graphql/graphql_api.dart';
import 'package:home_keeper/providers/tasks_provider/results.dart';
import 'package:home_keeper/providers/tasks_provider/task.dart';
import 'package:home_keeper/providers/tasks_provider/task_completion.dart';
import 'package:home_keeper/providers/tasks_provider/task_instance.dart';

enum TasksProviderState { Uninitialized, Initialized }

class TasksProvider with ChangeNotifier {
  late final ArtemisClientWithTimeout _client;
  late String _teamId;

  TasksProviderState _state = TasksProviderState.Uninitialized;

  Map<String, TaskInstance> _taskInstances = {};
  Map<String, TaskCompletion> _taskCompletions = {};

  TasksProviderState get state => _state;

  Map<String, TaskInstance> get taskInstances => _taskInstances;

  Map<String, TaskCompletion> get taskCompletions => _taskCompletions;

  TasksProvider(this._client);

  void update(String teamId) async {
    _teamId = teamId;

    await Future.wait([_updateTaskInstances(), _updateTaskCompletions()]);
    _state = TasksProviderState.Initialized;
    notifyListeners();
  }

  Future<void> _updateTaskInstances() async {
    GraphQLResponse<ListTasksInstances$Query> response = await _client.execute(
        ListTasksInstancesQuery(
            variables:
                ListTasksInstancesArguments(teamId: int.parse(_teamId))));

    if (response.hasErrors) {
      return;
    }

    Map<String, TaskInstance> taskInstances_ = {
      for (var instance in response.data!.taskInstances ??
          List<ListTasksInstances$Query$TaskInstanceType?>.empty())
        instance!.id: TaskInstance.fromResp(instance)
    };

    if (mapEquals<String, TaskInstance>(_taskInstances, taskInstances_)) {
      return;
    }

    _taskInstances = taskInstances_;
    notifyListeners();
  }

  Future<void> _updateTaskCompletions() async {
    GraphQLResponse<ListTasksCompletions$Query> response =
        await _client.execute(ListTasksCompletionsQuery(
            variables:
                ListTasksCompletionsArguments(teamId: int.parse(_teamId))));

    if (response.hasErrors) {
      return;
    }

    Map<String, TaskCompletion> taskCompletions_ = {
      for (var completion in response.data!.completions ??
          List<ListTasksCompletions$Query$TaskInstanceCompletionType?>.empty())
        completion!.id: TaskCompletion.fromResp(completion)
    };

    if (mapEquals<String, TaskCompletion>(_taskCompletions, taskCompletions_)) {
      return;
    }

    _taskCompletions = taskCompletions_;
    notifyListeners();
  }

  Future<TaskCreateResult> createTask(String name, String? description,
      int points, String teamId, int? refreshInterval, bool isRecurring) async {
    GraphQLResponse<CreateTask$Mutation> response = await _client.execute(
        CreateTaskMutation(
            variables: CreateTaskArguments(
                input: TaskCreateGenericType(
                    name: name,
                    description: description,
                    team: teamId,
                    basePointsPrize: points,
                    refreshInterval: refreshInterval != null
                        ? refreshInterval * 24.0 * 60 * 60
                        : null,
                    isRecurring: isRecurring))));

    final result = TaskCreateResult(response);
    await _updateTaskInstances();
    return result;
  }

  Future<TaskCompleteResult> completeTask(TaskInstance taskInstance) async {
    GraphQLResponse<CompleteTask$Mutation> response = await _client.execute(
        CompleteTaskMutation(
            variables: CompleteTaskArguments(
                input: TaskInstanceCompletionCreateGenericType(
                    taskInstance: taskInstance.id))));

    final result = TaskCompleteResult(response);
    await _updateTaskInstances();
    await _updateTaskCompletions();
    return result;
  }

  Future<bool> updateTask(String id, String name, String? description,
      int points, int? refreshInterval, bool isRecurring) async {
    GraphQLResponse<UpdateTask$Mutation> response = await _client.execute(
        UpdateTaskMutation(
            variables: UpdateTaskArguments(
                input: TaskUpdateGenericType(
                    id: id,
                    name: name,
                    description: description,
                    basePointsPrize: points,
                    refreshInterval: refreshInterval != null
                        ? refreshInterval * 24.0 * 60 * 60
                        : null,
                    isRecurring: isRecurring))));

    final result = TaskUpdateResult(response);
    await _updateTaskInstances();
    return result.isSuccessful && result.isUpdated!;
  }

  Future<bool> deleteTask(Task task) async {
    GraphQLResponse<DeleteTask$Mutation> response = await _client.execute(
        DeleteTaskMutation(variables: DeleteTaskArguments(id: task.id)));
    final result = TaskDeleteResult(response);
    await _updateTaskInstances();
    return result.isSuccessful && result.isDeleted!;
  }

  Future<bool> removeTaskCompletion(TaskCompletion completion) async {
    GraphQLResponse<RevokeTaskCompletion$Mutation> response =
        await _client.execute(RevokeTaskCompletionMutation(
            variables: RevokeTaskCompletionArguments(id: completion.id)));
    final result = RevokeTaskCompletionResult(response);
    await _updateTaskCompletions();
    return result.isSuccessful && result.isRevoked!;
  }
}
