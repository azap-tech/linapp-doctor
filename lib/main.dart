import 'package:azap_app/components/kanban.dart';
import 'package:azap_app/components/verifyPhone.dart';
import 'package:azap_app/design_system/themeData.dart';
import 'package:azap_app/components/onboarding_page.dart';
import 'package:azap_app/services/http.dart';
import 'package:azap_app/services/sse.dart';
import 'package:azap_app/stores/doctor.dart';
import 'package:azap_app/stores/tickets.dart';
import 'package:flutter/material.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart' show JsonMapper;
import 'package:dart_json_mapper_mobx/dart_json_mapper_mobx.dart' show mobXAdapter;
import 'package:requests/requests.dart';
import 'components/add_location_page.dart';
import 'main.reflectable.dart' show initializeReflectable;
import 'package:flutter_dotenv/flutter_dotenv.dart';

final doctor = Doctor();
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
    // TODO azap or azap-doctor or azap-location ?
    if(sessionCookie.containsKey('actix-session') && sessionCookie['actix-session'].contains('azap') && sessionCookie['actix-session'].contains('azap-doctor') && sessionCookie['actix-session'].contains('azap-location')){
      return HttpService().getStatus().then((payload){
        if(payload != null && payload.status == "ok"){
          SseService().initEventSource(doctor.locationId);
          // TODO go to doctor state
          return Kanban();
        } else {
          // TODO verify phone or login ?
          //return VerifyPhone();
          return OnBoardingPage();
        }
      });
    } else if(sessionCookie.containsKey('actix-session')) {
      // TODO verify phone or login ?
      //return VerifyPhone();
      return OnBoardingPage();
    } else {
      return OnBoardingPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Azap',
      debugShowCheckedModeBanner: false,
      theme: themeData(),
      home: handleLogin(),
    );
  }
}
