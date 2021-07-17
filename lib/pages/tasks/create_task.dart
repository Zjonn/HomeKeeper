import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home_keeper/providers/tasks_provider.dart';
import 'package:home_keeper/providers/teams_provider.dart';
import 'package:home_keeper/widgets/button.dart';
import 'package:home_keeper/widgets/container.dart';
import 'package:home_keeper/widgets/flushbar.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';

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
  int? _period = 7;

  Future<int> _showIntegerDialog(BuildContext context, int period) async {
    await showDialog<int>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return Center(
                  child: Padding(
                      padding: EdgeInsets.only(left: 40, right: 40),
                      child: CommonContainer(
                          child: FractionallySizedBox(
                              heightFactor: 0.4,
                              child: Column(children: [
                                Text(
                                    "Choose how many days the period will last"),
                                NumberPicker(
                                  minValue: 1,
                                  maxValue: 60,
                                  step: 1,
                                  onChanged: (int value) {
                                    setState(() {
                                      period = value;
                                    });
                                  },
                                  value: period,
                                  itemCount: 5,
                                )
                              ])))));
            },
          );
        });
    return period;
  }

  @override
  Widget build(BuildContext context) {
    final tasksProvider = Provider.of<TasksProvider>(context);
    final teamProvider = Provider.of<TeamProvider>(context);

    final taskNameField = TextFormField(
      decoration: const InputDecoration(labelText: "Task name"),
      onSaved: (value) => _taskName = value ?? '',
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return "Task name can't be empty";
        }
      },
    );

    final descriptionField = TextFormField(
      decoration: const InputDecoration(
          labelText: "Description", hintText: "Description can be empty"),
      onSaved: (value) => _description = value ?? '',
    );

    final pointsField = TextFormField(
      decoration: const InputDecoration(labelText: "Points for completion"),
      onSaved: (value) => _points = int.parse(value!),
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return "Please provide how many points this task is worth";
        }
      },
    );

    final isPeriodicCheckbox = Checkbox(
        value: _isPeriodic,
        onChanged: (value) => setState(() {
              _isPeriodic = value ?? false;
            }));

    final textController =
        TextEditingController(text: _isPeriodic ? _period.toString() : '');

    final periodField = TextField(
        controller: textController,
        textAlign: TextAlign.center,
        readOnly: true,
        onTap: () async {
          var period = await _showIntegerDialog(context, _period!);
          setState(() {
            _period = period;
          });
        },
        enabled: _isPeriodic,
        decoration: new InputDecoration(
          border: _isPeriodic ? null : InputBorder.none,
        ));

    final _doCreateTask = () {
      final form = formKey.currentState;

      if (form?.validate() ?? false) {
        form!.save();

        final Future<TaskCreateResult> successfulMessage =
            tasksProvider.createTask(
                _taskName,
                _description,
                _points,
                int.parse(teamProvider.currentTeamInfo.id),
                _period.toString(),
                _isPeriodic);

        successfulMessage.then((response) {
          if (response.status) {
            CommonFlushbar("Task created!").show(context);
          } else {
            CommonFlushbar(response.response.data!.createTask.toString())
                .show(context);
          }
        });
      }
    };

    return GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        behavior: HitTestBehavior.translucent,
        child: Center(
            child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(20, 40, 20, 20),
                child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        taskNameField,
                        SizedBox(height: 20.0),
                        descriptionField,
                        SizedBox(height: 20.0),
                        pointsField,
                        SizedBox(height: 20.0),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [Text("Periodic?"), isPeriodicCheckbox]),
                        AnimatedContainer(
                            duration: const Duration(seconds: 1),
                            curve: Curves.fastOutSlowIn,
                            height: _isPeriodic ? 60 : 0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                    flex: 10,
                                    child: Text(
                                        "Task should be completed again after")),
                                Expanded(flex: 3, child: periodField),
                                Expanded(
                                    flex: 2,
                                    child: Text(_period == 1 ? "day" : "days"))
                              ],
                            )),
                        CommonMaterialButton(
                          "Submit",
                          onPressed: _doCreateTask,
                        )
                      ],
                    )))));
  }
}
