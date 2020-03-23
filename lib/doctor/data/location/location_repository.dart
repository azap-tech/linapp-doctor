import 'package:azap_app/services/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'location_repository_contract.dart';

class LocationRepository extends LocationRepositoryContract {

  @override
  Future<int> getLocation() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var locationId = sharedPreferences.getInt("locationId");
    if (locationId == null) {
      return -1;
    } else {
      return locationId;
    }
  }

  @override
  Future<int> setLocation(String name) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var locationId = await HttpService()
        .createLocation(name);
    sharedPreferences.setInt("locationId", locationId);
    return locationId;
  }

  @override
  Future<void> reset() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("locationId", null);
  }
}
