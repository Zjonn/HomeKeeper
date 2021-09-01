import 'package:home_keeper/graphql/graphql_api.dart';
import 'package:home_keeper/providers/tasks_provider/task.dart';
import 'package:home_keeper/providers/tasks_provider/task_instance.dart';

class TaskCompletion {
  final String id;
  final String userWhoCompletedTask;
  final int grantedPoints;

  final TaskInstance relatedTaskInstance;
  final DateTime completedAt;

  TaskCompletion(this.id, this.userWhoCompletedTask, this.grantedPoints,
      this.completedAt, this.relatedTaskInstance);

  TaskCompletion.fromResp(
      ListTasksCompletions$Query$TaskInstanceCompletionType resp)
      : this(
            resp.id,
            resp.userWhoCompletedTask.username,
            resp.pointsGranted,
            resp.createdAt,
            TaskInstance(
                resp.taskInstance.id,
                resp.taskInstance.active ?? false,
                Task(
                    resp.taskInstance.task.id,
                    resp.taskInstance.task.name,
                    resp.taskInstance.task.description,
                    resp.taskInstance.task.basePointsPrize,
                    resp.taskInstance.task.isRecurring,
                    resp.taskInstance.task.refreshInterval),
                resp.taskInstance.activeFrom));

  TaskCompletion.fromCompleteResp(
      CompleteTask$Mutation$TaskInstanceCompletionSerializerMutation$TaskInstanceCompletionType
          resp)
      : this(
            resp.id,
            resp.userWhoCompletedTask.username,
            resp.pointsGranted,
            resp.createdAt,
            TaskInstance(
                resp.taskInstance.id,
                resp.taskInstance.active ?? false,
                Task(
                    resp.taskInstance.task.id,
                    resp.taskInstance.task.name,
                    resp.taskInstance.task.description,
                    resp.taskInstance.task.basePointsPrize,
                    resp.taskInstance.task.isRecurring,
                    resp.taskInstance.task.refreshInterval),
                resp.taskInstance.activeFrom));
}
