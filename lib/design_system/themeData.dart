import 'package:azap_app/design_system/azapColor.dart';
import 'package:flutter/material.dart';

ThemeData themeData() {
  return ThemeData(
    primarySwatch: MaterialColor(AzapColor.blue[50].value, AzapColor.blue),
    accentColor: MaterialColor(AzapColor.yellow[50].value, AzapColor.yellow),
    fontFamily: 'Avenir',
    backgroundColor: AzapColor.backgroundAccentColor,
    scaffoldBackgroundColor: AzapColor.backgroundColor,
    errorColor: Colors.red,
    hintColor: MaterialColor(AzapColor.blue[50].value, AzapColor.blue),
    buttonTheme: ButtonThemeData(
        buttonColor:
            MaterialColor(AzapColor.yellow[50].value, AzapColor.yellow),
        textTheme: ButtonTextTheme.normal),
    textTheme: ThemeData.light().textTheme.copyWith(
        display1: TextStyle(
            fontFamily: 'Avenir',
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AzapColor.blue[50]),
        title: TextStyle(
            fontFamily: 'Avenir',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AzapColor.blue[50]),
        subtitle: TextStyle(
            fontFamily: 'Avenir', fontSize: 18, color: AzapColor.blue[50]),
        button: TextStyle(color: Colors.white)),
    appBarTheme: AppBarTheme(
      textTheme: ThemeData.light().textTheme.copyWith(
            title: TextStyle(
                color: AzapColor.yellow[50],
                fontFamily: 'Avenir',
                fontSize: 24,
                fontWeight: FontWeight.bold),
          ),
    ),
  );
}
