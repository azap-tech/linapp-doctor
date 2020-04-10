import 'package:flutter/material.dart';

InputDecoration buildInputDecoration() {
  return InputDecoration(
    helperText: ' ',
    filled: true,
    fillColor: Colors.white,
    focusedBorder: OutlineInputBorder(
      borderSide:
          BorderSide(color: Color.fromARGB(255, 5, 82, 136), width: 2.0),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color.fromARGB(35, 5, 82, 136), width: 2.0),
    ),
    errorBorder: OutlineInputBorder(
      borderSide:
          BorderSide(color: Color.fromARGB(50, 183, 28, 28), width: 2.0),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide:
          BorderSide(color: Color.fromARGB(255, 183, 28, 28), width: 2.0),
    ),
    errorStyle:
        TextStyle(fontSize: 10, color: Color.fromARGB(255, 183, 28, 28)),
  );
}
