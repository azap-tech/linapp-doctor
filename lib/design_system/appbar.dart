
import 'package:azap_app/design_system/azapColor.dart';
import 'package:flutter/material.dart';

Widget buildAppBar(BuildContext context) {
  return AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      title: Image.asset('assets/logo.png', fit: BoxFit.contain, height: 32),
      centerTitle: true);
}
