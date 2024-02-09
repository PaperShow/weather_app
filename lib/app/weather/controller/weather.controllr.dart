import 'package:dio/dio.dart';
import 'package:weather_app/app/weather/model/weather.model.dart';

class WeatherController {
  final baseUrl = "https://api.openweathermap.org/data/2.5/weather";
  final apiKey = "2f814e8f940901b5f6ddae0a45f5673e";

  final dio = Dio();

  Future<WeatherResponse> getCurrentWeather(double lat, double lon) async {
    try {
      final queryParams = {'lat': lat, 'lon': lon, 'appid': apiKey};
      final res = await dio.get(baseUrl, queryParameters: queryParams);

      if (res.statusCode == 200) {
        return WeatherResponse.fromJson(res.data);
      } else {
        throw Exception('Not Found');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<WeatherResponse> getWeatherByCity(String city) async {
    try {
      final queryParams = {'q': city, 'appid': apiKey};
      final res = await dio.get(baseUrl, queryParameters: queryParams);

      if (res.statusCode == 200) {
        return WeatherResponse.fromJson(res.data);
      } else {
        throw Exception(res.statusMessage);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
