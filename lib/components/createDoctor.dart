import 'package:azap_app/services/http.dart';
import 'package:azap_app/stores/doctor.dart';
import 'package:azap_app/stores/ticket.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'kanban.dart';

class CreateDoctor extends StatefulWidget {
  @override
  _CreateDoctorState createState() => _CreateDoctorState();
}

class _CreateDoctorState extends State<CreateDoctor> {
  Doctor newDoctor = new Doctor();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEAF4FB),
      appBar: AppBar(
          title: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            RaisedButton(
              onPressed: () {
                HttpService().createDoctor(newDoctor);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Kanban()),
                );
              },
              color: Color(0xFFFFCC09),
              child: const Text('Valider',
                  style: TextStyle(fontSize: 20, color: Colors.white)),
            ),
          ])),
      body: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          new Expanded(
            child: new TextFormField(
              autofocus: true,
              onChanged: (text) {
                newDoctor.name = text;
              },
              decoration:
              InputDecoration(labelText: 'Entrez votre nom'),
            ),
          ),
          new Expanded(
            child: new TextField(
                onChanged: (text) {
                  newDoctor.phone = text;
                },
                decoration: InputDecoration(
                    labelText: 'Entrez un numéro de téléphone'),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  WhitelistingTextInputFormatter.digitsOnly
                ]),
          ),
          /*new Expanded(
            child: new TextField(
                onChanged: (text) {
                  newDoctor.locationId = text;
                },
                decoration: InputDecoration(
                    labelText: 'Sélectionnez un lieux'),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  WhitelistingTextInputFormatter.digitsOnly
                ]),
          )*/
        ],
      ),
    );
  }
}
