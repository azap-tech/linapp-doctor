import 'package:azap_app/design_system/theme.dart';
import 'package:flutter/material.dart';

Widget buildRegularButton(String text, Function onPressed) {
  return RaisedButton(
    onPressed: () {
      onPressed();
    },
    color: accentColor,
    textColor: mainColor,
    child: Text(text,
    style: TextStyle(fontWeight: FontWeight.bold),),
  );
}
