import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateTask extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  final formKey = new GlobalKey<FormState>();

  String _taskName = '';
  String? _description;
  int _points = 0;
  bool _isPeriodic = false;
  DateTime? _period;

  @override
  Widget build(BuildContext context) {
    final taskNameField = TextFormField(
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return "Task name can't be empty";
        }
      },
      onSaved: (value) => _taskName = value ?? '',
    );

    final descriptionField = TextFormField(
      onSaved: (value) => _description = value ?? '',
    );

    final pointsField = TextFormField(
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return "Please provide how many points this task is worth";
        }
      },
      onSaved: (value) => _points = int.parse(value!),
    );

    final isPeriodicCheckbox = Checkbox(
        value: _isPeriodic,
        onChanged: (value) => setState(() {
              _isPeriodic = value ?? false;
            }));

    final periodField = TextFormField(
      keyboardType: TextInputType.datetime,
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return "Period can't be empty";
        }
      },
      onSaved: (value) => _period = DateTime.parse(value!),
      enabled: _isPeriodic,
    );

    return SingleChildScrollView(
        padding: EdgeInsets.all(40.0),
        child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 250.0),
                Text("Task name"),
                taskNameField,
                SizedBox(height: 20.0),
                Text("Description"),
                descriptionField,
                SizedBox(height: 20.0),
                Text("Points"),
                pointsField,
                SizedBox(height: 20.0),
                Text("Periodic?"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(flex: 1, child: isPeriodicCheckbox),
                    Expanded(flex: 5, child: periodField)
                  ],
                )
              ],
            )));
  }
}
