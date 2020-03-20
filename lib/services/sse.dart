import 'package:azap_native_manager_app/classes/genericPayload.dart';
import 'package:azap_native_manager_app/classes/ticketPayload.dart';
import 'package:azap_native_manager_app/classes/workerPayload.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:eventsource/eventsource.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../main.dart';

class SseService {
  static final SseService _instance = SseService._internal();

  factory SseService() {
    return _instance;
  }

  SseService._internal() {
  }

  initEventSource (int storeId) async {
    EventSource eventSource = await EventSource.connect("${DotEnv().env['BASE_URL']}/api/v2/store/$storeId/events");
    eventSource.listen((Event event) {
      print("New event:");
      print("  data: ${event.data}");
      final genericPayload = JsonMapper.deserialize<GenericPayload>(event.data);
      switch(genericPayload.type) {
        case "newworker": {
          final workerPayload = JsonMapper.deserialize<WorkerPayload>(event.data);
          workers.addWorker(workerPayload.payload);
          break;
        }
        case "newticket": {
          final ticketPayload = JsonMapper.deserialize<TicketPayload>(event.data);
          tickets.addTicket(ticketPayload.payload);
          break;
        }
      }
    });
  }
}