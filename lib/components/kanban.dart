import 'dart:collection';
import 'package:azap_app/components/takeTicket.dart';
import 'package:azap_app/design_system/azapColor.dart';
import 'package:azap_app/stores/doctor.dart';
import 'package:azap_app/stores/ticket.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import '../main.dart';

final DateFormat dateFormat = DateFormat("HH:mm");

class Kanban extends StatefulWidget {
  final double tileHeight = 100;
  final double headerHeight = 80;
  final double tileWidth = 350;

  @override
  _KanbanState createState() => _KanbanState();
}

class _KanbanState extends State<Kanban> {
  List<Doctor> board;
  bool foldCards;

  buildPatient(String name, int id) {
    Ticket testTicket = new Ticket();
    testTicket.name = name;
    testTicket.id = id;
    testTicket.age = 99;
    testTicket.pathology = "Covid 19";
    testTicket.sex = "FEMME";
    testTicket.doctorId = 999;
    testTicket.creationTime = DateTime.now();
    return testTicket;
  }

  @override
  void initState() {
    board = List<Doctor>();
    foldCards = true;

    // TODO delete
    doctor.addPatient(buildPatient("Mme Michu", 999));
    doctor.addPatient(buildPatient("Mme Michu 2", 998));

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
          color: AzapColor.backgroundColor,
          child: Column(
            mainAxisSize: MainAxisSize.max,
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
                        index: index,
                        foldCard: foldCards,
                      ),
                    ],
                  );
                },
              ),
              new FlatButton(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 110),
                child: new Text(
                    "Suivant",
                    style: TextStyle(fontSize: 20, color: Colors.white)
                ),
                color: AzapColor.accentColor,
                onPressed: () {
                  // TODO next ticket doctor
                },
              )
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Color(0xFFEAF4FB),
      appBar: AppBar(
          backgroundColor: AzapColor.mainColor,
          title: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
        RaisedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TakeTicket()),
            );
          },
          color: AzapColor.accentColor,
          child: const Text('Ajouter un patient',
              style: TextStyle(fontSize: 20, color: Colors.white)),
        ),
                RaisedButton(
                  onPressed: () {
                    setState(() {
                      foldCards = !foldCards;
                    });
                  },
                  color: AzapColor.accentColor,
                  child: Text (
                      (foldCards == true ? 'Déplier' : 'Plier'),
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: board.map((doctor) {
                return Container(
                  // TODO center no margin
                  margin: EdgeInsets.only(left: 30, top: 10),
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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0.0),
      ),
      color: AzapColor.mainColor,
      child: ListTile(
        dense: true,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 10.0,
        ),
        title: Text(
          title,
          style: TextStyle(
              color: AzapColor.accentColor,
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
  final int index;
  final bool foldCard;

  const ItemWidget({Key key, this.ticket, this.index, this.foldCard}) : super(key: key);

  ListTile makeListTile(Ticket ticket) => ListTile(
        contentPadding: EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: foldCard == true ? 0 : 10.0,
        ),
        title: Text(
          index == 0 ? "${ticket.name} - En cours" : ticket.name,
          style: TextStyle(
              color: index == 0 ? Colors.white : AzapColor.secondColor,
              fontWeight: FontWeight.bold,
              fontSize: 20),
        ),
        subtitle: foldCard == true ? Container(width: 0, height: 0,) : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              ticket.pathology,
              style: TextStyle(
                color: index == 0 ? Colors.white : AzapColor.secondColor,
              ),
            ),
            Text(
              ticket.sex,
              style: TextStyle(
                color: index == 0 ? Colors.white : AzapColor.secondColor,
              ),
            ),
            Text(
              "${ticket.age.toString()} ans",
              style: TextStyle(
                color: index == 0 ? Colors.white : AzapColor.secondColor,
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
                color: index == 0 ? Colors.white : AzapColor.secondColor,
              ),
            ),
            foldCard == true ? Container(width: 0, height: 0,) : Text(
              dateFormat.format(ticket.creationTime),
              style: TextStyle(
                color: index == 0 ? Colors.white : AzapColor.secondColor,
              ),
            )
          ],
        ),
        onTap: () {},
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: foldCard == true ? 60 : 110,
      child:Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Container(
          decoration: new BoxDecoration(
              color: index == 0 ? AzapColor.firstListColor : Colors.white,
              borderRadius: new BorderRadius.all(Radius.circular(8.0))
          ),
        child: makeListTile(ticket),
      ),
    ));
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
