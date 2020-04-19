import 'package:azap_app/classes/locationTypes.dart';
import 'package:azap_app/components/kanban.dart';
import 'package:azap_app/design_system/appbar.dart';
import 'package:azap_app/design_system/azapColor.dart';
import 'package:azap_app/design_system/button/regular_button.dart';
import 'package:azap_app/design_system/decoration.dart';
import 'package:azap_app/design_system/error/snackbar.dart';
import 'package:azap_app/design_system/input_decoration.dart';
import 'package:azap_app/main.dart';
import 'package:azap_app/services/http.dart';
import 'package:azap_app/services/sse.dart';
import 'package:azap_app/stores/location.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class AddLocationPage extends StatefulWidget {
  AddLocationPage({Key key}) : super(key: key);

  @override
  _AddLocationPageState createState() => _AddLocationPageState();
}

class _AddLocationPageState extends State<AddLocationPage> {
  bool httpError;
  Location newLocation;
  GlobalKey<FormState> _formKey;
  var _typeList = <LocationTypes>[];

  @override
  void initState() {
    super.initState();
    httpError = false;
    newLocation = new Location();
    newLocation.location_type = LocationType.toText(LocationTypes.DEPISTAGE);
    _formKey = GlobalKey<FormState>();
    _typeList = <LocationTypes>[
      LocationTypes.AMBULATOIRE,
      LocationTypes.DEPISTAGE,
      LocationTypes.MEDICAL,
      LocationTypes.HOSPITALIER,
      LocationTypes.URGENCES,
    ];
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

  createLocation() {
    // TODO loader and lock button on long http call
    if (_formKey.currentState.validate() && !httpError) {
      HttpService().createLocation(newLocation).then((payload) {
        if (payload != null && payload.status == "ok") {
          // TODO lock sse fail init ? and move logic in services
          SseService().initEventSource(payload.payload.id);
          // TODO handle case fail link but location created
          HttpService().linkDoctorToLocation(doctor.id, payload.payload).then((payloadLink) {
            if (payloadLink != null && payloadLink.status == "ok") {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    // TODO go doctor status, then kanban
                    builder: (context) => Kanban()),
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
        backgroundColor: AzapColor.backgroundColor,
        body: SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.only(left: 38, right: 38, top: 10),
                child: Form(
                    key: _formKey,
                    child: Column(children: <Widget>[
                      Text(
                        'Créer un lieu de consultation',
                        style: Theme.of(context).textTheme.display1,
                      ),
                      Text(
                        'Le lieu où vous allez exercer',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5),
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            'Nom du lieu',
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
                          child: TextFormField(
                              textAlignVertical: TextAlignVertical.top,
                              decoration: buildInputDecoration(),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Veuillez entrer un nom';
                                }
                                newLocation.name = value;
                                return null;
                              })),
                      Row(
                        children: <Widget>[
                          Text(
                            'Type de lieu',
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
                          height: 50,
                          padding: EdgeInsets.symmetric(horizontal: 9),
                          alignment: Alignment.centerRight,
                          width: MediaQuery.of(context).size.width,
                          decoration: buildDecoration(),
                          child: DropdownButton<LocationTypes>(
                            isExpanded: true,
                            value: LocationType.fromString(newLocation.location_type),
                            icon: Icon(Icons.arrow_downward),
                            iconSize: 24,
                            elevation: 16,
                            underline: Container(
                              height: 0,
                            ),
                            onChanged: (LocationTypes newValue) {
                              setState(() {
                                newLocation.location_type = LocationType.toText(newValue);
                              });
                            },
                            items: _typeList.map<DropdownMenuItem<LocationTypes>>((LocationTypes value) {
                              return DropdownMenuItem<LocationTypes>(
                                value: value,
                                child: Text(LocationType.getLibelle(value)),
                              );
                            }).toList(),
                          )),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            'Adresse du lieu',
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
                          child: TextFormField(
                              textAlignVertical: TextAlignVertical.top,
                              decoration: buildInputDecoration(),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Veuillez entrer une adresse';
                                }

                                newLocation.address = value;

                                return null;
                              })),
                      Row(
                        children: <Widget>[
                          Text(
                            'Code postal',
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
                          child: TextFormField(
                              textAlignVertical: TextAlignVertical.top,
                              keyboardType: TextInputType.number,
                              decoration: buildInputDecoration(),
                              validator: (value) {
                                Pattern pattern = r'^[0-9]{5,5}$';
                                RegExp regex = new RegExp(pattern);

                                if (value.isEmpty) {
                                  return 'Veuillez entrer un code postal';
                                }

                                if (!regex.hasMatch(value)) {
                                  return 'Veuillez entrer un code postal valide';
                                }

                                newLocation.zipCode = value;

                                return null;
                              })),
                      Row(
                        children: <Widget>[
                          Text(
                            'Ville',
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
                          child: TextFormField(
                              textAlignVertical: TextAlignVertical.top,
                              decoration: buildInputDecoration(),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Veuillez entrer une ville';
                                }

                                newLocation.city = value;

                            return null;
                          }
                      )
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                  ),
                  Text(
                    "En cliquant sur le bouton ci-dessous j’accepte les conditions générales d’utilisation du service",
                    style: TextStyle(
                      color: Color.fromARGB(255, 5, 82, 136),
                      fontSize: 12,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                  ),
                  InkWell(
                      child:
                      Text(
                        "Voir les conditions générales d’utilisation du service.",
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Color.fromARGB(255, 5, 82, 136),
                          fontSize: 12,
                        ),
                      ),
                      onTap: () => launch('http://azap.io/cgu')
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                  ),
                  SizedBox(
                      width: double.infinity,
                      child: buildRegularButton("Valider", createLocation)
                  ),
                ])))
        ),
        bottomNavigationBar: buildBottomNavBar()
    );
  }
}
