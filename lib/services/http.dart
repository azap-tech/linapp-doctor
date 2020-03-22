import 'package:azap_app/classes/stateDoctorPayload.dart';
import 'package:azap_app/stores/doctor.dart';
import 'package:azap_app/stores/ticket.dart';
import 'package:azap_app/main.dart';
import 'package:azap_app/classes/stateTicketPayload.dart';
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
  Future login(int id, String secret) async {
    // TODO clear on disconnect
    String hostname = Requests.getHostname("${DotEnv().env['BASE_URL']}/api/v2/login");
    Requests.clearStoredCookies(hostname);
    var r = await Requests.post(
        "${DotEnv().env['BASE_URL']}/api/v2/login",
        json: {
          "id": id,
          "secret": secret
        },
        timeoutSeconds: 30,
        bodyEncoding: RequestBodyEncoding.JSON);
    print("http status from login ${r.statusCode}");
    // throw exception if not 200
    r.raiseForStatus();
    dynamic json = r.json();
    print(json);
  }

  // auto store cookie in storage
  createTicket(Ticket ticket) async {
    String hostname = Requests.getHostname("${DotEnv().env['BASE_URL']}/api/v2/ticket");
    Requests.getStoredCookies(hostname).then((cookie) {
      print('Session : ' + cookie.toString());
    });
    var r = await Requests.post(
        "${DotEnv().env['BASE_URL']}/api/v2/ticket",
        json: {
          "locationId": ticket.locationId,
          "name": ticket.name,
          "phone": ticket.phone,
          "sex": ticket.sex,
          "pathology": ticket.pathology,
          "age": ticket.age,
        },
        bodyEncoding: RequestBodyEncoding.JSON);
    print("http status from ticket ${r.statusCode}");
    // throw exception if not 200
    r.raiseForStatus();
    dynamic json = r.json();
    print(json);
  }

  /*updateTicket(Ticket ticket) async {
    var r = await Requests.patch(
        "${DotEnv().env['BASE_URL']}/api/v2/ticket",
        json: {
          "name": ticket.name,
          "phone": ticket.phone,
          "sex": ticket.sex,
          "pathology": ticket.pathology,
        },
        bodyEncoding: RequestBodyEncoding.JSON);
    print("http status from ticket ${r.statusCode}");
    // throw exception if not 200
    r.raiseForStatus();
    dynamic json = r.json();
    print(json);
  }*/

  createDoctor(Doctor doctor) async {
    var r = await Requests.post(
        "${DotEnv().env['BASE_URL']}/api/v2/doctor",
        json: {
          "locationId": doctor.locationId,
          "name": doctor.name,
          "phone": doctor.phone
        },
        bodyEncoding: RequestBodyEncoding.JSON,
        timeoutSeconds: 30);
    print("http status from doctor ${r.statusCode}");
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

  // call if login return app status with doctors and tickets
  getStatus() async {
    String hostname = Requests.getHostname("${DotEnv().env['BASE_URL']}/api/v2/me");
    Requests.getStoredCookies(hostname).then((cookie) {
      print('Session : ' + cookie.toString());
    });
    var r = await Requests.get("${DotEnv().env['BASE_URL']}/api/v2/me");
    print("http status from get me : ${r.statusCode}");
    // throw exception if not 200
    r.raiseForStatus();

    // TODO hack to deserialize list
    JsonMapper().useAdapter(JsonMapperAdapter(
        valueDecorators: {
          typeOf<List<Doctor>>(): (value) => value.cast<Doctor>()
        })
    );

    final stateDoctorPayload = JsonMapper.deserialize<StateDoctorPayload>(r.content());

    JsonMapper().useAdapter(JsonMapperAdapter(
        valueDecorators: {
          typeOf<List<Ticket>>(): (value) => value.cast<Ticket>()
        })
    );

    final stateTicketPayload = JsonMapper.deserialize<StateTicketPayload>(r.content());

    stateTicketPayload.tickets.forEach((ticket) {
      if(ticket.doctorId != null){
        tickets.addTicket(ticket);
      } else {
        int doctorIndex = stateDoctorPayload.doctors.indexWhere((doctor) {
          doctor.id == ticket.doctorId;
        });
        stateDoctorPayload.doctors.elementAt(doctorIndex).listPatients.add(ticket);
      }
    });

    tickets.addTickets(stateTicketPayload.tickets);
    doctors.addDoctors(stateDoctorPayload.doctors);
  }

  getLocations() async {
    var r = await Requests.get("${DotEnv().env['BASE_URL']}/api/v2/location");
    print("http status from get locations : ${r.statusCode}");
    // throw exception if not 200
    r.raiseForStatus();
    dynamic json = r.json();
    print(json);
  }
}