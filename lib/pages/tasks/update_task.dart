import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home_keeper/pages/tasks/number_picker_widget.dart';
import 'package:home_keeper/providers/tasks_provider/task.dart';
import 'package:home_keeper/providers/tasks_provider/tasks_provider.dart';
import 'package:home_keeper/widgets/button.dart';
import 'package:home_keeper/widgets/flushbar.dart';
import 'package:provider/provider.dart';

class EditTask extends StatefulWidget {
  final Task task;

  EditTask(this.task);

  @override
  State<StatefulWidget> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  final formKey = new GlobalKey<FormState>();

  String _taskName = '';
  String? _description;
  bool? _isPeriodic;
  int? _period;
  int _points = 0;

  @override
  Widget build(BuildContext context) {
    final tasksProvider = Provider.of<TasksProvider>(context);

    if (_isPeriodic == null || _period == null) {
      setState(() {
        _isPeriodic = widget.task.isPeriodic;
        _period = widget.task.period == 0 ? 7 : widget.task.period;
      });
    }

    final taskNameField = TextFormField(
      initialValue: widget.task.name,
      decoration: const InputDecoration(labelText: "Task name"),
      onSaved: (value) => _taskName = value ?? '',
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return "Task name can't be empty";
        }
      },
    );

    final descriptionField = TextFormField(
      initialValue: widget.task.description,
      decoration: const InputDecoration(
          labelText: "Description", hintText: "Description can be empty"),
      onSaved: (value) => _description = value ?? '',
      maxLines: null,
    );

    final pointsField = TextFormField(
      initialValue: widget.task.points.toString(),
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
        TextEditingController(text: _isPeriodic! ? _period.toString() : '');

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
          border: _isPeriodic! ? null : InputBorder.none,
        ));

    final _doCreateTask = () async {
      final form = formKey.currentState!;

      if (form.validate()) {
        form.save();

        final result = await tasksProvider.updateTask(
            widget.task.id,
            _taskName,
            _description,
            _points,
            _period,
            _isPeriodic!);

        if (result) {
          Navigator.pop(context);
          CommonFlushbar("Task updated!").show(context);
        } else {
          CommonFlushbar('Something went wrong.').show(context);
        }
      }
    };

    return GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
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
                            height: _isPeriodic! ? 60 : 0,
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
                          "Edit",
                          onPressed: _doCreateTask,
                        )
                      ],
                    )))));
  }

  Future<int> _showIntegerDialog(BuildContext context, int period) async {
    await showDialog<int>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return CommonNumberPicker(period, (int value) {
            setState(() {
              period = value;
            });
          });
        });
    return period;
  }
}
