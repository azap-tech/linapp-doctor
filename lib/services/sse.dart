import 'package:async/async.dart';
import 'package:azap_app/classes/genericPayload.dart';
import 'package:azap_app/classes/queuePayload.dart';
import 'package:azap_app/classes/ticketPayload.dart';
import 'package:azap_app/stores/queue.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:eventsource/eventsource.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logger/logger.dart';

import '../main.dart';

class SseService {
  static final SseService _instance = SseService._internal();
  final _initEventSource = new AsyncMemoizer<EventSource>();
  static EventSource eventSource;
  var logger = Logger();

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
        logger.i("New event data: ${event.data}");
        final genericPayload = JsonMapper.deserialize<GenericPayload>(event.data);
        switch(genericPayload.type) {
          case "newticket": {
            final ticketPayload = JsonMapper.deserialize<TicketPayload>(event.data);
            ticketPayload.payload.doctorId = doctor.id;
            queue.updateTicket(ticketPayload.payload);
            queue.reorderTickets();
            break;
          }
          case "nextticket": {
            JsonMapper().useAdapter(JsonMapperAdapter(
                valueDecorators: {
                  typeOf<List<Queue>>(): (value) => value.cast<Queue>()
                })
            );
            final queuePayload = JsonMapper.deserialize<QueuePayload>(event.data);
            queue.tickets.clear();
            queue.replaceQueue(queuePayload.queueLines.elementAt(0));
            break;
          }
        }
      });
    }
  }
}