import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:home_keeper/providers/tasks_provider/tasks_provider.dart';
import 'package:home_keeper/widgets/container.dart';
import 'package:home_keeper/widgets/loading.dart';
import 'package:intersperse/intersperse.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Home();
}

class _Home extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TasksProvider>(context);

    switch (taskProvider.state) {
      case TasksState.InProgress:
        return Loading();
      case TasksState.Initialized:
        var lastEvents = taskProvider.taskCompletions.entries
            .map((e) => e.value)
            .map<Widget>((e) => CommonContainer(
                child: Text('${e.userWhoCompletedTask} completed '
                    '${e.relatedTaskInstance.relatedTask.name} '
                    'at ${e.completedAt}. '
                    '${e.grantedPoints} points granted.')))
            .intersperse(SizedBox(height: 5.0))
            .toList();

        if (lastEvents.isEmpty) {
          lastEvents.add(CommonContainer(
              child: Text(
            "Nothing intresting happend so far 😔\nComplete some tasks 😉",
            textAlign: TextAlign.center,
          )));
        }

        return SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(5, 40, 5, 20),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: lastEvents),
        );
    }
    ;
  }
}
