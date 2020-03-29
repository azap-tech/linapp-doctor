import 'package:azap_app/components/kanban.dart';
import 'package:azap_app/services/http.dart';
import 'package:azap_app/stores/doctor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DoctorProfilePage extends StatelessWidget {
  const DoctorProfilePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    Doctor doctor = new Doctor();

    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 5, 82, 136),
          title: Image.asset(
            'assets/logo.png',
            fit: BoxFit.contain,
            height: 32
          )
        ),
        body: Container(
          color: const Color(0xFFF0F8FF),
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Nom'),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Veuillez entrer votre nom';
                  }

                  doctor.name = value;

                  return null;
                }
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                  RegExp regex = new RegExp(pattern);
                  if (!regex.hasMatch(value)) {
                    return 'Veuillez entrer une adresse email valide';
                  }

                  if (value.isEmpty) {
                    return 'Veuillez entrer une adresse email';
                  }

                  doctor.email = value;

                  return null;
                }
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Numéro de mobile'),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Veuillez entrer un numéro de téléphone';
                  }

                  doctor.phone = value;

                  return null;
                }
              ),
              RaisedButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    HttpService().createDoctor(doctor);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Kanban()
                      ),
                    );
                  }
                },
                child: Text('Valider')
              )
            ]
          )
        )
      )
    );
  }
}
