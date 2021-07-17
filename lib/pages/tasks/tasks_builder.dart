import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home_keeper/pages/tasks/create_task.dart';
import 'package:home_keeper/pages/tasks/tasks.dart';

class TasksBuilder extends StatefulWidget {
  @override
  _TasksBuilderState createState() => _TasksBuilderState();
}

class _TasksBuilderState extends State<TasksBuilder>
    with AutomaticKeepAliveClientMixin<TasksBuilder> {
  final GlobalKey<NavigatorState> navigatorState = GlobalKey<NavigatorState>();

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return WillPopScope(
        onWillPop: () async =>
            await navigatorState.currentState!.maybePop() && false,
        child: Navigator(
          key: navigatorState,
          initialRoute: 'tasks',
          onGenerateRoute: (RouteSettings settings) {
            switch (settings.name) {
              case 'tasks':
                return MaterialPageRoute(
                    builder: (context) => Tasks(), settings: settings);
              case 'create_task':
                return MaterialPageRoute(
                    builder: (context) => CreateTask(), settings: settings);
              default:
                throw Exception("Invalid route");
            }
          },
        ));
  }
}
