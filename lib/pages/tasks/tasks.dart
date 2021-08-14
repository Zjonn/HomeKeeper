import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:home_keeper/pages/tasks/task_widget.dart';
import 'package:home_keeper/providers/tasks_provider/tasks_provider.dart';
import 'package:home_keeper/widgets/loading.dart';
import 'package:provider/provider.dart';

class Tasks extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  static const SCROLL_OFFSET = 600.0;

  @override
  Widget build(BuildContext context) {
    TasksProvider tasksProvider = Provider.of<TasksProvider>(context);

    switch (tasksProvider.state) {
      case TasksState.InProgress:
        return Loading();
      case TasksState.Initialized:
        final inactiveTasks = tasksProvider.taskInstances.entries
            .map((e) => e.value)
            .where((element) => !element.isActive);
        final activeTasks = tasksProvider.taskInstances.entries
            .map((e) => e.value)
            .where((element) => element.isActive);

        final sortedTasks =
            activeTasks.followedBy(inactiveTasks).toList(growable: false);

        final tasksList = ListView.separated(
            padding: EdgeInsets.fromLTRB(5, 40, 5, 20),
            reverse: true,
            separatorBuilder: (BuildContext context, int index) =>
                const SizedBox(height: 5.0),
            itemCount: sortedTasks.length + 2,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return SizedBox(height: 100);
              }
              if (index == sortedTasks.length + 1) {
                return SizedBox(height: SCROLL_OFFSET);
              }
              return TaskPage(sortedTasks[index - 1]);
            });

        final addButton = Align(
            alignment: AlignmentDirectional.bottomCenter,
            child: Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'create_task');
                  },
                  child: Icon(Icons.add),
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Theme.of(context).accentColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(360),
                      side:
                          BorderSide(color: Theme.of(context).backgroundColor)),
                )));

        return Stack(
          children: [tasksList, addButton],
        );
    }
  }
}
