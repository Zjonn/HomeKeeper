import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home_keeper/providers/tasks_provider/task_completion.dart';
import 'package:home_keeper/providers/tasks_provider/tasks_provider.dart';
import 'package:home_keeper/providers/teams_provider/teams_provider.dart';
import 'package:home_keeper/widgets/button.dart';
import 'package:home_keeper/widgets/container.dart';
import 'package:provider/provider.dart';

class HomeWidget extends StatefulWidget {
  final TaskCompletion completion;

  HomeWidget(this.completion);

  @override
  State<StatefulWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  bool _deleteState = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
        duration: const Duration(seconds: 1),
        child: _deleteState ? _delete(context) : _info(context));
  }

  Widget _info(BuildContext context) {
    TeamProvider teamProvider = Provider.of<TeamProvider>(context);
    final completion = widget.completion;

    final completedBy = teamProvider.currentTeamInfo.teamMembers.firstWhere(
        (element) => element.username == completion.userWhoCompletedTask);
    final taskName = completion.relatedTaskInstance.relatedTask.name;
    final grantedPoints = completion.grantedPoints;

    return CommonContainerWithInkWell(
        onLongPress: () => setState(() {
              _deleteState = true;
            }),
        child: RichText(
            text: TextSpan(children: <TextSpan>[
          TextSpan(
            text: '${completedBy.username} ',
            style: TextStyle(color: completedBy.color),
          ),
          TextSpan(text: 'completed task '),
          TextSpan(
              text: '${taskName}',
              style: TextStyle(fontStyle: FontStyle.italic)),
          TextSpan(text: '. '),
          TextSpan(
              text: '${grantedPoints}', style: TextStyle(color: Colors.amber)),
          TextSpan(text: ' points granted')
        ])));
  }

  Widget _delete(BuildContext context) {
    TasksProvider tasksProvider = Provider.of<TasksProvider>(context);

    return CommonContainer(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CommonIconButton(
          Icon(Icons.check),
          onPressed: () async {
            await tasksProvider.removeTaskCompletion(widget.completion);
          },
        ),
        Text("Do you want to revoke completion?"),
        CommonIconButton(Icon(Icons.clear_rounded),
            onPressed: () => setState(() {
                  _deleteState = false;
                }))
      ],
    ));
  }
}
//Color(0xff0293ee)
