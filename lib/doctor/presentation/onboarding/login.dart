import 'package:azap_app/design_system/button/regular_button.dart';
import 'package:azap_app/design_system/error/snackbar.dart';
import 'package:azap_app/design_system/theme.dart';
import 'package:azap_app/design_system/ui_utils.dart';
import 'package:azap_app/doctor/domain/login/login_bloc.dart';
import 'package:azap_app/doctor/domain/login/login_events.dart';
import 'package:azap_app/doctor/domain/login/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _loginBloc = BlocProvider.of<LoginBloc>(context);
    final _formKey = GlobalKey<FormState>();

    String name;
    String number;
    String locationId;

    return Scaffold(
        appBar: AppBar(
            title: Text("Azap",
                style: TextStyle(
                  color: accentColor,
                )),
            centerTitle: true,
            actions: [
              BlocBuilder(
                  bloc: _loginBloc,
                  builder: (BuildContext context, LoginState state) {
                    if (state is Logiing) {
                      return Padding(
                          padding: EdgeInsets.all(16),
                          child: SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator()));
                    } else {
                      return SizedBox.shrink();
                    }
                  })
            ]),
        body: Padding(
            padding: EdgeInsets.all(16.0),
            child: Form(
                key: _formKey,
                child: Column(children: <Widget>[
                  TextFormField(
                    initialValue: name,
                    decoration: InputDecoration(labelText: 'Nom du médecin'),
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Veuillez entrer votre nom';
                      }
                      name = value;
                      return null;
                    },
                  ),
                  TextFormField(
                    initialValue: number,
                    decoration:
                        InputDecoration(labelText: 'Numéro de téléphone'),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      WhitelistingTextInputFormatter.digitsOnly
                    ],
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Veuillez entrer votre numéro de téléphone';
                      }
                      number = value;
                      return null;
                    },
                  ),
                  TextFormField(
                    initialValue: locationId,
                    decoration:
                        InputDecoration(labelText: 'Code de rattachement'),
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value.isEmpty) {
                        return null;
                      }
                      locationId = value;
                      return null;
                    },
                  ),
                  Expanded(
                    child: Align(
                      alignment: FractionalOffset.bottomCenter,
                      child: buildRegularButton("Valider", () {
                        // Validate returns true if the form is valid, otherwise false.
                        if (_formKey.currentState.validate()) {
                          // If the form is valid, display a snackbar. In the real world,
                          // you'd often call a server or save the information in a database.
                          hideKeyboard(context);
                          _loginBloc.dispatch(LoginEvent(
                              userName: name, number: number, locationId: -1));
                        }
                      }),
                    ),
                  )
                ]))),
        bottomNavigationBar: BlocBuilder(
            bloc: _loginBloc,
            builder: (BuildContext context, LoginState state) {
              if (state is LoggiingFailure) {
                return buildSnackbarError("Erreur");
              } else {
                return SizedBox.shrink();
              }
            }));
  }
}
