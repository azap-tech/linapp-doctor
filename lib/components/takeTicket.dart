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
  Ticket newTicket = new Ticket();

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
              HttpService().createTicket(newTicket);
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Expanded(
                      child: new RadioButtonGroup(
                          labels: <String>[
                            "HOMME",
                            "FEMME",
                          ],
                          onSelected: (String selected) => newTicket.sex = selected
                      ),
                    ),
                  ],
                ),
              ),
              new Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Expanded(
                      child: new TextFormField(
                        autofocus: true,
                        onChanged: (text) {
                          newTicket.name = text;
                        },
                        decoration:
                            InputDecoration(labelText: 'Entrez votre nom'),
                      ),
                    ),
                    new Expanded(
                      child: new TextFormField(
                        onChanged: (text) {
                          newTicket.pathology = text;
                        },
                        decoration:
                            InputDecoration(labelText: 'Entrez un motif'),
                      ),
                    )
                  ],
                ),
              ),
              new Expanded(
                  child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Expanded(
                    child: new TextField(
                        onChanged: (text) {
                          newTicket.phone = text;
                        },
                        decoration: InputDecoration(
                            labelText: 'Entrez un numéro de téléphone'),
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          WhitelistingTextInputFormatter.digitsOnly
                        ]),
                  )
                  ,
                  new Expanded(
                      child: new TextField(
                          onChanged: (text) {
                            newTicket.age = int.parse(text);
                          },
                          decoration:
                          InputDecoration(labelText: 'Entrez votre age'),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            WhitelistingTextInputFormatter.digitsOnly
                          ])
                  )

                ],
              ))
            ],
          ),
        );
  }
}
