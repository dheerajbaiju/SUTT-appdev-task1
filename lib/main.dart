import 'package:finalweatherapp/data_service.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'models.dart';
import 'package:finalweatherapp/location.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _cityTextController = TextEditingController();
  final _dataService = DataService();
  String latitude;
  String longitude;
  var locationMessage = '';
  WeatherResponse _response;
  Position currentposition;

  @override
  void initState() {
    super.initState();
    _locationSearch();
  }

  Future<Position> _determinePosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);
    latitude = position.latitude.toString();
    longitude = position.longitude.toString();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_response != null)
              Column(
                children: [
                  Text(
                    '${_response.cityName}',
                    style: TextStyle(fontSize: 40),
                  ),
                  Image.network(_response.iconUrl, width: 100, height: 100),
                  Text(
                    '${_response.tempInfo.temperature}°',
                    style: TextStyle(fontSize: 40),
                  ),
                  Text(_response.weatherInfo.description,
                      style: TextStyle(fontSize: 20)),
                  SizedBox(width: 50, height: 50),
                  Text(
                    'Feels:${_response.tempInfo.feelsLike}°',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    'High:${_response.tempInfo.high}°',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    'Low:${_response.tempInfo.low}°',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 50),
              child: SizedBox(
                width: 150,
                child: TextField(
                    controller: _cityTextController,
                    decoration: InputDecoration(labelText: 'City'),
                    textAlign: TextAlign.center),
              ),
            ),
            ElevatedButton(onPressed: _search, child: Text('Search')),
          ],
        ),
      ),
    ));
  }

  void _search() async {
    final response = await _dataService.getWeather(_cityTextController.text);
    setState(() => _response = response);
  }

  void _locationSearch() async {
    await _determinePosition();
    final response =
        await _dataService.getWeatherFromCoord(latitude, longitude);
    setState(() => _response = response);
  }
}
