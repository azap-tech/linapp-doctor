import 'package:azap_app/design_system/azapColor.dart';
import 'package:flutter/material.dart';

class VerifyPhone extends StatefulWidget {
  @override
  _VerifyPhoneState createState() => _VerifyPhoneState();
}

class _VerifyPhoneState extends State<VerifyPhone> {
  final _codeSMSController = TextEditingController();
  bool errorCode = false;

  void _submitTxt() {
    if (_codeSMSController.text.isEmpty) {
      return;
    }

    // TODO : A changer par la vrai vérification du code
    setState(() {
      _codeSMSController.text.length < 4 ? errorCode = true : errorCode = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(title: Text("Azap"), centerTitle: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(38.0),
          child: Column(
            children: <Widget>[
              Text(
                errorCode ? "Code invalide ..." : "Code de vérification",
                style: TextStyle(
                    fontSize: 24,
                    fontFamily: Theme.of(context).textTheme.title.fontFamily,
                    color: Theme.of(context).textTheme.title.color,
                    fontWeight: Theme.of(context).textTheme.title.fontWeight),
              ),
              Text(
                errorCode
                    ? "Merci de ressaisir le code reçu par SMS"
                    : "Afin de valider votre compte",
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
                  errorCode
                      ? "assets/images/error.png"
                      : "assets/images/sms.png",
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Text(
                  "Le code reçu par SMS",
                  style: Theme.of(context).textTheme.subtitle,
                  textAlign: TextAlign.start,
                ),
              ),
              TextField(
                controller: _codeSMSController,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitTxt(),
                decoration: new InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: new OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(4.0),
                      ),
                      borderSide: new BorderSide(
                          width: 3.0,
                          color: errorCode
                              ? AzapColor.errorColor
                              : Theme.of(context).hintColor),
                    ),
                    border: new OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(4.0),
                      ),
                      borderSide: new BorderSide(width: 3.0),
                    )),
              ),
              SizedBox(
                height: 24,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Text(
                  "Code non reçu ?",
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: Theme.of(context).textTheme.subtitle.fontSize,
                      fontFamily:
                          Theme.of(context).textTheme.subtitle.fontFamily,
                      fontWeight:
                          Theme.of(context).textTheme.subtitle.fontWeight,
                      color: Theme.of(context).textTheme.subtitle.color),
                  textAlign: TextAlign.start,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
