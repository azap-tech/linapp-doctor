import 'package:flutter/material.dart';

Widget buildSnackbarError(String errorMessage) {
  return SizedBox(
      height: 48.0,
      child: DecoratedBox(
        decoration: const BoxDecoration(color: Colors.red),
        child: Center(
            child: Text(
          errorMessage,
          style: TextStyle(
              fontSize: 20, color: Colors.white),
        )),
      ));
}
