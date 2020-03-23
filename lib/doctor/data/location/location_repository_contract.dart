
abstract class LocationRepositoryContract {
  Future<int> setLocation(String name);
  Future<int> getLocation();

  void reset();
}