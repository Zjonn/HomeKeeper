import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:home_keeper/pages/home/home_widget.dart';
import 'package:home_keeper/providers/tasks_provider/tasks_provider.dart';
import 'package:home_keeper/widgets/container.dart';
import 'package:home_keeper/widgets/loading.dart';
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
            .toList(growable: false);

        return ListView.separated(
            padding: EdgeInsets.fromLTRB(5, 40, 5, 20),
            separatorBuilder: (BuildContext context, int index) =>
                const SizedBox(height: 5.0),
            itemCount: lastEvents.length > 0 ? lastEvents.length : 1,
            itemBuilder: (BuildContext context, int index) {
              if (lastEvents.length == 0) {
                return CommonContainer(
                    child: Text(
                  "Nothing intresting happend so far 😔\nComplete some tasks 😉",
                  textAlign: TextAlign.center,
                ));
              }
              return HomeWidget(lastEvents[index]);
            });
    }
  }
}
