import 'dart:async';
import 'package:azap_app/components/add_location_page.dart';
import 'package:azap_app/design_system/appbar.dart';
import 'package:azap_app/design_system/azapColor.dart';
import 'package:flutter/material.dart';

class CodeValid extends StatefulWidget {
  @override
  _CodeValidState createState() => _CodeValidState();
}

class _CodeValidState extends State<CodeValid> {
  int _counter = 3;
  double _progressValue = 0.0;
  Timer timer;

  void remove() {
    setState(() {
      _counter--;
      _progressValue += 1 / 3;
    });
    if (_counter <= 0) {
      timer.cancel();
      // TODO : change redirection
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => AddLocationPage()));
    }
  }

  waitRedirect() {
    // TODO : je ne comprend pas pourquoi il faut je me donne 1500 pour avoir un timer de 3 secondes ...
    timer = Timer.periodic(Duration(milliseconds: 1500), (timer) {
      remove();
    });
  }

  @override
  void initState() {
    super.initState();
    waitRedirect();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(context),
        body: Padding(
            padding: const EdgeInsets.all(38.0),
            child: Column(children: <Widget>[
              Text(
                "Code valide !",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 24,
                    fontFamily: Theme.of(context).textTheme.title.fontFamily,
                    color: Theme.of(context).textTheme.title.color,
                    fontWeight: Theme.of(context).textTheme.title.fontWeight),
              ),
              Text(
                "Félicitation, votre compte est bien activé, vous allez être redirigé automatiquement",
                style: TextStyle(
                    fontFamily: Theme.of(context).textTheme.title.fontFamily,
                    fontSize: 15),
              ),
              SizedBox(
                height: 23,
              ),
              Container(
                height: 100,
                child: Image.asset(
                  "assets/images/valid.png",
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
              ),
              Column(
                children: <Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: Stack(
                      children: <Widget>[
                        Center(
                          child: Container(
                            width: MediaQuery.of(context).size.height * 0.1,
                            height: MediaQuery.of(context).size.height * 0.1,
                            child: new CircularProgressIndicator(
                              value: _progressValue,
                              backgroundColor: Colors.grey,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  AzapColor.blue[50]),
                              strokeWidth: 10,
                            ),
                          ),
                        ),
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                _counter.toString(),
                                style: Theme.of(context).textTheme.title,
                              ),
                              Text("sec",
                                  style: Theme.of(context).textTheme.title)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ])));
  }
}
