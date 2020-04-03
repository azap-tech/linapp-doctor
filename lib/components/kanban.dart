import 'package:azap_app/design_system/azapColor.dart';
import 'package:azap_app/design_system/error/snackbar.dart';
import 'package:azap_app/services/http.dart';
import 'package:azap_app/stores/doctor.dart';
import 'package:azap_app/stores/queue.dart';
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
  Queue board;
  bool foldCards;
  bool httpError;

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

  nextPatient(){
    // TODO loader and lock button on long http call
    if (!httpError) {
      HttpService().nextTicket().then((payload){
        if(payload != null && payload.status == "ok"){
          setState(() {
            board.tickets.clear();
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
  void initState() {
    super.initState();
    board = Queue();
    foldCards = true;
    httpError = false;
  }

  buildHeader(Doctor doctor) {
    return Container(
      height: widget.headerHeight,
      child: HeaderWidget(title: doctor.name),
    );
  }

  @override
  Widget build(BuildContext context) {
    buildKanbanList(Doctor doctor) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.8,
        color: Theme.of(context).backgroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Flexible(flex: 1, fit: FlexFit.tight, child: buildHeader(doctor)),
            Flexible(
              flex: 8,
              fit: FlexFit.tight,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.6,
                child: ListView.builder(
                  primary: false,
                  shrinkWrap: true,
                  itemCount: queue.tickets.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ItemWidget(
                      ticket: queue.tickets.elementAt(index),
                      index: index,
                      foldCard: foldCards,
                    );
                  },
                ),
              ),
            ),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Container(
                width: 900,
                child: new FlatButton(
                  child: new Text("Suivant",
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                  color: Theme.of(context).accentColor,
                  onPressed: nextPatient,
                ),
              ),
            )
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: Color(0xFFEAF4FB),
      appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          centerTitle: true,
          title: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(
                    'assets/logo.png',
                    fit: BoxFit.contain,
                    height: 32
                ),
                RaisedButton(
                  onPressed: () {
                    setState(() {
                      foldCards = !foldCards;
                    });
                  },
                  color: Theme.of(context).accentColor,
                  child: Text((foldCards == true ? 'Déplier' : 'Plier'),
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                ),
              ])),
      body: Padding(
        padding: EdgeInsets.all(27),
        child: Observer(builder: (_) {
          board.tickets.clear();
          if (doctor.id != null) {
            board = queue;
          }
          return buildKanbanList(doctor);
        }),
      ),
        bottomNavigationBar: buildBottomNavBar()
    );
  }
}

// The list header (static)
class HeaderWidget extends StatelessWidget {
  final String title;

  const HeaderWidget({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: ListTile(
        dense: true,
        title: Text(
          title,
          style: TextStyle(
              color: Theme.of(context).accentColor,
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

  const ItemWidget({Key key, this.ticket, this.index, this.foldCard})
      : super(key: key);

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
        subtitle: foldCard == true
            ? Container(
                width: 0,
                height: 0,
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
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
            foldCard == true
                ? Container(
                    width: 0,
                    height: 0,
                  )
                : Text(
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
        child: Card(
          elevation: 8.0,
          margin: new EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 6.0,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Container(
            decoration: new BoxDecoration(
                color: index == 0 ? AzapColor.firstListColor : Colors.white,
                borderRadius: new BorderRadius.all(Radius.circular(8.0))),
            child: makeListTile(ticket),
          ),
        ));
  }
}
