import 'package:azap_app/classes/doctorPayload.dart';
import 'package:azap_app/classes/genericPayload.dart';
import 'package:azap_app/classes/locationPayload.dart';
import 'package:azap_app/classes/stateDoctorPayload.dart';
import 'package:azap_app/classes/ticketPayload.dart';
import 'package:azap_app/stores/doctor.dart';
import 'package:azap_app/stores/location.dart';
import 'package:azap_app/stores/ticket.dart';
import 'package:azap_app/main.dart';
import 'package:azap_app/classes/stateTicketPayload.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logger/logger.dart';
import 'package:requests/requests.dart';

import '../main.dart';

class HttpService {
  static final HttpService _instance = HttpService._internal();
  var logger = Logger();

  factory HttpService() {
    return _instance;
  }

  HttpService._internal() {
  }

  // auto store cookie in storage
  Future<GenericPayload> login(int id, String secret) async {
    var genericPayload = GenericPayload();
    if(DotEnv().env['MODE_MOCK'] == 'false'){
      try {
        // TODO clear on disconnect
        String hostname = Requests.getHostname("${DotEnv().env['BASE_URL']}/api/v2/login");
        await Requests.clearStoredCookies(hostname);
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
        genericPayload = JsonMapper.deserialize<GenericPayload>(r.content());
        Requests.getStoredCookies(hostname).then((cookie) {
          print('Session : ' + cookie.toString());
        });
        return genericPayload;
      } on Exception catch (e) {
        logger.e(e);
        genericPayload.status = 'error';
        return genericPayload;
      }
    } else {
      genericPayload.status = 'ok';
      return genericPayload;
    }
  }

