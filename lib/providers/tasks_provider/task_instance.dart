import 'package:home_keeper/graphql/graphql_api.dart';
import 'package:home_keeper/providers/tasks_provider/task.dart';

class TaskInstance {
  final String id;
  final bool isActive;
  final Task relatedTask;
  final DateTime activeFrom;

  TaskInstance(this.id, this.isActive, this.relatedTask, this.activeFrom);

  TaskInstance.fromResp(ListTasksInstances$Query$TaskInstanceType resp)
      : this(
            resp.id,
            resp.active ?? false,
            Task(resp.task.id, resp.task.name, resp.task.description,
                resp.task.basePointsPrize),
            resp.activeFrom);
}
