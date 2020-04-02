import 'package:azap_app/components/doctor_profile_page.dart';
import 'package:azap_app/design_system/azapColor.dart';
import 'package:flutter/material.dart';

class RegisterLoginPage extends StatelessWidget {
  const RegisterLoginPage({Key key}) : super(key: key);

  void _goLogin(context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => DoctorProfilePage()),
    );
  }

  void _goRegister(context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => DoctorProfilePage()),
    );
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
      body: SingleChildScrollView( scrollDirection: Axis.vertical, child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10),
                ),
                Align(
                  child: Image.asset('assets/register.png', height: 300.0),
                  alignment: Alignment.center,
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                ),
                Container(
                  child: Text(
                    'Concentrez-vous sur l’essentiel',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: Color.fromARGB(255, 5, 82, 136),
                      fontSize: 18,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(children: <Widget>[
                    Row(children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Text(
                          "Plus de gestion opérationnelle, vous pouvez vous concentrer sur le bien-être de vos patients",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            color: Color.fromARGB(255, 5, 82, 136),
                            fontSize: 18,
                          ),
                        ),
                      )
                    ]),
                  ]),
                ),
              ],
            ),
            Column(children: <Widget>[
              SizedBox(
                  height: 55,
                  width: double.infinity,
                  child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: FlatButton(
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(5),
                        ),
                        color: Color.fromARGB(255, 255, 196, 12),
                        child: Text(
                          'Créer un compte',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        onPressed: () => {
                          _goRegister(context)
                        },
                      ))),
              Padding(
                padding: EdgeInsets.all(10),
              ),
              SizedBox(
                  height: 55,
                  width: double.infinity,
                  child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: FlatButton(
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(5),
                            side: BorderSide(
                                color: Color.fromARGB(255, 5, 82, 136),
                                width: 2)),
                        color: Colors.white,
                        child: Text(
                          'Connexion',
                          style: TextStyle(
                            color: Color.fromARGB(255, 5, 82, 136),
                            fontSize: 18,
                          ),
                        ),
                        onPressed: () => {
                          _goLogin(context)
                        },
                      ))),
            ]),
            Padding(
              padding: EdgeInsets.all(20),
            ),
          ])),
    );
  }
}
