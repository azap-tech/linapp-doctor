import 'package:async/async.dart';
import 'package:azap_app/classes/genericPayload.dart';
import 'package:azap_app/classes/ticketPayload.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:eventsource/eventsource.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../main.dart';

class SseService {
  static final SseService _instance = SseService._internal();
  final _initEventSource = new AsyncMemoizer<EventSource>();
  static EventSource eventSource;

  factory SseService() {
    return _instance;
  }

  SseService._internal() {
  }

  initEventSource (int storeId) async {
    if(eventSource == null){
      eventSource = await _initEventSource.runOnce(() async {
        return await EventSource.connect("${DotEnv().env['BASE_URL']}/api/v1/location/events?token=${storeId}");
      });
      eventSource.listen((Event event) {
        print("New event:");
        print("  data: ${event.data}");
        final genericPayload = JsonMapper.deserialize<GenericPayload>(event.data);
        switch(genericPayload.type) {
          case "newticket": {
            final ticketPayload = JsonMapper.deserialize<TicketPayload>(event.data);
            // TODO API change, handle solo doctor
            ticketPayload.payload.doctorId = doctor.id;
            doctor.updatePatient(ticketPayload.payload);
            doctor.reorderPatients();
            break;
          }
          case "nextticket": {
            final ticketPayload = JsonMapper.deserialize<TicketPayload>(event.data);
            doctor.nextPatient(ticketPayload.payload, ticketPayload.oldTicketId);
            doctor.reorderPatients();
            break;
          }
        }
      });
    }
  }
}