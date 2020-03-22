import 'package:azap_app/design_system/theme.dart';
import 'package:azap_app/doctor/domain/location/location_bloc.dart';
import 'package:azap_app/doctor/domain/location/location_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddLocationPage extends StatelessWidget {

  const AddLocationPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _locationBloc = BlocProvider.of<LocationBloc>(context);
    final _formKey = GlobalKey<FormState>();

    String adresse;
    String name;
    String zipCode;
    String city;

    return Scaffold(
        appBar: AppBar(
          title: Text("AddLocationPage",
              style: TextStyle(
                color: accentColor,
              )),
        ),
        body: Padding(
            padding: EdgeInsets.all(16.0),
            child: Form(
                key: _formKey,
                child: Column(children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Nom du lieu'),
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Veuillez entrer un nom de lieu';
                      }
                      name = value;
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Adresse du lieu'),
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Veuillez entrer une adresse';
                      }
                      adresse = value;
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration:
                        InputDecoration(labelText: 'Code postal'),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      WhitelistingTextInputFormatter.digitsOnly
                    ],
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Veuillez entrer un code postal';
                      }
                      zipCode = value;
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration:
                    InputDecoration(labelText: 'Ville'),
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Veuillez entrer une ville';
                      }
                      city = value;
                      return null;
                    },
                  ),
                  RaisedButton(
                    onPressed: () {
                      // Validate returns true if the form is valid, otherwise false.
                      if (_formKey.currentState.validate()) {
                        // If the form is valid, display a snackbar. In the real world,
                        // you'd often call a server or save the information in a database.

                        _locationBloc.dispatch(SetLocation(name: name, adresse: adresse, zipCode: zipCode, city: city));
                      }
                    },
                    child: Text('Valider'),
                  )
                ]))));
  }
}
