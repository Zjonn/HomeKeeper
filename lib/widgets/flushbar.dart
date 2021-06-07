import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CommonFlushbar extends Flushbar {
  CommonFlushbar(String message, {seconds = 2})
      : super(
            message: message,
            duration: Duration(seconds: seconds),
            borderRadius: BorderRadius.circular(40),
            margin: EdgeInsets.only(left: 10, right: 10, bottom: 60));

  var _backgroundColor;

  Color get backgroundColor {
    return _backgroundColor;
  }

  Future show(BuildContext context) {
    _backgroundColor = Theme.of(context).primaryColor.withOpacity(0.5);
    return super.show(context);
  }
}
