import 'package:azap_app/components/login.dart';
import 'package:azap_app/services/http.dart';
import 'package:azap_app/services/sms.dart';
import 'package:azap_app/services/sse.dart';
import 'package:azap_app/stores/doctor.dart';
import 'package:azap_app/stores/doctors.dart';
import 'package:azap_app/stores/tickets.dart';
import 'package:azap_app/services/http.dart';
import 'package:flutter/material.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart' show JsonMapper;
import 'package:dart_json_mapper_mobx/dart_json_mapper_mobx.dart' show mobXAdapter;
import 'main.reflectable.dart' show initializeReflectable;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'components/kanban.dart';

final doctor = Doctor();
final tickets = Tickets();

void main() {
  initializeReflectable();
  JsonMapper().useAdapter(mobXAdapter);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    DotEnv().load('.env').then((callback) {
      // TODO create location or login on location
      HttpService().login(1, DotEnv().env['STORE_PIN']).then((callback) {
        HttpService().getStatus();
      });
      //TODO select location in an interface
      SseService().initEventSource(1);
    });
    return MaterialApp(
      title: 'Azap',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}
