import 'package:async/async.dart';
import 'package:azap_app/classes/genericPayload.dart';
import 'package:azap_app/classes/ticketPayload.dart';
import 'package:azap_app/classes/doctorPayload.dart';
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
    }
    eventSource.listen((Event event) {
      print("New event:");
      print("  data: ${event.data}");
      final genericPayload = JsonMapper.deserialize<GenericPayload>(event.data);
      // TODO new lists copy ?
      switch(genericPayload.type) {
        case "newdoctor": {
          final doctorPayload = JsonMapper.deserialize<DoctorPayload>(event.data);
          doctors.addDoctor(doctorPayload.payload);
          break;
        }
        case "newticket": {
          final ticketPayload = JsonMapper.deserialize<TicketPayload>(event.data);
          tickets.addTicket(ticketPayload.payload);
          break;
        }
        case "updateticket": {
          final ticketPayload = JsonMapper.deserialize<TicketPayload>(event.data);
          // TODO manual update vs call get list on back ?
          // TODO keep position in list. Back will keep position

          //remove old ticket.
          // TODO do nothing if vue already ok ?
          if(ticketPayload.payload.doctorId != null){
            doctors.list.forEach((doctor) {
              int indexTicket = doctor.listPatients.indexWhere((ticket) {
                return ticket.id == ticketPayload.payload.id;
              });
              if(indexTicket > -1){
                doctor.listPatients.removeAt(indexTicket);
              }
            });
          } else {
            int indexTicket = tickets.list.indexWhere((ticket) {
              return ticket.id == ticketPayload.payload.id;
            });
            if(indexTicket > -1){
              tickets.list.removeAt(indexTicket);
            }
          }

          // add new ticket
          if(ticketPayload.payload.doctorId != null){
            int indexDoctor = doctors.list.indexWhere((doctor) {
              return doctor.id == ticketPayload.payload.doctorId;
            });
            doctors.list.elementAt(indexDoctor).listPatients.add(ticketPayload.payload);
          } else {
            tickets.addTicket(ticketPayload.payload);
          }

          break;
        }
      }
    });
  }
}