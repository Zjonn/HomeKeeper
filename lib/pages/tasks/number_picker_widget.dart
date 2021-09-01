import 'package:flutter/material.dart';
import 'package:home_keeper/widgets/container.dart';
import 'package:numberpicker/numberpicker.dart';

class CommonNumberPicker extends StatefulWidget {
  final ValueChanged<int> onChanged;
  final initialPeriod;

  CommonNumberPicker(this.initialPeriod, this.onChanged);
  @override
  State<StatefulWidget> createState() => _CommonNumberPickerState();
}

class _CommonNumberPickerState extends State<CommonNumberPicker> {
  int? _period;

  @override
  Widget build(BuildContext context) {
    if (_period == null) {
      setState(() {
        _period = widget.initialPeriod;
      });
    }
    return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
        child: CommonContainer(
            child: FractionallySizedBox(
                heightFactor: 0.35,
                child: Column(children: [
                  Text("Choose how many days the period will last"),
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context, _period);
                      },
                      child: NumberPicker(
                        minValue: 1,
                        maxValue: 60,
                        step: 1,
                        onChanged: (int value) {
                          setState(() {
                            _period = value;
                          });
                          widget.onChanged(value);
                        },
                        value: _period!,
                        itemCount: 5,
                      ))
                ]))));
  }
}
