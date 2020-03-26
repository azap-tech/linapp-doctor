import 'package:azap_app/services/http.dart';
import 'package:azap_app/stores/doctor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void newDoctorDialog(BuildContext context) {
  Doctor doctor = new Doctor();
  // TODO fix /me
  doctor.locationId = 1;
  showDialog(
    context: context,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
        title: new Text("Nom de la file"),
        content: Column(
          children: <Widget>[
            Expanded(
              child: new TextFormField(
                autofocus: true,
                onChanged: (text) {
                  doctor.name = text;
                },
                decoration: InputDecoration(
                    labelText: 'Entrez un nom pour la file'
                ),
              ),
            ),
            Expanded(
              child: new TextField(
                  onChanged: (text) {
                    doctor.phone = text;
                  },
                  decoration: InputDecoration(
                      labelText: 'Entrez un numéro de téléphone'),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    WhitelistingTextInputFormatter.digitsOnly
                  ]),
            )
          ],
        ),
        actions: <Widget>[
          // usually buttons at the bottom of the dialog
          new FlatButton(
            child: new Text("Valider"),
            onPressed: () {
              HttpService().createDoctor(doctor);
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}