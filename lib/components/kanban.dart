import 'dart:collection';
import 'package:azap_app/components/takeTicket.dart';
import 'package:azap_app/components/workerInput.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../main.dart';

final String waitList = "Non trié";

class Item {
  final String id;
  String listId;
  final String title;

  Item({this.id, this.listId, this.title});
}

class Kanban extends StatefulWidget {
  final double tileHeight = 100;
  final double headerHeight = 80;
  final double tileWidth = 300;

  @override
  _KanbanState createState() => _KanbanState();
}

class _KanbanState extends State<Kanban> {
  LinkedHashMap<String, List<Item>> board;

  @override
  void initState() {
    // TODO fusion hash map and workers
    board = LinkedHashMap();
    board[waitList] = [];
    super.initState();
  }

  buildItemDragTarget(listId, targetPosition, double height) {
    return DragTarget<Item>(
      // Will accept others, but not himself
      onWillAccept: (Item data) {
        return board[listId].isEmpty ||
            data.id != board[listId][targetPosition].id;
      },
      // Moves the card into the position
      onAccept: (Item data) {
        setState(() {
          board[data.listId].remove(data);
          data.listId = listId;
          if (board[listId].length > targetPosition) {
            board[listId].insert(targetPosition + 1, data);
          } else {
            board[listId].add(data);
          }
        });
      },
      builder:
          (BuildContext context, List<Item> data, List<dynamic> rejectedData) {
        if (data.isEmpty) {
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
              ...data.map((Item item) {
                return Opacity(
                  opacity: 0.5,
                  child: ItemWidget(item: item),
                );
              }).toList()
            ],
          );
        }
      },
    );
  }

  buildHeader(String listId) {
    Widget header = Container(
      height: widget.headerHeight,
      child: HeaderWidget(title: listId),
    );

    return Stack(
      // The header
      children: [
        Draggable<String>(
          data: listId,
          child: header, // A header waiting to be dragged
          childWhenDragging: Opacity(
            // The header that's left behind
            opacity: 0.2,
            child: header,
          ),
          feedback: FloatingWidget(
            child: Container(
              // A header floating around
              width: widget.tileWidth,
              child: header,
            ),
          ),
        ),
        buildItemDragTarget(listId, 0, widget.headerHeight),
        DragTarget<String>(
          // Will accept others, but not himself
          onWillAccept: (String incomingListId) {
            return listId != incomingListId;
          },
          // Moves the card into the position
          onAccept: (String incomingListId) {
            setState(
                  () {
                LinkedHashMap<String, List<Item>> reorderedBoard =
                LinkedHashMap();
                for (String key in board.keys) {
                  if (key == incomingListId) {
                    reorderedBoard[listId] = board[listId];
                  } else if (key == listId) {
                    reorderedBoard[incomingListId] = board[incomingListId];
                  } else {
                    reorderedBoard[key] = board[key];
                  }
                }
                board = reorderedBoard;
              },
            );
          },

          builder: (BuildContext context, List<String> data,
              List<dynamic> rejectedData) {
            if (data.isEmpty) {
              // The area that accepts the draggable
              return Container(
                height: widget.headerHeight,
                width: widget.tileWidth,
              );
            } else {
              return Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 3,
                    color: Colors.blueAccent,
                  ),
                ),
                height: widget.headerHeight,
                width: widget.tileWidth,
              );
            }
          },
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {

    buildKanbanList(String listId, List<Item> items) {
      return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          color: Color(0xFFAEE1FA),
          child: Column(
          children: [
            buildHeader(listId),
            ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                // A stack that provides:
                // * A draggable object
                // * An area for incoming draggables
                return Stack(
                  children: [
                    Draggable<Item>(
                      data: items[index],
                      child: ItemWidget(
                        item: items[index],
                      ), // A card waiting to be dragged
                      childWhenDragging: Opacity(
                        // The card that's left behind
                        opacity: 0.2,
                        child: ItemWidget(item: items[index]),
                      ),
                      feedback: Container(
                        // A card floating around
                        height: widget.tileHeight,
                        width: widget.tileWidth,
                        child: FloatingWidget(
                            child: ItemWidget(
                              item: items[index],
                            )),
                      ),
                    ),
                    buildItemDragTarget(listId, index, widget.tileHeight),
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
      appBar: AppBar(title:Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      RaisedButton(
        onPressed: () {newWorkerDialog(context);},
        color: Color(0xFFFFCC09),
        child: const Text(
            'Ajouter une file',
            style: TextStyle(
                fontSize: 20,
                color: Colors.white
            )
        ),
      ),
      RaisedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TakeTicket()),
          );
        },
        color: Color(0xFFFFCC09),
        child: const Text(
            'Ajouter un patient',
            style: TextStyle(
                fontSize: 20,
                color: Colors.white
            )
        ),
      ),
      ])),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Observer(
            builder: (_) {
              // TODO fusion hashmap and workers + handle update ticket move sync
              workers.list.forEach((worker) => {
                if(board["${worker.name}"] == null){
                  board["${worker.name}"] = []
                }
              });
              board[waitList] = [];
              tickets.list.forEach((ticket) => {
                board[waitList].add(Item(id: "${ticket.id}", listId: waitList, title: "Ticket ${ticket.name} ${ticket.id}"))
              });
              return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: board.keys.map((String key) {
                    return Container(
                      width: widget.tileWidth,
                      child: buildKanbanList(key, board[key]),
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
            fontWeight: FontWeight.bold
          ),
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
  final Item item;

  const ItemWidget({Key key, this.item}) : super(key: key);
  ListTile makeListTile(Item item) => ListTile(
    contentPadding: EdgeInsets.symmetric(
      horizontal: 20.0,
      vertical: 10.0,
    ),
    title: Text(
      item.title,
      style: TextStyle(
        color: Color(0xFF049BE5),
        fontWeight: FontWeight.bold,
        fontSize: 20
      ),
    ),
    subtitle: Text(
        "listId: ${item.listId}",
        style: TextStyle(
          color: Color(0xFF049BE5),
        ),
    ),
    trailing: Icon(
      Icons.sort,
      color: Color(0xFF049BE5),
      size: 30.0,
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
        child: makeListTile(item),
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