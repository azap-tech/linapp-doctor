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
        padding: EdgeInsets.all(38),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Text(
                'Vos coordonnées',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: const Color.fromARGB(255, 5, 82, 136),
                  fontSize: 25,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
              ),
              Row(
                children: <Widget>[
                  Text(
                    'Nom',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: const Color.fromARGB(255, 5, 82, 136),
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(2),
              ),
              Container(
                  height: 45,
                  child:
                    TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: const Color.fromARGB(255, 5, 82, 136), width: 2.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: const Color.fromARGB(35, 5, 82, 136), width: 2.0),
                  ),
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Veuillez entrer votre nom';
                  }

                  doctor.name = value;

                  return null;
                }
              )
            ),
              Padding(
                padding: const EdgeInsets.all(10),
              ),
              Row(
                children: <Widget>[
                  Text(
                    'Email',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: const Color.fromARGB(255, 5, 82, 136),
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(2),
              ),
              Container(
                height: 45,
                child:
                TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: const Color.fromARGB(255, 5, 82, 136), width: 2.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: const Color.fromARGB(35, 5, 82, 136), width: 2.0),
                  ),
                ),
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
              ),
              Padding(
                padding: const EdgeInsets.all(10),
              ),
              Row(
                children: <Widget>[
                  Text(
                    'Numéro de téléphone',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: const Color.fromARGB(255, 5, 82, 136),
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(2),
              ),
              Container(
                  height: 45,
                  child:
                  TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: const Color.fromARGB(255, 5, 82, 136), width: 2.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: const Color.fromARGB(35, 5, 82, 136), width: 2.0),
                        ),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Veuillez entrer votre nom';
                        }

                        doctor.phone = value;

                        return null;
                      }
                  )
              ),
              Padding(
                padding: const EdgeInsets.all(10),
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
