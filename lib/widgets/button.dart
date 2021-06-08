import 'package:flutter/material.dart';

class CommonMaterialButton extends StatelessWidget {
  final label;
  final onPressed;

  CommonMaterialButton(this.label, {this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 5.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
      minWidth: MediaQuery.of(context).size.width,
      color: Theme.of(context).primaryColor,
      onPressed: onPressed,
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}

class CommonButton extends StatelessWidget {
  final label;
  final onPressed;

  CommonButton(this.label, {this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.all(0.0),
        ),
        child: Text(label, style: TextStyle(fontWeight: FontWeight.w300)),
        onPressed: onPressed);
  }
}