  // auto store cookie in storage
  createTicket(Ticket ticket) async {
    var ticketPayload = TicketPayload();
    if(DotEnv().env['MODE_MOCK'] == 'false'){
      try {
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
            timeoutSeconds: 30,
            bodyEncoding: RequestBodyEncoding.JSON);
        print("http status from ticket ${r.statusCode}");
        // throw exception if not 200
        r.raiseForStatus();
        ticketPayload = JsonMapper.deserialize<TicketPayload>(r.content());
        // TODO handle in api tickets attribution to doctor if solo doctor on location ?
        ticketPayload.payload.doctorId = doctor.id;
        doctor.updatePatient(ticketPayload.payload);
        doctor.reorderPatients();
        return ticketPayload;
      } on Exception catch (e) {
        logger.e(e);
        ticketPayload.status = 'error';
        return ticketPayload;
      }
    } else {
      ticket.id = 1;
      ticket.doctorId = doctor.id;
      doctor.addPatient(ticketPayload.payload);
      ticketPayload.status = 'ok';
      return ticketPayload;
    }
  }

  nextTicket() async {
    var ticketPayload = TicketPayload();
    if(DotEnv().env['MODE_MOCK'] == 'false'){
      try {
        var r = await Requests.patch(
            "${DotEnv().env['BASE_URL']}/api/v2/doctors/${doctor.id}/next", timeoutSeconds: 30);
        print("http status from next ticket ${r.statusCode}");
        // throw exception if not 200
        r.raiseForStatus();
        ticketPayload = JsonMapper.deserialize<TicketPayload>(r.content());
        // TODO handle in api tickets attribution to doctor if solo doctor on location ?
        ticketPayload.payload.doctorId = doctor.id;
        doctor.nextPatient(ticketPayload.payload, ticketPayload.oldTicketId);
        doctor.reorderPatients();
        return ticketPayload;
      } on Exception catch (e) {
        logger.e(e);
        ticketPayload.status = 'error';
        return ticketPayload;
      }
    } else {
      if(doctor.listPatients.isNotEmpty){
        doctor.listPatients.removeAt(0);
      }
      ticketPayload.status = 'ok';
      return ticketPayload;
    }
  }

  Future<DoctorPayload> createDoctor(Doctor newDoctor) async {
    var doctorPayload = DoctorPayload();
    if(DotEnv().env['MODE_MOCK'] == 'false'){
      try {
        var r = await Requests.post(
            "${DotEnv().env['BASE_URL']}/api/v2/doctor",
            json: {
              "locationId": newDoctor.locationId,
              "name": newDoctor.name,
              "phone": newDoctor.phone,
              "email": newDoctor.email,
            },
            bodyEncoding: RequestBodyEncoding.JSON,
            timeoutSeconds: 30);
        print("http status from doctor ${r.statusCode}");
        // throw exception if not 200
        r.raiseForStatus();
        doctorPayload = JsonMapper.deserialize<DoctorPayload>(r.content());
        doctor.setDoctor(doctorPayload.payload);
        return doctorPayload;
      } on Exception catch (e) {
        logger.e(e);
        doctorPayload.status = 'error';
        return doctorPayload;
      }
    } else {
      newDoctor.id = 1;
      doctor.setDoctor(newDoctor);
      doctorPayload.status = 'ok';
      return doctorPayload;
    }
  }

  Future<LocationPayload> createLocation(Location location) async {
    var locationPayload = LocationPayload();
    if(DotEnv().env['MODE_MOCK'] == 'false'){
      try {
        var r = await Requests.post(
            "${DotEnv().env['BASE_URL']}/api/v2/location",
            json: {
              "name": location.name,
              "address": location.address,
              "zipCode": location.zipCode,
              "city": location.city
            },
            bodyEncoding: RequestBodyEncoding.JSON);
        print("http status from create location : ${r.statusCode}");
        // throw exception if not 200
        r.raiseForStatus();
        locationPayload = JsonMapper.deserialize<LocationPayload>(r.content());
        return locationPayload;
      } on Exception catch (e) {
        logger.e(e);
        locationPayload.status = 'error';
        return locationPayload;
      }
    } else {
      locationPayload.status = 'ok';
      return locationPayload;
    }
  }

  Future<DoctorPayload> linkDoctorToLocation(int doctorId, int locationId) async {
    var linkDoctorLocationPayload = DoctorPayload();
    if(DotEnv().env['MODE_MOCK'] == 'false'){
      try {
        var r = await Requests.patch(
            "${DotEnv().env['BASE_URL']}/api/v2/doctors/$doctorId/location",
            json: {
              "locationId": locationId
            },
            bodyEncoding: RequestBodyEncoding.JSON);
        print("http status from link doctor to location : ${r.statusCode}");
        // throw exception if not 200
        r.raiseForStatus();
        linkDoctorLocationPayload = JsonMapper.deserialize<DoctorPayload>(r.content());
        doctor.setDoctor(linkDoctorLocationPayload.payload);
        return linkDoctorLocationPayload;
      } on Exception catch (e) {
        logger.e(e);
        linkDoctorLocationPayload.status = 'error';
        return linkDoctorLocationPayload;
      }
    } else {
      doctor.locationId = locationId;
      linkDoctorLocationPayload.status = 'ok';
      return linkDoctorLocationPayload;
    }
  }

  // call if login return app status with doctors and tickets
  Future<StateDoctorPayload> getStatus() async {
    var stateDoctorPayload = StateDoctorPayload();
    if(DotEnv().env['MODE_MOCK'] == 'false'){
      try {
        String hostname = Requests.getHostname("${DotEnv().env['BASE_URL']}/api/v2/me");
        Requests.getStoredCookies(hostname).then((cookie) {
          print('Session : ' + cookie.toString());
        });
        var r = await Requests.get("${DotEnv().env['BASE_URL']}/api/v2/me", timeoutSeconds: 30);
        print("http status from get me : ${r.statusCode}");
        // throw exception if not 200
        r.raiseForStatus();

        // TODO hack to deserialize list
        JsonMapper().useAdapter(JsonMapperAdapter(
            valueDecorators: {
              typeOf<List<Doctor>>(): (value) => value.cast<Doctor>()
            })
        );

        stateDoctorPayload = JsonMapper.deserialize<StateDoctorPayload>(r.content());

        JsonMapper().useAdapter(JsonMapperAdapter(
            valueDecorators: {
              typeOf<List<Ticket>>(): (value) => value.cast<Ticket>()
            })
        );

        final stateTicketPayload = JsonMapper.deserialize<StateTicketPayload>(r.content());

        if(stateDoctorPayload.doctors.isNotEmpty){
          // TODO check endpoint how to handle solo doctors or loggedDoctor
          doctor.setDoctor(stateDoctorPayload.doctors.elementAt(0));

          stateTicketPayload.tickets.forEach((ticket) {
            if(ticket.doctorId == null){
              ticket.doctorId = doctor.id;
            }
            doctor.addPatient(ticket);
          });

          doctor.reorderPatients();

        } else {
          logger.e("No doctors for session, clear cookies");
          // TODO check api. session with no doctor. Clear cookie
          Requests.clearStoredCookies(hostname);
          stateDoctorPayload.status = 'error';
        }

        return stateDoctorPayload;
      } on Exception catch (e) {
        logger.e(e);
        stateDoctorPayload.status = 'error';
        return stateDoctorPayload;
      }
    } else {
      stateDoctorPayload.status = 'ok';
      return stateDoctorPayload;
    }
  }
}