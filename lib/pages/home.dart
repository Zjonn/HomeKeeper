import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:home_keeper/providers/tasks_provider.dart';
import 'package:home_keeper/widgets/container.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Home();
}

class _Home extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TasksProvider>(context);

    var lastEvents = taskProvider.taskCompletions
        .map((e) => CommonContainer(child: Text("123")))
        .toList();

    if (lastEvents.isEmpty) {
      lastEvents.add(CommonContainer(
          child: Text(
        "Nothing intresting happend so far 😔\nComplete some tasks 😉",
        textAlign: TextAlign.center,
      )));
    }

    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(20, 40, 20, 20),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: lastEvents),
    );
  }
}
