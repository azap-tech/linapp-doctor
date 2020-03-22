import 'package:azap_app/doctor/domain/session/session_bloc.dart';
import 'package:azap_app/doctor/domain/session/session_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  final void Function() onInit;

  const LoginPage({@required this.onInit, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _sessionBloc = BlocProvider.of<SessionBloc>(context);

    return Scaffold(
        appBar: AppBar(
          title: Text("Login"),
        ),
        body: Center(
            child: RaisedButton(
          onPressed: () =>
              _sessionBloc.dispatch(OnSessionCreated("Fake token")),
          padding: const EdgeInsets.all(8.0),
          child: new Text(
            "Login",
          ),
        )));
  }
}
