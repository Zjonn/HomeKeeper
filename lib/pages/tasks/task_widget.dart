import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home_keeper/providers/tasks_provider/task_instance.dart';
import 'package:home_keeper/providers/tasks_provider/tasks_provider.dart';
import 'package:home_keeper/providers/teams_provider.dart';
import 'package:home_keeper/widgets/button.dart';
import 'package:home_keeper/widgets/container.dart';
import 'package:home_keeper/widgets/flushbar.dart';
import 'package:provider/provider.dart';

class TaskPage extends StatefulWidget {
  final TaskInstance _task;

  TaskPage(this._task);

  @override
  State<StatefulWidget> createState() => _TaskPageState(_task);
}

enum _TaskState { Default, Expanded, Finalize }

class _TaskPageState extends State<TaskPage> {
  static const DAYS_TO_RANK_UP = 14;

  final TaskInstance _task;
  _TaskState _isExpanded = _TaskState.Default;

  _TaskPageState(this._task);

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TasksProvider>(context);
    final teamProvider = Provider.of<TeamProvider>(context);

    final elapsedTime = DateTime.now().difference(_task.activeFrom);
    final percentToRankUp =
    (elapsedTime.inDays / DAYS_TO_RANK_UP).clamp(0.0, 1.0);

    final points = _task.relatedTask.points;
    final pointsText = RichText(
        text: TextSpan(children: <TextSpan>[
          TextSpan(text: '${points} ${points == 1 ? 'point' : 'points'}'),
          TextSpan(
              text: '${percentToRankUp == 1 ? ' + bonus' : ''}',
          style: TextStyle(color: Colors.amber))
        ]));

    final durationColor = Color.lerp(
        Theme.of(context).textTheme.bodyText1!.color,
        Colors.red,
        percentToRankUp);
    final durationText = Text(
      'Age ${elapsedTime.inDays}D ${elapsedTime.inHours.remainder(24)}H',
      textAlign: TextAlign.left,
      style: TextStyle(color: durationColor),
    );

    final descriptionAnimatedContainer = AnimatedContainer(
        duration: const Duration(seconds: 1),
        curve: Curves.fastOutSlowIn,
        height: _isExpanded == _TaskState.Expanded ? 100 : 0,
        child: _isExpanded == _TaskState.Expanded
            ? Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Divider(),
                    Expanded(
                        child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        CommonIconButton(
                          Icon(Icons.edit),
                          onPressed: () => {},
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                              child: Text(
                            _task.relatedTask.description,
                            textAlign: TextAlign.center,
                          )),
                        ),
                        CommonIconButton(
                          Icon(Icons.delete),
                          onPressed: () => {},
                          color: Colors.red,
                        ),
                      ],
                    ))
                  ],
                ),
              )
            : SizedBox.shrink());

    final onComplete = () async {
      final resp = await taskProvider.completeTask(
          _task.id, teamProvider.currentTeamInfo.id);
      if (resp.isSuccessful) {
        CommonFlushbar(
                "${_task.relatedTask.name} completed. Granted ${resp.grantedPoints} points!")
            .show(context);
      }
    };

    final completeAnimatedContainer = AnimatedContainer(
        duration: const Duration(seconds: 1),
        curve: Curves.fastOutSlowIn,
        width: _isExpanded == _TaskState.Finalize ? 80 : 0,
        child: _isExpanded == _TaskState.Finalize
            ? CommonIconButton(Icon(Icons.check), onPressed: onComplete)
            : SizedBox.shrink());

    return CommonContainerWithInkWell(
        onTap: () {
          setState(() {
            _isExpanded = _isExpanded == _TaskState.Default
                ? _TaskState.Expanded
                : _TaskState.Default;
          });
        },
        onLongPress: () {
          setState(() {
            _isExpanded = _isExpanded != _TaskState.Finalize
                ? _TaskState.Finalize
                : _TaskState.Default;
          });
        },
        child: Row(
          children: [
            Expanded(
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        _task.relatedTask.name,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    Row(
                      children: [
                        pointsText,
                        Spacer(),
                        durationText,
                      ],
                    ),
                    descriptionAnimatedContainer
                  ],
                )),
            completeAnimatedContainer
          ],
        ));
  }
}
