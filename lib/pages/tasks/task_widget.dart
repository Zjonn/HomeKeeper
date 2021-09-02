import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home_keeper/providers/tasks_provider/task_instance.dart';
import 'package:home_keeper/providers/tasks_provider/tasks_provider.dart';
import 'package:home_keeper/widgets/button.dart';
import 'package:home_keeper/widgets/container.dart';
import 'package:home_keeper/widgets/flushbar.dart';
import 'package:provider/provider.dart';

class TaskWidget extends StatefulWidget {
  final TaskInstance task;

  TaskWidget(this.task);

  @override
  State<StatefulWidget> createState() => _TaskWidgetState();
}

enum _State { Default, Expanded, Finalize }

class _TaskWidgetState extends State<TaskWidget> {
  static const DAYS_TO_RANK_UP = 14;

  _State _isExpanded = _State.Default;

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TasksProvider>(context);
    final task = widget.task;

    final elapsedTime = DateTime.now().difference(task.activeFrom);
    final percentToRankUp =
        (elapsedTime.inDays / DAYS_TO_RANK_UP).clamp(0.0, 1.0);

    final points = task.relatedTask.points;
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
        height: _isExpanded == _State.Expanded ? 100 : 0,
        child: _isExpanded == _State.Expanded
            ? Center(
                child: Column(
                  children: [
                    Divider(),
                    Expanded(
                        child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        CommonIconButton(
                          Icon(Icons.edit),
                          onLongPress: () => {
                            Navigator.pushNamed(context, 'update_task',
                                arguments: widget.task.relatedTask)
                          },
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                              child: Text(
                            task.relatedTask.description,
                            textAlign: TextAlign.center,
                          )),
                        ),
                        CommonIconButton(
                          Icon(Icons.delete),
                          onLongPress: () async {
                            if (await taskProvider
                                .deleteTask(task.relatedTask)) {
                              CommonFlushbar(
                                      'Task ${task.relatedTask.name} deleted')
                                  .show(context);
                            } else {
                              SOMETHING_WENT_WRONG_FLUSHBAR
                                  .show(context);
                            }
                          },
                          color: Colors.red,
                        ),
                      ],
                    ))
                  ],
                ),
              )
            : SizedBox.shrink());

    final onComplete = () async {
      final resp = await taskProvider.completeTask(task);
      if (resp.isSuccessful) {
        CommonFlushbar(
                "${task.relatedTask.name} completed. Granted ${resp.grantedPoints} points!")
            .show(context);
      }
    };

    final completeAnimatedContainer = AnimatedContainer(
        duration: const Duration(seconds: 1),
        curve: Curves.fastOutSlowIn,
        width: _isExpanded == _State.Finalize ? 80 : 0,
        child: _isExpanded == _State.Finalize
            ? CommonIconButton(Icon(Icons.check), onPressed: onComplete)
            : SizedBox.shrink());

    return CommonContainerWithInkWell(
        onTap: () {
          setState(() {
            _isExpanded = _isExpanded == _State.Default
                ? _State.Expanded
                : _State.Default;
          });
        },
        onLongPress: () {
          setState(() {
            _isExpanded = _isExpanded != _State.Finalize
                ? _State.Finalize
                : _State.Default;
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
                    task.relatedTask.name,
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
