import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ShowDialogSemua extends StatelessWidget {
  String title;
  String subtitle1;
  String subtitle2;
  String buttonText;

  ShowDialogSemua({super.key,
    required this.title,
    required this.subtitle1,
    required this.subtitle2,
    required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(subtitle1),
            Text(subtitle2),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text(buttonText),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}