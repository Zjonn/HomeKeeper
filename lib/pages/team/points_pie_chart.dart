import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:home_keeper/widgets/container.dart';

import '../../widgets/indicator.dart';

class UserPointsPieChart extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => UserPointsPieChartState();
}

class UserPointsPieChartState extends State {
  // final RandomColor _randomColor = RandomColor();
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    // final teamsProvider = Provider.of<TeamProvider>(context);

    return CommonContainer(
        child: Column(
      children: [
        Text(
          'Percent of points',
          style: TextStyle(fontSize: 20),
        ),
        SizedBox(height: 5.0),
        AspectRatio(
          aspectRatio: 1.7,
          child: PieChart(
            PieChartData(
                pieTouchData: PieTouchData(touchCallback: (pieTouchResponse) {
                  setState(() {
                    final desiredTouch =
                        pieTouchResponse.touchInput is! PointerExitEvent &&
                            pieTouchResponse.touchInput is! PointerUpEvent;
                    if (desiredTouch &&
                        pieTouchResponse.touchedSection != null) {
                      touchedIndex =
                          pieTouchResponse.touchedSection!.touchedSectionIndex;
                    } else {
                      touchedIndex = -1;
                    }
                  });
                }),
                borderData: FlBorderData(
                  show: false,
                ),
                sectionsSpace: 0,
                centerSpaceRadius: 40,
                sections: showingSections()),
          ),
        ),
      ],
    ));
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(1, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: const Color(0xff0293ee),
            value: 100,
            title: '100%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        default:
          throw Error();
      }
    });
  }
}
