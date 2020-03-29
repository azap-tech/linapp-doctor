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
  Doctor waitList;
  List<Doctor> board;
  ScrollController scrollController;

  @override
  void initState() {
    board = List<Doctor>();
    scrollController = ScrollController();
    waitList = new Doctor();
    waitList.name = "A trier";
    waitList.id = -1;
    super.initState();
  }

  buildItemDragTarget(Doctor doctor, targetPosition, double height) {
    return DragTarget<Ticket>(
      // Will accept others, but not himself
      onWillAccept: (Ticket ticket) {
        return doctor.listPatients.isEmpty || !doctor.listPatients.contains(ticket);
      },
      // Moves the card into the position
      onAccept: (Ticket ticket) {
        setState(() {
        });
        if(ticket.doctorId != doctor.id){

          // TODO manual vs sse sync ? actual both
          // default waiting list
          int previousIndex = -1;
          if(ticket.doctorId != null){
            previousIndex = doctors.list.indexWhere((doctor) => doctor.id == ticket.doctorId);
          }
          // remove old position
          if(previousIndex > -1){
            Doctor previousDoctor = doctors.list.elementAt(previousIndex);
            previousDoctor.listPatients.remove(ticket);
          } else {
            tickets.list.remove(ticket);
          }
          // set new position
          ticket.doctorId = doctor.id;
          if(doctor.id > 0){
            int newDoctorIndex = doctors.list.indexOf(doctor);
            Doctor newDoctor = doctors.list.elementAt(newDoctorIndex);
            newDoctor.listPatients.add(ticket);
          } else {
            tickets.list.add(ticket);
          }

          // TODO handle position in back
          /*if (doctor.listPatients.length > targetPosition) {
              doctor.listPatients.insert(targetPosition + 1, ticket);
            } else {
              doctor.listPatients.add(ticket);
            }*/

          HttpService().updateTicket(ticket);
        }
      },
      builder:
          (BuildContext context, List<Ticket> tickets, List<dynamic> rejectedData) {
        if (tickets.isEmpty) {
          // The area that accepts the draggable
          return Container(
            height: height,
          );
        } else {
          return Column(
            // What's shown when hovering on it
            children: [
              Container(
                height: height,
              ),
              ...tickets.map((Ticket ticket) {
                return Opacity(
                  opacity: 0.5,
                  child: ItemWidget(ticket: ticket),
                );
              }).toList()
            ],
          );
        }
      },
    );
  }

  buildHeader(Doctor doctor) {
    Widget header = Container(
      height: widget.headerHeight,
      child: HeaderWidget(title: doctor.name),
    );

    return Stack(
      // The header
      children: [
        header,
        buildItemDragTarget(doctor, 0, widget.headerHeight),
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
                      new Listener(
                          child: LongPressDraggable<Ticket>(
                            maxSimultaneousDrags: 1,
                            data: doctor.listPatients.elementAt(index),
                            child: ItemWidget(
                              ticket: doctor.listPatients.elementAt(index),
                            ),
                            // A card waiting to be dragged
                            childWhenDragging: Opacity(
                              // The card that's left behind
                              opacity: 0.2,
                              child: ItemWidget(ticket: doctor.listPatients.elementAt(index)),
                            ),
                            feedback: Container(
                              // A card floating around
                              height: widget.tileHeight,
                              width: widget.tileWidth,
                              child: FloatingWidget(
                                  child: ItemWidget(
                                ticket: doctor.listPatients.elementAt(index),
                              )),
                            ),
                          ),
                          onPointerMove: (PointerMoveEvent event) {
                            // TODO smooth animation
                            if (event.position.dx > MediaQuery.of(context).size.width - 20) {
                              scrollController.jumpTo(scrollController.offset + 10);
                            } else if(event.position.dx <= 20){
                              scrollController.jumpTo(scrollController.offset - 10);
                            }
                          }),
                      buildItemDragTarget(doctor, index, widget.tileHeight),
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
        controller: scrollController,
        child: Observer(builder: (_) {
          board.clear();
          waitList.listPatients.clear();
          tickets.list.forEach((ticket) => {
            waitList.listPatients.add(ticket)
          });
          board.add(waitList);
          doctors.list.forEach((doctor) => {
            board.add(doctor)
          });
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
        trailing: Icon(
          Icons.sort,
          color: Color(0xffFFCC09),
          size: 30.0,
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
