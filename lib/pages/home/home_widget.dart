import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home_keeper/providers/tasks_provider/task_completion.dart';
import 'package:home_keeper/widgets/container.dart';

class HomeWidget extends StatefulWidget {
  final TaskCompletion _completion;

  HomeWidget(this._completion);

  @override
  State<StatefulWidget> createState() => _HomeWidgetState(_completion);
}

class _HomeWidgetState extends State<HomeWidget> {
  final TaskCompletion _completion;

  _HomeWidgetState(this._completion);

  @override
  Widget build(BuildContext context) {
    final completedBy = _completion.userWhoCompletedTask;
    final taskName = _completion.relatedTaskInstance.relatedTask.name;
    final grantedPoints = _completion.grantedPoints;

    return CommonContainer(
        child: RichText(
            text: TextSpan(children: <TextSpan>[
      TextSpan(
          text: '${completedBy} completed task '
              '${taskName}. '),
      TextSpan(text: '${grantedPoints}', style: TextStyle(color: Colors.amber)),
      TextSpan(text: ' points granted.')
    ])));
  }
}
