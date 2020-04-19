import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

class AdaptiveFlatButton extends StatelessWidget {
  final String buttonText;
  final Function clickHandler;

  AdaptiveFlatButton(this.buttonText, this.clickHandler);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            onPressed: clickHandler,
            child: Text(
              'Choose date',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          )
        : FlatButton(
            textColor: Theme.of(context).primaryColor,
            onPressed: clickHandler,
            child: Text(
              'Choose date',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          );
  }
}
