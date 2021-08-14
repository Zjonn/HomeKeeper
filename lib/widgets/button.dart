import 'package:flutter/material.dart';

class CommonMaterialButton extends StatelessWidget {
  final String label;
  final void Function()? onPressed;
  final BorderRadius? borderRadius;
  final Color? textColor;

  CommonMaterialButton(this.label,
      {this.onPressed, this.borderRadius, this.textColor});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 5.0,
      shape: RoundedRectangleBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(40)),
      padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
      minWidth: MediaQuery.of(context).size.width,
      color: Theme.of(context).primaryColor,
      textColor: textColor,
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
  final String label;
  final void Function()? onPressed;

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

class CommonIconButton extends StatelessWidget {
  final Icon icon;
  final void Function()? onPressed;
  final Color? color;

  CommonIconButton(this.icon, {this.onPressed, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).backgroundColor),
          shape: BoxShape.circle,
        ),
        child: IconButton(
          alignment: Alignment.center,
          icon: icon,
          color: color ?? Theme.of(context).accentColor,
          onPressed: onPressed,
        ));
  }
}
