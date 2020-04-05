import 'package:flutter/material.dart';

void hideKeyboard(BuildContext context) {
  FocusScope.of(context).unfocus();
}

InputDecoration inputBorder(BuildContext context){
  return InputDecoration(
    helperText: ' ',
    filled: true,
    fillColor: Colors.white,
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2.0),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2.0),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Theme.of(context).errorColor, width: 2.0),
    ),
    focusedErrorBorder:  OutlineInputBorder(
      borderSide: BorderSide(color: Theme.of(context).errorColor, width: 2.0),
    ),
    errorStyle: TextStyle(
        fontSize: 10,
        color: Theme.of(context).errorColor
    ),
  );
}