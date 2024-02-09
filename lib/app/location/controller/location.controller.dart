import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationController {
  Future<Position> getCurrentLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        await Geolocator.requestPermission();
        // throw Future.error('Location services are disabled. Please Enable it');
      }
      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.deniedForever) {
        print("denied forever");
      }

      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low,
      );
      return position;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<Placemark>> getAddressFromLatLng(Position positon) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(positon.latitude, positon.longitude);
      return placemarks;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
