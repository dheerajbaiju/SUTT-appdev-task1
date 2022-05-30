import 'package:finalweatherapp/data_service.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'models.dart';

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

  /*Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    latitude = position.latitude.toString();
    longitude = position.longitude.toString();
    currentposition = position;
    return position;
  }*/

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
            //ElevatedButton(onPressed: _locationSearch, child: Text('Current location')),
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

  /* void _locationSearch() async {
    _determinePosition();
    final response = await _dataService.getWeatherFromCoord(
        currentposition.latitude.toString(),
        currentposition.longitude.toString());
    setState(() => _response = response);

    TextField(
        controller: _cityTextController,
        decoration: InputDecoration(labelText: 'City'),
        textAlign: TextAlign.center);
  }*/
}
