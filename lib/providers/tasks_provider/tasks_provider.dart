import 'package:artemis/client.dart';
import 'package:artemis/schema/graphql_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:home_keeper/abstracts/graphql_result.dart';
import 'package:home_keeper/graphql/graphql_api.dart';
import 'package:home_keeper/providers/tasks_provider/task.dart';
import 'package:home_keeper/providers/tasks_provider/task_completion.dart';
import 'package:home_keeper/providers/tasks_provider/task_instance.dart';

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

enum TasksState { InProgress, Initialized }

class TasksProvider with ChangeNotifier {
  late final ArtemisClient _client;

  TasksState _state = TasksState.InProgress;
  Map<String, Task> _tasks = {};
  Map<String, TaskInstance> _taskInstances = {};
  Map<String, TaskCompletion> _taskCompletions = {};

  TasksState get state => _state;

  Map<String, Task> get tasks => _tasks;

  Map<String, TaskInstance> get taskInstances => _taskInstances;

  Map<String, TaskCompletion> get taskCompletions => _taskCompletions;

  TasksProvider(this._client);

  void update(String teamId) {
    Future.wait([
      updateTasks(teamId),
      updateTaskInstances(teamId),
      updateTaskCompletions(teamId)
    ]).then((value) {
      _state = TasksState.Initialized;
      notifyListeners();
    });
  }

  Future<void> updateTasks(String teamId) async {
    GraphQLResponse<ListTasks$Query> response = await _client.execute(
        ListTasksQuery(
            variables: ListTasksArguments(teamId: int.parse(teamId))));
    assert(!response.hasErrors, response.errors.toString());

    Map<String, Task> tasks_ = {
      for (var task in response.data!.tasks ?? []) task.id: Task.fromResp(task!)
    };

    if (mapEquals<String, Task>(_tasks, tasks_)) {
      return;
    }

    _tasks = tasks_;
    notifyListeners();
  }

  Future<void> updateTaskInstances(String teamId) async {
    GraphQLResponse<ListTasksInstances$Query> response = await _client.execute(
        ListTasksInstancesQuery(
            variables: ListTasksInstancesArguments(teamId: int.parse(teamId))));
    assert(!response.hasErrors, response.errors.toString());

    Map<String, TaskInstance> taskInstances_ = {
      for (var task in response.data!.taskInstances ?? [])
        task.id: TaskInstance.fromResp(task)
    };

    if (mapEquals<String, TaskInstance>(_taskInstances, taskInstances_)) {
      return;
    }

    _taskInstances = taskInstances_;
    notifyListeners();
  }

  Future<void> updateTaskCompletions(String teamId) async {
    GraphQLResponse<ListTasksCompletions$Query> response =
        await _client.execute(ListTasksCompletionsQuery(
            variables:
                ListTasksCompletionsArguments(teamId: int.parse(teamId))));
    assert(!response.hasErrors, response.errors.toString());

    Map<String, TaskCompletion> taskCompletions_ = {
      for (var completion in response.data!.completions ?? [])
        completion.id: TaskCompletion.fromResp(completion)
    };
    print(response.data!.completions);

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

    if (result.isSuccessful) {
      final task = response.data!.createTask!.task!;
      _tasks[task.id] = Task.fromCreateResp(task);
      updateTaskInstances(teamId);
    }

    return result;
  }

  Future<TaskCompleteResult> completeTask(
      String instanceId, String teamId) async {
    GraphQLResponse<CompleteTask$Mutation> response = await _client.execute(
        CompleteTaskMutation(
            variables: CompleteTaskArguments(
                input: TaskInstanceCompletionCreateGenericType(
                    taskInstance: instanceId))));

    final result = TaskCompleteResult(response);

    if (result.isSuccessful) {
      final completion = TaskCompletion.fromCompleteResp(
          response.data!.submitTaskInstanceCompletion!.taskInstanceCompletion!);
      _taskCompletions[completion.id] = completion;

      final taskInstance = completion.relatedTaskInstance;
      _taskInstances.remove(taskInstance.id);
      notifyListeners();
    }

    return result;
  }
}
