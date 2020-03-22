import 'package:azap_app/doctor/domain/session/session_bloc.dart';
import 'package:azap_app/doctor/domain/session/session_events.dart';
import 'package:azap_app/doctor/presentation/core/connected_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../keys.dart';

class HomePage extends StatefulWidget {
  final void Function() onInit;

  HomePage({
    @required this.onInit,
    Key key,
  }) : super(key: AzapDoctorKeys.homeScreen);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _sessionBloc = BlocProvider.of<SessionBloc>(context);

    return ConnectedWidget(
        child: Scaffold(
            appBar: AppBar(
              title: Text("Doctor main screen"),
            ),
            body: Center(
                child: RaisedButton(
              onPressed: () => _sessionBloc.dispatch(LogOutSession()),
              padding: const EdgeInsets.all(8.0),
              child: new Text(
                "Logout",
              ),
            ))));
  }
}
