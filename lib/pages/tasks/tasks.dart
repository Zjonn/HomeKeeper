import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:home_keeper/pages/tasks/task.dart';
import 'package:home_keeper/providers/tasks_provider.dart';
import 'package:home_keeper/widgets/loading.dart';
import 'package:provider/provider.dart';
import 'package:intersperse/intersperse.dart';

class Tasks extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  static const SCROLL_OFFSET = 600.0;
  ScrollController _scrollController =
      ScrollController(initialScrollOffset: SCROLL_OFFSET);

  @override
  Widget build(BuildContext context) {
    TasksProvider tasksProvider = Provider.of<TasksProvider>(context);

    switch (tasksProvider.state) {
      case TasksState.InProgress:
        return Loading();
      case TasksState.Initialized:
        final activeTasks = Column(
          children: tasksProvider.taskInstances
              .where((element) => element.isActive)
              .map<Widget>((e) => TaskPage(e))
              .intersperse(SizedBox(height: 5.0))
              .toList(growable: false),
        );
        final inactiveTasks = Column(
          children: tasksProvider.taskInstances
              .where((element) => !element.isActive)
              .map<Widget>((e) => TaskPage(e))
              .intersperse(SizedBox(height: 5.0))
              .toList(growable: false),
        );

        return Stack(
          children: [
            SingleChildScrollView(
                controller: _scrollController,
                padding: EdgeInsets.fromLTRB(5, 40, 5, 20),
                child: Column(
                  children: [
                    SizedBox(
                      height: SCROLL_OFFSET,
                    ),
                    activeTasks,
                    inactiveTasks,
                    SizedBox(
                      height: 80,
                    )
                  ],
                )),
            Align(
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
                          side: BorderSide(
                              color: Theme.of(context).backgroundColor)),
                    )))
          ],
        );
    }
  }
}
