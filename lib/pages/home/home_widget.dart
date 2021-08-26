import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home_keeper/providers/tasks_provider/task_completion.dart';
import 'package:home_keeper/providers/teams_provider/teams_provider.dart';
import 'package:home_keeper/widgets/container.dart';
import 'package:provider/provider.dart';

class HomeWidget extends StatefulWidget {
  final TaskCompletion completion;

  HomeWidget(this.completion);

  @override
  State<StatefulWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  @override
  Widget build(BuildContext context) {
    TeamProvider teamProvider = Provider.of<TeamProvider>(context);
    final completion = widget.completion;

    final completedBy = teamProvider.currentTeamInfo.teamMembers.firstWhere(
        (element) => element.username == completion.userWhoCompletedTask);
    final taskName = completion.relatedTaskInstance.relatedTask.name;
    final grantedPoints = completion.grantedPoints;

    return CommonContainer(
        child: RichText(
            text: TextSpan(children: <TextSpan>[
      TextSpan(
        text: '${completedBy.username} ',
        style: TextStyle(color: completedBy.color),
      ),
      TextSpan(text: 'completed task '),
      TextSpan(
          text: '${taskName}', style: TextStyle(fontStyle: FontStyle.italic)),
      TextSpan(text: '. '),
      TextSpan(text: '${grantedPoints}', style: TextStyle(color: Colors.amber)),
      TextSpan(text: ' points granted')
    ])));
  }
}
//Color(0xff0293ee)
