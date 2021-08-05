import 'package:home_keeper/graphql/graphql_api.dart';
import 'package:home_keeper/providers/tasks_provider/task.dart';
import 'package:home_keeper/providers/tasks_provider/task_instance.dart';

class TaskCompletion {
  late final String id;
  late final String userWhoCompletedTaskId;
  late final int grantedPoints;

  late final TaskInstance relatedTaskInstance;
  late final DateTime modifiedTime;

  TaskCompletion(this.id, this.userWhoCompletedTaskId, this.grantedPoints,
      this.modifiedTime, this.relatedTaskInstance);

  TaskCompletion.fromResp(
      ListTasksCompletions$Query$TaskInstanceCompletionType resp)
      : this(
            resp.id,
            resp.userWhoCompletedTask.id,
            resp.pointsGranted,
            resp.modifiedAt,
            TaskInstance(
                resp.taskInstance.id,
                resp.taskInstance.active ?? false,
                Task(
                    resp.taskInstance.task.id,
                    resp.taskInstance.task.name,
                    resp.taskInstance.task.description,
                    resp.taskInstance.task.basePointsPrize),
                resp.taskInstance.activeFrom));

  TaskCompletion.fromCompleteResp(
      CompleteTask$Mutation$SubmitTaskInstanceCompletionPayload$TaskInstanceCompletionType
          resp)
      : this(
            resp.id,
            resp.userWhoCompletedTask.id,
            resp.pointsGranted,
            resp.modifiedAt,
            TaskInstance(
                resp.taskInstance.id,
                resp.taskInstance.active ?? false,
                Task(
                    resp.taskInstance.task.id,
                    resp.taskInstance.task.name,
                    resp.taskInstance.task.description,
                    resp.taskInstance.task.basePointsPrize),
                resp.taskInstance.activeFrom));
}
