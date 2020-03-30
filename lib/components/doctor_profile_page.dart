import 'package:azap_app/components/kanban.dart';
import 'package:azap_app/design_system/form/checkbox.dart';
import 'package:azap_app/services/http.dart';
import 'package:azap_app/stores/doctor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:url_launcher/url_launcher.dart';

class DoctorProfilePage extends StatefulWidget {
  DoctorProfilePage({Key key}) : super(key: key);

  @override
  _DoctorProfilePageState createState() => _DoctorProfilePageState();
}

class _DoctorProfilePageState extends State<DoctorProfilePage> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    ScrollController _scroll;

    Doctor doctor = new Doctor();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 5, 82, 136),
        title: Image.asset(
          'assets/logo.png',
          fit: BoxFit.contain,
          height: 32
        )
      ),
      backgroundColor: Color(0xFFF0F8FF),
      body: 
        SingleChildScrollView(
          child:
            Container(
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
                      color: Color.fromARGB(255, 5, 82, 136),
                      fontSize: 25,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        'Nom',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Color.fromARGB(255, 5, 82, 136),
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(2),
                  ),
                  Container(
                    height: 70,
                    child:
                      TextFormField(
                        textAlignVertical: TextAlignVertical.top,
                        decoration: InputDecoration(
                        helperText: ' ',
                        filled: true,
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color.fromARGB(255, 5, 82, 136), width: 2.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color.fromARGB(35, 5, 82, 136), width: 2.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color.fromARGB(50, 183, 28, 28), width: 2.0),
                        ),
                        focusedErrorBorder:  OutlineInputBorder(
                          borderSide: BorderSide(color: Color.fromARGB(255, 183, 28, 28), width: 2.0),
                        ),
                        errorStyle: TextStyle(
                          fontSize: 10,
                          color: Color.fromARGB(255, 183, 28, 28)
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
                    padding: EdgeInsets.all(5),
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        'Email',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Color.fromARGB(255, 5, 82, 136),
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(2),
                  ),
                  Container(
                    height: 70,
                    child:
                    TextFormField(
                      textAlignVertical: TextAlignVertical.top,
                      decoration: InputDecoration(
                        helperText: ' ',
                        filled: true,
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color.fromARGB(255, 5, 82, 136), width: 2.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color.fromARGB(35, 5, 82, 136), width: 2.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color.fromARGB(50, 183, 28, 28), width: 2.0),
                        ),
                        focusedErrorBorder:  OutlineInputBorder(
                          borderSide: BorderSide(color: Color.fromARGB(255, 183, 28, 28), width: 2.0),
                        ),
                        errorStyle: TextStyle(
                          fontSize: 10,
                          color: Color.fromARGB(255, 183, 28, 28)
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
                    padding: EdgeInsets.all(5),
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        'Numéro de téléphone',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Color.fromARGB(255, 5, 82, 136),
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(2),
                  ),
                  Container(
                    height: 70,
                    child:
                      TextFormField(
                        textAlignVertical: TextAlignVertical.top,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          helperText: ' ',
                          filled: true,
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color.fromARGB(255, 5, 82, 136), width: 2.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color.fromARGB(35, 5, 82, 136), width: 2.0),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color.fromARGB(50, 183, 28, 28), width: 2.0),
                          ),
                          focusedErrorBorder:  OutlineInputBorder(
                            borderSide: BorderSide(color: Color.fromARGB(255, 183, 28, 28), width: 2.0),
                          ),
                          errorStyle: TextStyle(
                            fontSize: 10,
                            color: Color.fromARGB(255, 183, 28, 28)
                          ),
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Veuillez entrer un numéro de téléphone';
                          }

                          doctor.phone = value;

                          return null;
                        }
                      )
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                  ),
                  Row(
                    children: <Widget>[
                      CustomCheckBox(
                        IconData(58826, fontFamily: 'MaterialIcons'),
                        height: 30,
                        width: 30,
                        onSelect: (value) {
                          doctor.rgpd = value;
                          print(doctor);
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 10),
                      ),
                      Expanded(
                        child: Text(
                          "J’autorise Azap à conserver mes données transmises via ce formulaire. Aucune exploitation commerciale ne sera faite des données conservées.",
                          style: TextStyle(
                            color: Color.fromARGB(255, 5, 82, 136),
                            fontSize: 12,
                          ),
                        )
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                  ),
                  InkWell(
                    child:               
                      Text(
                        "Voir la politique de gestion des données personnelles.",
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Color.fromARGB(255, 5, 82, 136),
                          fontSize: 12,
                        ),
                      ),
                    onTap: () => launch('http://azap.io/cgu')
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                  ),
                  Observer(
                  builder: (_) => 
                    Opacity(
                      opacity: doctor.rgpd == true ? 1 : 0.5,
                      child:
                        RaisedButton(
                          color: Color.fromARGB(255, 5, 82, 136),
                          onPressed: () {
                            if (_formKey.currentState.validate() && doctor.rgpd) {
                              HttpService().createDoctor(doctor);

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Kanban()
                                ),
                              );
                            }
                          },
                          child: 
                            Text(
                              'Créer mon compte',
                              style: TextStyle(
                                color: Colors.white
                              ),
                            )
                        )
                    )
                  )
                ]
              )
            )
        )
      )
    );
  }
}
