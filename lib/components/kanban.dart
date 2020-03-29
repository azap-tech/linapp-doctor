import 'dart:collection';
import 'package:azap_app/components/takeTicket.dart';
import 'package:azap_app/components/doctorInput.dart';
import 'package:azap_app/stores/doctor.dart';
import 'package:azap_app/stores/ticket.dart';
import 'package:azap_app/services/http.dart';
import 'package:dart_json_mapper_mobx/dart_json_mapper_mobx.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import '../main.dart';

final DateFormat dateFormat = DateFormat("HH:mm");

class Kanban extends StatefulWidget {
  final double tileHeight = 100;
  final double headerHeight = 80;
  final double tileWidth = 300;

  @override
  _KanbanState createState() => _KanbanState();
}

class _KanbanState extends State<Kanban> {
  List<Doctor> board;

  @override
  void initState() {
    board = List<Doctor>();
    super.initState();
  }

  buildHeader(Doctor doctor) {
    Widget header = Container(
      height: widget.headerHeight,
      child: HeaderWidget(title: doctor.name),
    );

    return Stack(
      // The header
      children: [
        header
      ],
    );
  }

  @override
  Widget build(BuildContext context) {

    buildKanbanList(Doctor doctor) {
      return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          color: Color(0xFFAEE1FA),
          child: Column(
            //mainAxisSize: MainAxisSize.max,
            children: [
              buildHeader(doctor),
              ListView.builder(
                scrollDirection: Axis.vertical,
                primary: false,
                shrinkWrap: true,
                itemCount: doctor.listPatients.length,
                itemBuilder: (BuildContext context, int index) {
                  // A stack that provides:
                  // * A draggable object
                  // * An area for incoming draggables
                  return Stack(
                    children: [
                      ItemWidget(
                        ticket: doctor.listPatients.elementAt(index),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Color(0xFFEAF4FB),
      appBar: AppBar(
          title: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        RaisedButton(
          onPressed: () {
            newDoctorDialog(context);
          },
          color: Color(0xFFFFCC09),
          child: const Text('Ajouter une file',
              style: TextStyle(fontSize: 20, color: Colors.white)),
        ),
        RaisedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TakeTicket()),
            );
          },
          color: Color(0xFFFFCC09),
          child: const Text('Ajouter un patient',
              style: TextStyle(fontSize: 20, color: Colors.white)),
        ),
      ])),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Observer(builder: (_) {
          board.clear();
          if(doctor.id != null){
            board.add(doctor);
          }
          return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: board.map((doctor) {
                return Container(
                  width: widget.tileWidth,
                  child: buildKanbanList(doctor),
                );
              }).toList());
        }),
      ),
    );
  }
}

// The list header (static)
class HeaderWidget extends StatelessWidget {
  final String title;

  const HeaderWidget({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xff055D87),
      child: ListTile(
        dense: true,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 10.0,
        ),
        title: Text(
          title,
          style: TextStyle(
              color: Color(0xffFFCC09),
              fontSize: 25,
              fontWeight: FontWeight.bold),
        ),
        onTap: () {},
      ),
    );
  }
}

// The card (static)
class ItemWidget extends StatelessWidget {
  final Ticket ticket;

  const ItemWidget({Key key, this.ticket}) : super(key: key);

  ListTile makeListTile(Ticket ticket) => ListTile(
        contentPadding: EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 10.0,
        ),
        title: Text(
          ticket.name,
          style: TextStyle(
              color: Color(0xFF049BE5),
              fontWeight: FontWeight.bold,
              fontSize: 20),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              ticket.pathology,
              style: TextStyle(
                color: Color(0xFF049BE5),
              ),
            ),
            Text(
              ticket.sex,
              style: TextStyle(
                color: Color(0xFF049BE5),
              ),
            ),
            Text(
              "${ticket.age.toString()} ans",
              style: TextStyle(
                color: Color(0xFF049BE5),
              ),
            )
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Text(
              "#${ticket.id}",
              style: TextStyle(
                color: Color(0xFF049BE5),
              ),
            ),
            Text(
              dateFormat.format(ticket.creationTime),
              style: TextStyle(
                color: Color(0xFF049BE5),
              ),
            )
          ],
        ),
        onTap: () {},
      );

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFFFFFFFF),
        ),
        child: makeListTile(ticket),
      ),
    );
  }
}

class FloatingWidget extends StatelessWidget {
  final Widget child;

  const FloatingWidget({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: 0.1,
      child: child,
    );
  }
}
