import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CommonFlushbar extends Flushbar {
  CommonFlushbar(String message, {seconds = 3})
      : super(
            message: message,
            duration: Duration(seconds: seconds),
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(10),
                bottomLeft: Radius.circular(10)),
            flushbarPosition: FlushbarPosition.TOP);

  var _backgroundColor;

  Color get backgroundColor {
    return _backgroundColor;
  }

  Future show(BuildContext context) {
    _backgroundColor = Theme.of(context).primaryColor.withOpacity(0.7);
    return super.show(context);
  }
}
