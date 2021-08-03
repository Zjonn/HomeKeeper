import 'package:artemis/client.dart';
import 'package:artemis/schema/graphql_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:home_keeper/abstracts/graphql_result.dart';
import 'package:home_keeper/graphql/graphql_api.dart';

class Task {
  late String id;
  late String name;
  late String description;

  late int points;
  late int duration;

  Task.fromResp(ListTasks$Query$TaskType resp) {
    id = resp.id;
    name = resp.name;
    description = resp.description;
    points = resp.basePointsPrize;
  }

  Task.fromCreateResp(CreateTask$Mutation$CreateTaskPayload$TaskType resp) {
    id = resp.id;
    name = resp.name;
    description = resp.description;
    points = resp.basePointsPrize;
  }
}

class TaskInstance {
  late final String id;
  late final bool isActive;
  late final Task relatedTask;
  late final DateTime activeFrom;

  TaskInstance.fromResp(ListTasksInstances$Query$TaskInstanceType resp,
      final Map<String, Task> tasks) {
    id = resp.id;
    isActive = resp.active!;
    activeFrom = resp.activeFrom;
    relatedTask = tasks[resp.task.id]!;
  }
}

class TaskCompletion {
  late final int grantedPoints;
  late final TaskInstance relatedTaskInstance;
  late final DateTime modifiedTime;
  late final String userId;

  TaskCompletion.fromResp(
      CompleteTask$Mutation$SubmitTaskInstanceCompletionPayload$TaskInstanceCompletionType
          resp,
      final List<TaskInstance> taskInstances) {
    grantedPoints = resp.pointsGranted;
    relatedTaskInstance = taskInstances
        .firstWhere((element) => element.id == resp.taskInstance.id);
    modifiedTime = resp.modifiedAt;
    userId = resp.userWhoCompletedTask.id;
  }
}

class TaskCreateResult
    extends GraphqlResult<GraphQLResponse<CreateTask$Mutation>> {
  TaskCreateResult(GraphQLResponse<CreateTask$Mutation> response)
      : super(response);

  @override
  bool parseResponse(GraphQLResponse<CreateTask$Mutation> response) {
    bool isError =
        response.hasErrors || response.data!.createTask!.errors!.isNotEmpty;

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
    return !isError;
  }
}

class TaskCompletionResult
    extends GraphqlResult<GraphQLResponse<CompleteTask$Mutation>> {
  late final int grantedPoints;

  TaskCompletionResult(GraphQLResponse<CompleteTask$Mutation> resp)
      : super(resp);

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
  List<TaskInstance> _taskInstances = [];
  List<TaskCompletion> _taskCompletions = [];

  TasksState get state => _state;
  Map<String, Task> get tasks => _tasks;
  List<TaskInstance> get taskInstances => _taskInstances;
  List<TaskCompletion> get taskCompletions => _taskCompletions;

  TasksProvider(this._client);

  void update(String teamId) {
    Future.wait([
      updateUserTasks(teamId),
      updateUserTaskInstances(teamId),
      updateUserTaskCompletions(teamId)
    ]).then((value) {
      _state = TasksState.Initialized;
      notifyListeners();
    });
  }

  Future<void> updateUserTasks(String teamId) async {
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

  Future<void> updateUserTaskInstances(String teamId) async {
    GraphQLResponse<ListTasksInstances$Query> response = await _client.execute(
        ListTasksInstancesQuery(
            variables: ListTasksInstancesArguments(teamId: int.parse(teamId))));
    assert(!response.hasErrors, response.errors.toString());

    List<TaskInstance> taskInstances_ = [
      for (var task in response.data!.taskInstances ?? [])
        TaskInstance.fromResp(task!, _tasks)
    ];

    if (listEquals<TaskInstance>(_taskInstances, taskInstances_)) {
      return;
    }

    _taskInstances = taskInstances_;
    notifyListeners();
  }

  Future<void> updateUserTaskCompletions(String teamId) async {
    GraphQLResponse<ListTasksCompletions$Query> response =
        await _client.execute(ListTasksCompletionsQuery(
            variables:
                ListTasksCompletionsArguments(teamId: int.parse(teamId))));
    assert(!response.hasErrors, response.errors.toString());

    List<TaskCompletion> taskCompletions_ = [
      for (var completion in response.data!.completions ?? [])
        TaskCompletion.fromResp(completion!, _taskInstances)
    ];

    if (listEquals<TaskCompletion>(_taskCompletions, taskCompletions_)) {
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
                input: CreateTaskInput(
                    name: name,
                    description: description,
                    team: teamId,
                    basePointsPrize: points,
                    refreshInterval:
                        refreshInterval != null ? "P${refreshInterval}D" : null,
                    isRecurring: isRecurring))));

    final result = TaskCreateResult(response);

    if (result.isSuccessful) {
      final task = response.data!.createTask!.task!;
      _tasks[task.id] = Task.fromCreateResp(task);
      updateUserTaskInstances(teamId);
    }

    return result;
  }

  Future<TaskCompletionResult> completeTask(
      String instanceId, String teamId) async {
    GraphQLResponse<CompleteTask$Mutation> response = await _client.execute(
        CompleteTaskMutation(
            variables: CompleteTaskArguments(
                input: SubmitTaskInstanceCompletionInput(
                    taskInstance: instanceId))));

    final result = TaskCompletionResult(response);

    if (result.isSuccessful) {
      final completion =
          response.data!.submitTaskInstanceCompletion!.taskInstanceCompletion!;
      _taskCompletions.add(TaskCompletion.fromResp(completion, taskInstances));

      updateUserTaskInstances(teamId);
      notifyListeners();
    }

    return result;
  }
}
