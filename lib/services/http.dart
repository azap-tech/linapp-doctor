import 'package:azap_app/classes/stateTicketPayload.dart';
import 'package:azap_app/classes/stateWorkerPayload.dart';
import 'package:azap_app/stores/doctor.dart';
import 'package:azap_app/stores/ticket.dart';
import 'package:azap_app/stores/worker.dart';
import 'package:azap_app/main.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
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
  createTicket(Ticket ticket) async {
    var r = await Requests.post(
        "${DotEnv().env['BASE_URL']}/api/v2/ticket",
        json: {
          "storeId": 1,
          "workerId": 1,
          "prestations": [],
          "name": ticket.name,
          "phone": ticket.phone,
          "azap": true,
        },
        bodyEncoding: RequestBodyEncoding.JSON);
    print("http status from ticket ${r.statusCode}");
    // throw exception if not 200
    r.raiseForStatus();
    dynamic json = r.json();
    print(json);
  }

  createDoctor(Doctor doctor) async {
    var r = await Requests.post(
        "${DotEnv().env['BASE_URL']}/api/v2/doctor",
        json: {
          "locationId": doctor.locationId,
          "name": doctor.name,
          "phone": doctor.phone
        },
        bodyEncoding: RequestBodyEncoding.JSON);
    print("http status from doctor ${r.statusCode}");
    // throw exception if not 200
    r.raiseForStatus();
    dynamic json = r.json();
    print(json);
  }

  createWorker(String name) async {
    var r = await Requests.post(
        "${DotEnv().env['BASE_URL']}/api/v2/worker",
        json: {
          "storeId": 1,
          "name": name,
          "avatar": "/worker.png",
          "phone": "",
          "isManager": false,
        },
        bodyEncoding: RequestBodyEncoding.JSON);
    print("http status from worker ${r.statusCode}");
    // throw exception if not 200
    r.raiseForStatus();
    dynamic json = r.json();
    print(json);
  }

  createLocation(String name) async {
    var r = await Requests.post(
        "${DotEnv().env['BASE_URL']}/api/v2/location",
        json: {
          "name": name
        },
        bodyEncoding: RequestBodyEncoding.JSON);
    print("http status from create location : ${r.statusCode}");
    // throw exception if not 200
    r.raiseForStatus();
    dynamic json = r.json();
    print(json);
  }

  getLocations() async {
    var r = await Requests.get("${DotEnv().env['BASE_URL']}/api/v2/location");
    print("http status from get locations : ${r.statusCode}");
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