import 'package:azap_app/services/http.dart';
import 'package:flutter/material.dart';

void alertDialog(BuildContext context) {
  var inputValue = "";
  showDialog(
    context: context,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
        title: new Text("Nom de la file"),
        content: new TextFormField(
          autofocus: true,
          onChanged: (text) {
            inputValue = text;
          },
          decoration: InputDecoration(
              labelText: 'Entrez un nom pour la file'
          ),
        ),
        actions: <Widget>[
          // usually buttons at the bottom of the dialog
          new FlatButton(
            child: new Text("Valider"),
            onPressed: () {
              HttpService().createWorker(inputValue);
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}