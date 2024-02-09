import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/app/location/controller/location.controller.dart';
import 'package:weather_app/app/weather/controller/weather.controllr.dart';
import 'package:weather_app/app/weather/model/weather.model.dart';

class HomeProvider extends ChangeNotifier {
  HomeProvider() {
    getcurrentLocation();
    getWeatherUsingPosition();
  }
  final WeatherController controller = WeatherController();
  final LocationController location = LocationController();

  bool _loading = false;
  bool get loading => _loading;

  bool _error = false;
  bool get error => _error;

  bool _locationError = false;
  bool get locationError => _locationError;

  Position? _position;
  String city = 'Mumbai';
  // Dummy Location - Mumbai
  double dummyLat = 19.076090;
  double dummyLon = 72.877426;

  WeatherResponse? _currentWeather;
  WeatherResponse? get currentWeather => _currentWeather;

  Future getcurrentLocation() async {
    try {
      _handleLoading();

      final res = await location.getCurrentLocation();
      _position = res;
      final address = await location.getAddressFromLatLng(res);
      city = address.first.locality.toString().trim();
      print(_position!.latitude);

      notifyListeners();
    } catch (e) {
      _locationError = true;
      notifyListeners();
    }
  }

  Future getWeatherUsingPosition() async {
    try {
      _handleLoading();

      final res = await controller.getCurrentWeather(
        _position != null ? _position!.latitude : dummyLat,
        _position != null ? _position!.longitude : dummyLon,
      );
      _currentWeather = res;

      _handleLoading();
      notifyListeners();
    } catch (e) {
      _error = true;
      notifyListeners();
    }
  }

  Future getWeatherUsingCity(String place) async {
    try {
      _handleLoading();

      final res = await controller.getWeatherByCity(place);
      city = place;
      _currentWeather = res;

      _handleLoading();
      notifyListeners();
    } catch (e) {
      _error = true;
      notifyListeners();
    }
  }

  _handleLoading() {
    _loading = !_loading;
    // notifyListeners();
  }
}
