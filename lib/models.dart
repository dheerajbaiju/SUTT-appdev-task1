class WeatherInfo {
  final String description;
  final String icon;

  WeatherInfo({this.description, this.icon});

  factory WeatherInfo.fromJson(Map<String, dynamic> json) {
    final description = json['description'];
    final icon = json['icon'];
    return WeatherInfo(description: description, icon: icon);
  }
}

class TemperatureInfo {
  final double temperature;
  final double feelsLike;
  final double low;
  final double high;

  TemperatureInfo({this.temperature, this.feelsLike, this.low, this.high});

  factory TemperatureInfo.fromJson(Map<String, dynamic> json) {
    final temperature = json['temp'].toDouble();
    final feelsLike = json['feels_like'];
    final low = json['temp_min'];
    final high = json['temp_max'];
    return TemperatureInfo(
        temperature: temperature, feelsLike: feelsLike, low: low, high: high);
  }
}

class WeatherResponse {
  final String cityName;
  final TemperatureInfo tempInfo;
  final WeatherInfo weatherInfo;

  String get iconUrl {
    return 'http://openweathermap.org/img/wn/${weatherInfo.icon}@2x.png';
  }

  WeatherResponse({this.cityName, this.tempInfo, this.weatherInfo});

  factory WeatherResponse.fromJson(Map<String, dynamic> json) {
    final cityName = json['name'];

    final tempInfoJson = json['main'];
    final tempInfo = TemperatureInfo.fromJson(tempInfoJson);

    final weatherInfoJson = json['weather'][0];
    final weatherInfo = WeatherInfo.fromJson(weatherInfoJson);

    return WeatherResponse(
        cityName: cityName, tempInfo: tempInfo, weatherInfo: weatherInfo);
  }
}
