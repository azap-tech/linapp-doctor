import 'package:azap_app/components/add_location_page.dart';
import 'package:azap_app/components/kanban.dart';
import 'package:azap_app/components/verifyPhone.dart';
import 'package:azap_app/design_system/themeData.dart';
import 'package:azap_app/components/onboarding_page.dart';
import 'package:azap_app/services/http.dart';
import 'package:azap_app/services/sse.dart';
import 'package:azap_app/stores/doctor.dart';
import 'package:azap_app/stores/queue.dart';
import 'package:flutter/material.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart' show JsonMapper;
import 'package:dart_json_mapper_mobx/dart_json_mapper_mobx.dart' show mobXAdapter;
import 'package:requests/requests.dart';
import 'components/add_location_page.dart';
import 'main.reflectable.dart' show initializeReflectable;
import 'package:flutter_dotenv/flutter_dotenv.dart';

final doctor = Doctor();
final queue = Queue();
Map<String, String> sessionCookie;
Widget startWidget;

Future<Widget> handleLogin() async {
  if(DotEnv().env['MODE_MOCK'] == 'false'){
    /*var payload = await HttpService().getStatus();
    if(payload != null && payload.status == "ok" && doctor.locationId != null){
      SseService().initEventSource(doctor.locationId);
      // TODO go to doctor state
      return Kanban();
    } else if(payload != null && payload.status == "ok") {
      return AddLocationPage();
    } else if(sessionCookie.containsKey('actix-session')) {
      return VerifyPhone();
    } else {*/
      return OnBoardingPage();
    //}
  }else {
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
      debugShowCheckedModeBanner: false,
      theme: themeData(),
      home: startWidget,
    );
  }
}
