import 'package:azap_app/components/add_location_page.dart';
import 'package:azap_app/components/doctor_profile_page.dart';
import 'package:azap_app/design_system/themeData.dart';
import 'package:azap_app/services/http.dart';
import 'package:azap_app/services/sse.dart';
import 'package:azap_app/stores/doctor.dart';
import 'package:azap_app/stores/tickets.dart';
import 'package:flutter/material.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart' show JsonMapper;
import 'package:dart_json_mapper_mobx/dart_json_mapper_mobx.dart' show mobXAdapter;
import 'package:requests/requests.dart';
import 'main.reflectable.dart' show initializeReflectable;
import 'package:flutter_dotenv/flutter_dotenv.dart';

final doctor = Doctor();
final tickets = Tickets();
Map<String, String> sessionCookie;

Future main() async {
  await DotEnv().load('.env');
  initializeReflectable();
  JsonMapper().useAdapter(mobXAdapter);

  String hostname = Requests.getHostname("${DotEnv().env['BASE_URL']}");
  sessionCookie = await Requests.getStoredCookies(hostname);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // TODO if valid session, go to doctor status and init sse + get state, else go to login sms if session invalid to renew
  handleLogin() {
    if(sessionCookie.containsKey('actix-session') && sessionCookie['actix-session'].contains('azap')){
      //HttpService().getStatus();
      //SseService().initEventSource(1);
    } else {

    }
    return DoctorProfilePage();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Azap',

      // TODO sert à quoi ?
      debugShowCheckedModeBanner: false,
      theme: themeData(),
      home: handleLogin(),
    );
  }
}
