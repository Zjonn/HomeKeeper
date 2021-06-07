import 'package:flutter/material.dart';

class CommonContainer extends StatelessWidget {
  final child;
  final double? height;

  CommonContainer({this.child, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        height: height,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).primaryColor,
              spreadRadius: 1,
              blurRadius: 7,
              offset: Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
        width: MediaQuery.of(context).size.width,
        child: child);
  }
}
