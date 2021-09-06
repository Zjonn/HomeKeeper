import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home_keeper/providers/tasks_provider/task_completion.dart';
import 'package:home_keeper/widgets/container.dart';

class InactiveHomeWidget extends StatelessWidget {
  final TaskCompletion completion;

  InactiveHomeWidget(this.completion);

  @override
  Widget build(BuildContext context) {
    final taskName = completion.relatedTaskInstance.relatedTask.name;
    final grantedPoints = completion.grantedPoints;
    final theme = Theme.of(context);

    return CommonContainer(
        color: theme.canvasColor,
        child: Text(
          '${completion.userWhoCompletedTask} completed task ${taskName}. '
          '${grantedPoints} points granted',
          style: TextStyle(color: theme.disabledColor),
        ));
  }
}
