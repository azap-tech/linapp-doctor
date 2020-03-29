import 'package:azap_app/components/add_location_page.dart';
import 'package:azap_app/design_system/button/regular_button.dart';
import 'package:azap_app/design_system/error/snackbar.dart';
import 'package:azap_app/design_system/theme.dart';
import 'package:azap_app/design_system/ui_utils.dart';
import 'package:azap_app/services/http.dart';
import 'package:azap_app/stores/doctor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../main.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    Doctor doctor = new Doctor();

    return Scaffold(
        appBar: AppBar(
            title: Text("Azap",
                style: TextStyle(
                  color: accentColor,
                )),
            centerTitle: true,
            actions: [
              /*if (doctor.id != null) {
              return Padding(
              padding: EdgeInsets.all(16),
              child: SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator()));
              } else {
              return SizedBox.shrink();
              }*/
            ]),
        body: Padding(
            padding: EdgeInsets.all(16.0),
            child: Form(
                key: _formKey,
                child: Column(children: <Widget>[
                  TextFormField(
                    initialValue: doctor.name,
                    decoration: InputDecoration(labelText: 'Nom du médecin'),
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Veuillez entrer votre nom';
                      }
                      doctor.name = value;
                      return null;
                    },
                  ),
                  TextFormField(
                    initialValue: doctor.phone,
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
                      doctor.phone = value;
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
                          HttpService().createDoctor(doctor);
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => AddLocationPage()),
                          );
                        }
                      }),
                    ),
                  )
                ]))),
          /*bottomNavigationBar: if (state is LoggiingFailure) {
                return buildSnackbarError("Erreur");
              } else {
              return SizedBox.shrink();
              }*/
    );
  }
}
