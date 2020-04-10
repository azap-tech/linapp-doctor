import 'package:azap_app/components/verifyPhone.dart';
import 'package:azap_app/design_system/appbar.dart';
import 'package:azap_app/design_system/azapColor.dart';
import 'package:azap_app/design_system/error/snackbar.dart';
import 'package:azap_app/design_system/form/checkbox.dart';
import 'package:azap_app/design_system/ui_utils.dart';
import 'package:azap_app/services/http.dart';
import 'package:azap_app/stores/doctor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:url_launcher/url_launcher.dart';

import '../main.dart';

class DoctorProfilePage extends StatefulWidget {
  DoctorProfilePage({Key key}) : super(key: key);

  @override
  _DoctorProfilePageState createState() => _DoctorProfilePageState();
}

class _DoctorProfilePageState extends State<DoctorProfilePage> {
  bool httpError;
  Doctor newDoctor;
  GlobalKey<FormState> _formKey;

  @override
  void initState() {
    super.initState();
    httpError = false;
    newDoctor = new Doctor();
    _formKey = GlobalKey<FormState>();
  }

  buildBottomNavBar() {
    if (httpError) {
      Future.delayed(const Duration(milliseconds: 1500), () {
        setState(() {
          httpError = false;
        });
      });
      return buildSnackbarError("Une erreur est survenue");
    } else {
      return SizedBox.shrink();
    }
  }

  createDoctor(){
    // TODO loader and lock button on long http call
    if (_formKey.currentState.validate() && newDoctor.rgpd && !httpError) {
      HttpService().createDoctor(newDoctor).then((payload){
        if(payload != null && payload.status == "ok"){
          // TODO move login on sms validation + send pincode sms ? or display
          HttpService().login(doctor.id, payload.pincode).then((payload) {
            if(payload != null && payload.status == "ok"){
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  // TODO go sms validation, then create place, then doctor status, then kanban
                    builder: (context) => VerifyPhone()
                ),
              );
            } else {
              setState(() {
                httpError = true;
              });
            }
          });
        } else {
          setState(() {
            httpError = true;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: buildAppBar(context),
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
                        decoration: inputBorder(context),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Veuillez entrer votre nom';
                        }

                        newDoctor.name = value;

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
                      decoration: inputBorder(context),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                        RegExp regex = new RegExp(pattern);

                        if (value.isEmpty) {
                          return 'Veuillez entrer une adresse email';
                        }

                        if (!regex.hasMatch(value)) {
                          return 'Veuillez entrer une adresse email valide';
                        }

                        newDoctor.email = value;

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
                        decoration: inputBorder(context),
                        validator: (value) {
                          Pattern pattern = r'^((\+)33|0)[1-9](\d{2}){4}$';
                          RegExp regex = new RegExp(pattern);

                          if (value.isEmpty) {
                            return 'Veuillez entrer un numéro de téléphone';
                          }

                          if (!regex.hasMatch(value)) {
                            return 'Veuillez entrer un téléphone valide';
                          }

                          newDoctor.phone = value;

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
                          newDoctor.rgpd = value;
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
                        opacity: newDoctor.rgpd == true ? 1 : 0.5,
                        child:
                          RaisedButton(
                            color: Color.fromARGB(255, 5, 82, 136),
                            onPressed: createDoctor,
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
      ),
        bottomNavigationBar: buildBottomNavBar()
    );
  }
}
