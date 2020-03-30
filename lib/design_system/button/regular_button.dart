import 'package:azap_app/design_system/azapColor.dart';
import 'package:flutter/material.dart';

Widget buildRegularButton(String text, Function onPressed) {
  return RaisedButton(
    onPressed: () {
      onPressed();
    },
    child: Text(
      text,
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
  );
}
