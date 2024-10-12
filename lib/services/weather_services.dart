import 'dart:convert';
import '../models/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  static const WEATHER_URL = 'https://api.openweathermap.org/data/2.5/weather';
  String getApiKey() {
    // API key:
    return 'Input the Weather API key here'; 
  }

  Future<MainWeather> getWeather(String cityName) async {
    final apiKey = getApiKey();  // Get the API key from the method
    final response = await http.get(Uri.parse('$WEATHER_URL?q=$cityName&appid=$apiKey&units=metric'));
    if (response.statusCode == 200) {
      return MainWeather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  Future<String> getCurrentCity() async {
    return 'taguig';
  }
}

class HoursAndDaysWeatherResponse {
  final String cityName;
  final List<HoursAndDaysWeatherForecast> weatherList;

  HoursAndDaysWeatherResponse({required this.cityName, required this.weatherList});

  factory HoursAndDaysWeatherResponse.fromJson(Map<String, dynamic> json) {
    List<dynamic> weatherData = json['list'];
    List<HoursAndDaysWeatherForecast> weatherList = weatherData.map((data) => HoursAndDaysWeatherForecast.fromJson(data)).toList();

    return HoursAndDaysWeatherResponse(
      cityName: json['city']['name'],   // Extract city name
      weatherList: weatherList,         // Extract the list of weather data
    );
  }
}

Future<HoursAndDaysWeatherResponse> fetchHoursAndDaysWeatherForecast() async {
  final WeatherService weatherService = WeatherService();
  final apiKey = weatherService.getApiKey();
  final String city = 'taguig';
  final String url = 'https://api.openweathermap.org/data/2.5/forecast?q=$city&appid=$apiKey&units=metric';

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    return HoursAndDaysWeatherResponse.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load weather data');
  }
}
