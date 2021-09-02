import 'package:flutter/material.dart';
import 'package:home_keeper/widgets/loading.dart';

class CommonMaterialButton extends StatefulWidget {
  final String label;
  final Function()? onPressed;
  final BorderRadius? borderRadius;
  final Color? textColor;

  CommonMaterialButton(this.label,
      {this.onPressed, this.borderRadius, this.textColor});

  @override
  State<StatefulWidget> createState() => _CommonMaterialButtonState();
}

class _CommonMaterialButtonState extends State<CommonMaterialButton> {
  bool _waitingTillResponse = false;

  @override
  Widget build(BuildContext context) {
    if (_waitingTillResponse) {
      return Loading();
    }

    return MaterialButton(
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: widget.borderRadius ?? BorderRadius.circular(40),
        side: BorderSide(color: Theme.of(context).primaryColor, width: 2),
      ),
      padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
      minWidth: MediaQuery.of(context).size.width,
      color: Theme.of(context).primaryColor,
      textColor: widget.textColor,
      onPressed: widget.onPressed != null
          ? () async {
              setState(() {
                _waitingTillResponse = true;
              });

              await widget.onPressed!();

              setState(() {
                _waitingTillResponse = false;
              });
            }
          : null,
      child: Text(
        widget.label,
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
  final void Function()? onLongPress;
  final Color? color;

  CommonIconButton(this.icon, {this.onPressed, this.onLongPress, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).backgroundColor),
          shape: BoxShape.circle,
        ),
        child: GestureDetector(
            onLongPress: onLongPress,
            child: IconButton(
              alignment: Alignment.center,
              icon: icon,
              color: color ?? Theme.of(context).accentColor,
              onPressed:
                  onPressed == null && onLongPress != null ? () {} : onPressed,
            )));
  }
}
