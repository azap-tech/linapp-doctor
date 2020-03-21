import 'package:azap_app/services/http.dart';
import 'package:azap_app/services/sms.dart';
import 'package:azap_app/services/sse.dart';
import 'package:azap_app/stores/tickets.dart';
import 'package:azap_app/stores/workers.dart';
import 'package:flutter/material.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart' show JsonMapper;
import 'package:dart_json_mapper_mobx/dart_json_mapper_mobx.dart' show mobXAdapter;
import 'package:flutter/services.dart';
import 'main.reflectable.dart' show initializeReflectable;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'components/kanban.dart';

final workers = Workers();
final tickets = Tickets();

void main() {
  initializeReflectable();
  JsonMapper().useAdapter(mobXAdapter);
  SystemChrome.setEnabledSystemUIOverlays([]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // TODO login page
    DotEnv().load('.env').then((callback) {
      HttpService().enterPin(DotEnv().env['STORE_PIN']).then((callback) {
        HttpService().syncState(1);
      });
      SseService().initEventSource(1);
    });
    SmsService();
    return MaterialApp(
      title: 'Azap',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Kanban(),
    );
  }
}
