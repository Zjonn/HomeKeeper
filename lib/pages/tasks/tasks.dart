import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:home_keeper/widgets/container.dart';

class Tasks extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Tasks();
}

class _Tasks extends State<Tasks> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(20, 40, 20, 20),
            child: SizedBox(
              height: 80,
              child: CommonContainer(),
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
                  foregroundColor: Colors.white,
                )))
      ],
    );
  }
}
