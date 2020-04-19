import 'package:dart_json_mapper/dart_json_mapper.dart';

@jsonSerializable
@Json(enumValues: LocationTypes.values)
enum LocationTypes {
  AMBULATOIRE,
  DEPISTAGE,
  MEDICAL,
  HOSPITALIER,
  URGENCES
}

class LocationType {
  static String getLibelle (LocationTypes type) {
    switch(type) {
      case LocationTypes.AMBULATOIRE: {
        return 'Centre ambulatoire';
      }
      break;
      case LocationTypes.DEPISTAGE: {
        return 'Centre de dépistage';
      }
      break;
      case LocationTypes.MEDICAL: {
        return 'Cabinet médical';
      }
      break;
      case LocationTypes.HOSPITALIER: {
        return 'Centre hospitalier';
      }
      break;
      case LocationTypes.URGENCES: {
        return 'Urgences';
      }
      break;
      default: {
        return 'Centre de dépistage';
      }
      break;
    }
  }

  static String toText (LocationTypes type) {
    return type.toString().split('.').last;
  }

  static LocationTypes fromString (String type) {
    switch(type) {
      case "AMBULATOIRE": {
        return LocationTypes.AMBULATOIRE;
      }
      break;
      case "DEPISTAGE": {
        return LocationTypes.DEPISTAGE;
      }
      break;
      case "MEDICAL": {
        return LocationTypes.MEDICAL;
      }
      break;
      case "HOSPITALIER": {
        return LocationTypes.HOSPITALIER;
      }
      break;
      case "URGENCES": {
        return LocationTypes.URGENCES;
      }
      break;
      default: {
        return LocationTypes.DEPISTAGE;
      }
      break;
    }
  }
}