import 'package:flutter/material.dart';

class Loading extends Center {
  Loading()
      : super(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[CircularProgressIndicator()],
        ));
}
