import 'package:flutter/material.dart';

class CommonContainer extends StatelessWidget {
  final child;
  final double? height;
  final Color? color;

  CommonContainer({this.child, this.height, this.color});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color == null ? Theme.of(context).primaryColor : color,
      type: MaterialType.card,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      elevation: 5,
      child: Ink(
        padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        height: height,
        width: MediaQuery.of(context).size.width,
        child: child,
      ),
    );
  }
}

class CommonContainerWithInkWell extends StatelessWidget {
  final child;
  final void Function()? onTap;
  final void Function()? onDoubleTap;
  final void Function()? onLongPress;

  CommonContainerWithInkWell(
      {this.child, this.onTap, this.onDoubleTap, this.onLongPress});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).primaryColor,
      type: MaterialType.card,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      elevation: 5,
      child: InkWell(
        onTap: onTap,
        onDoubleTap: onDoubleTap,
        onLongPress: onLongPress,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        child: Container(
          padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          width: MediaQuery.of(context).size.width,
          child: child,
        ),
      ),
    );
  }
}
