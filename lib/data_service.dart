import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:finalweatherapp/models.dart';

class DataService {
  Future<WeatherResponse> getWeather(String city) async {
    final queryParameters = {
      'q': city,
      'appid': '74328316802f973ff098b438b553c6ff',
      'units': 'metric'
    };

    final uri = Uri.https(
        'api.openweathermap.org', '/data/2.5/weather', queryParameters);

    final response = await http.get(uri);

    print(response.body);
    final json = jsonDecode(response.body);
    return WeatherResponse.fromJson(json);
  }

  Future<WeatherResponse> getWeatherFromCoord(String lat, String lon) async {
    final queryParameters = {
      'lat': lat,
      'lon': lon,
      'appid': '74328316802f973ff098b438b553c6ff',
      'units': 'metric'
    };

    final uri = Uri.https(
        'api.openweathermap.org', '/data/2.5/weather', queryParameters);

    final response = await http.get(uri);

    print(response.body);
    final json = jsonDecode(response.body);
    return WeatherResponse.fromJson(json);
  }
}
