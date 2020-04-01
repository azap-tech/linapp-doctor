import 'package:azap_app/components/register_login_page.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => RegisterLoginPage()),
    );
  }

  Widget _buildImage(String assetName) {
    return Align(
      child: Image.asset('assets/$assetName', height: 300.0),
      alignment: Alignment.center,
    );
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);
    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return Scaffold(
        appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 5, 82, 136),
            title: Image.asset('assets/logo.png',
                fit: BoxFit.contain, height: 32)),
        body: IntroductionScreen(
          key: introKey,
          pages: [
            PageViewModel(
              titleWidget: Container(
                child: Text(
                  'Vous vous libérez des contraintes',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: Color.fromARGB(255, 5, 82, 136),
                    fontSize: 18,
                  ),
                ),
              ),
              bodyWidget: Column(children: <Widget>[
                Row(children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Text(
                      "Oubliez le téléphone qui sonne et la salle d’attente chargée !",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        color: Color.fromARGB(255, 5, 82, 136),
                        fontSize: 18,
                      ),
                    ),
                  )
                ]),
                Padding(
                  padding: EdgeInsets.all(10),
                ),
                Row(children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Text(
                      "Vos patients arrivent à l’heure quand c’est leur tour.",
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
              image: _buildImage('onboard-1.png'),
              decoration: pageDecoration,
            ),
            PageViewModel(
              titleWidget: Container(
                child: Text(
                  'Vous décidez avec qui travailler',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: Color.fromARGB(255, 5, 82, 136),
                    fontSize: 18,
                  ),
                ),
              ),
              bodyWidget: Column(children: <Widget>[
                Row(children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Text(
                      "Créez-vous un profil pour être visible sur un lieu de consultation.",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        color: Color.fromARGB(255, 5, 82, 136),
                        fontSize: 18,
                      ),
                    ),
                  )
                ]),
                Padding(
                  padding: EdgeInsets.all(10),
                ),
                Row(children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Text(
                      "Travaillez seul ou rejoignez une équipe déjà en place.",
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
              image: _buildImage('onboard-3.png'),
              decoration: pageDecoration,
            ),
            PageViewModel(
              titleWidget: Container(
                child: Text(
                  'Vous aménagez votre temps',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: Color.fromARGB(255, 5, 82, 136),
                    fontSize: 18,
                  ),
                ),
              ),
              bodyWidget: Column(children: <Widget>[
                Row(children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Text(
                      "Indiquez votre temps de repos facilement tout en informant en direct.",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        color: Color.fromARGB(255, 5, 82, 136),
                        fontSize: 18,
                      ),
                    ),
                  )
                ]),
                Padding(
                  padding: EdgeInsets.all(10),
                ),
                Row(children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Text(
                      "Répartissez la charge et gagnez en efficacité.",
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
              image: _buildImage('onboard-2.png'),
              decoration: pageDecoration,
            ),
            PageViewModel(
              titleWidget: Container(
                child: Text(
                  'Vous choisissez où exercer',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: Color.fromARGB(255, 5, 82, 136),
                    fontSize: 18,
                  ),
                ),
              ),
              bodyWidget: Column(children: <Widget>[
                Row(children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Text(
                      "Créer un nouveau lieu ou rejoignez un lieu existant.",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        color: Color.fromARGB(255, 5, 82, 136),
                        fontSize: 18,
                      ),
                    ),
                  )
                ]),
                Padding(
                  padding: EdgeInsets.all(10),
                ),
                Row(children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Text(
                      "Idéal pour les lieux mobiles ou les structures d’urgence.",
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
              image: _buildImage('onboard-4.png'),
              decoration: pageDecoration,
            ),
          ],
          onDone: () => _onIntroEnd(context),
          //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
          showSkipButton: false,
          skipFlex: 0,
          nextFlex: 0,
          next: Text(
            'Suivant',
            style: TextStyle(color: Color.fromARGB(255, 5, 82, 136)),
          ),
          done: Text(
            'Continuer',
            style: TextStyle(color: Color.fromARGB(255, 5, 82, 136)),
          ),
          dotsDecorator: const DotsDecorator(
            size: Size(10.0, 10.0),
            color: Color(0xFFBDBDBD),
            activeSize: Size(22.0, 10.0),
            activeColor: Color.fromARGB(255, 5, 82, 136),
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
            ),
          ),
        ));
  }
}
