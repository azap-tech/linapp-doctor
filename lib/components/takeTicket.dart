import 'package:azap_app/design_system/azapColor.dart';
import 'package:azap_app/design_system/button/regular_button.dart';
import 'package:azap_app/design_system/error/snackbar.dart';
import 'package:azap_app/design_system/ui_utils.dart';
import 'package:azap_app/main.dart';
import 'package:azap_app/services/http.dart';
import 'package:azap_app/stores/ticket.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grouped_buttons/grouped_buttons.dart';

import 'kanban.dart';

class TakeTicket extends StatefulWidget {
  @override
  _TakeTicketState createState() => _TakeTicketState();
}

class _TakeTicketState extends State<TakeTicket> {
  Ticket newTicket;
  bool httpError;
  GlobalKey<FormState> _formKey;

  @override
  void initState() {
    super.initState();
    httpError = false;
    newTicket = new Ticket();
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

  createTicket(){
    // TODO loader and lock button on long http call
    hideKeyboard(context);
    if (_formKey.currentState.validate() && !httpError) {
      // TODO api default ticket on doctor on solo mode ?
      newTicket.locationId = doctor.locationId;
      newTicket.doctorId = doctor.id;
      HttpService().createTicket(newTicket).then((payload){
        if(payload != null && payload.status == "ok"){
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => Kanban()),
          );
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
        appBar: AppBar(
            backgroundColor: AzapColor.mainColor,
            title: Image.asset(
                'assets/logo.png',
                fit: BoxFit.contain,
                height: 32
            ),
            centerTitle: true
        ),
        body: SingleChildScrollView(
            child:
            Container(
            padding: EdgeInsets.all(38),
            child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.max,
            children: <Widget>[
            new RadioButtonGroup(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                orientation: GroupedButtonsOrientation.HORIZONTAL,
                labels: <String>[
                  "HOMME",
                  "FEMME",
                ],
                onSelected: (String selected) => newTicket.sex = selected
            ),
              Padding(padding: EdgeInsets.all(10)),
              new TextFormField(
                autofocus: true,
                onChanged: (text) {
                  newTicket.name = text;
                },
                decoration:
                InputDecoration(labelText: 'Entrez un nom'),
              ),
              Padding(padding: EdgeInsets.all(10)),
              new TextFormField(
                onChanged: (text) {
                  newTicket.pathology = text;
                },
                decoration:
                InputDecoration(labelText: 'Entrez un motif'),
              ),
              new TextField(
                  onChanged: (text) {
                    newTicket.phone = text;
                  },
                  decoration: InputDecoration(
                      labelText: 'Entrez un numéro de téléphone'),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    WhitelistingTextInputFormatter.digitsOnly
                  ]),
              Padding(padding: EdgeInsets.all(10)),
              new TextField(
                  onChanged: (text) {
                    newTicket.age = int.parse(text);
                  },
                  decoration:
                  InputDecoration(labelText: 'Entrez un age'),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    WhitelistingTextInputFormatter.digitsOnly
                  ]),
              Padding(padding: EdgeInsets.all(10)),
              SizedBox(
                width: double.infinity,
                child: buildRegularButton("Valider", createTicket)
              )
            ],
          )))),
        bottomNavigationBar: buildBottomNavBar()
        );
  }
}
