import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Tasks extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Tasks();
}

class _Tasks extends State<Tasks> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(20, 40, 20, 20),
      reverse: true,
      child: Column(children: [
        FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, 'create_task');
          },
          child: Icon(Icons.add),
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: Colors.white,
        )
      ]),
    );
  }
}
