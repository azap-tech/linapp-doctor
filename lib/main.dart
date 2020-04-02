import 'package:azap_app/components/add_location_page.dart';
import 'package:azap_app/components/kanban.dart';
import 'package:azap_app/design_system/themeData.dart';
import 'package:azap_app/components/onboarding_page.dart';
import 'package:azap_app/services/http.dart';
import 'package:azap_app/services/sse.dart';
import 'package:azap_app/stores/doctor.dart';
import 'package:flutter/material.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart' show JsonMapper;
import 'package:dart_json_mapper_mobx/dart_json_mapper_mobx.dart' show mobXAdapter;
import 'package:requests/requests.dart';
import 'main.reflectable.dart' show initializeReflectable;
import 'package:flutter_dotenv/flutter_dotenv.dart';

final doctor = Doctor();
Map<String, String> sessionCookie;
Widget startWidget;

// TODO if valid session, go to doctor status and init sse + get state, else go to login sms if session invalid to renew
Future<Widget> handleLogin() async {
  // TODO azap or azap-doctor or azap-location ?
  //if(sessionCookie.containsKey('actix-session') && sessionCookie['actix-session'].contains('azap') && sessionCookie['actix-session'].contains('azap-doctor') && sessionCookie['actix-session'].contains('azap-location')){
  if(sessionCookie.containsKey('actix-session') && sessionCookie['actix-session'].contains('azap') && sessionCookie['actix-session'].contains('azap-doctor')){
    var payload = await HttpService().getStatus();
    if(payload != null && payload.status == "ok" && doctor.locationId != null){
      SseService().initEventSource(doctor.locationId);
      // TODO go to doctor state
      return Kanban();
    } else if(payload != null && payload.status == "ok") {
      return AddLocationPage();
    } else {
      // TODO verify phone or login ? + logout
      //return VerifyPhone();
      return OnBoardingPage();
    }
  } else if(sessionCookie.containsKey('actix-session')) {
    // TODO verify phone or login ? + logout
    //return VerifyPhone();
    return OnBoardingPage();
  } else {
    return OnBoardingPage();
  }
}

Future main() async {
  await DotEnv().load('.env');
  initializeReflectable();
  JsonMapper().useAdapter(mobXAdapter);

  String hostname = Requests.getHostname("${DotEnv().env['BASE_URL']}");
  sessionCookie = await Requests.getStoredCookies(hostname);

  startWidget = await handleLogin();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Azap',

      // TODO sert à quoi ?
      debugShowCheckedModeBanner: false,
      theme: themeData(),
      home: startWidget,
    );
  }
}
