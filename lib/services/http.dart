import 'package:azap_native_manager_app/classes/stateTicketPayload.dart';
import 'package:azap_native_manager_app/classes/stateWorkerPayload.dart';
import 'package:azap_native_manager_app/stores/ticket.dart';
import 'package:azap_native_manager_app/stores/worker.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';
import 'package:requests/requests.dart';

import '../main.dart';

class HttpService {
  static final HttpService _instance = HttpService._internal();

  factory HttpService() {
    return _instance;
  }

  HttpService._internal() {
  }

  // auto store cookie in storage
  Future enterPin(String pincode) async {
    var r = await Requests.post(
        "${DotEnv().env['BASE_URL']}/api/v2/store/auth",
        json: {
          "pincode": pincode,
        },
        bodyEncoding: RequestBodyEncoding.JSON);
    print("http status from login ${r.statusCode}");
    // throw exception if not 200
    r.raiseForStatus();
    dynamic json = r.json();
    print(json);
  }

  // auto store cookie in storage
  createTicket() async {
    var r = await Requests.post(
        "${DotEnv().env['BASE_URL']}/api/v2/ticket",
        json: {
          "storeId": 1,
          "workerId": 1,
          "prestations": [],
          "name": "New Patient",
          "phone": "0707070707",
          "azap": true,
        },
        bodyEncoding: RequestBodyEncoding.JSON);
    print("http status from ticket ${r.statusCode}");
    // throw exception if not 200
    r.raiseForStatus();
    dynamic json = r.json();
    print(json);
  }

  createWorker() async {
    DateFormat dateFormat = DateFormat("dd-HH-mm-ss");
    var r = await Requests.post(
        "${DotEnv().env['BASE_URL']}/api/v2/worker",
        json: {
          "storeId": 1,
          "name": "Prio ${dateFormat.format(new DateTime.now())}",
          "avatar": "/test.png",
          "phone": "0707070707",
          "isManager": false,
        },
        bodyEncoding: RequestBodyEncoding.JSON);
    print("http status from worker ${r.statusCode}");
    // throw exception if not 200
    r.raiseForStatus();
    dynamic json = r.json();
    print(json);
  }

  syncState(int storeId) async {
    var r = await Requests.get("${DotEnv().env['BASE_URL']}/api/v2/store/${storeId}/status");
    print("http status from get state ${r.statusCode}");
    // throw exception if not 200
    r.raiseForStatus();

    // TODO hack to deserialize list
    JsonMapper().useAdapter(JsonMapperAdapter(
        valueDecorators: {
          typeOf<List<Worker>>(): (value) => value.cast<Worker>()
        })
    );

    final stateWorkerPayload = JsonMapper.deserialize<StateWorkerPayload>(r.content());

    JsonMapper().useAdapter(JsonMapperAdapter(
        valueDecorators: {
          typeOf<List<Ticket>>(): (value) => value.cast<Ticket>()
        })
    );

    final stateTicketPayload = JsonMapper.deserialize<StateTicketPayload>(r.content());

    tickets.addTickets(stateTicketPayload.tickets);
    workers.addWorkers(stateWorkerPayload.workers);
  }
}