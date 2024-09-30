import 'dart:convert';
import 'package:permission_handler/permission_handler.dart';
import 'package:geocode/geocode.dart';
import 'package:geolocator/geolocator.dart';
import '../models/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherService {

  static const BASE_URL = 'https://api.openweathermap.org/data/2.5/weather';
  final String apiKey;

  WeatherService(this.apiKey);

  Future<Weather> getWeather(String cityName) async {
    final response = await http.get(Uri.parse('$BASE_URL?q=$cityName&appid=$apiKey&units=metric'));
  
  if (response.statusCode == 200) {
    return Weather.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load weather data');
  }
}

Future<String> getCurrentCity() async {
  // Request location permission
  PermissionStatus permission = await Permission.location.status;

  if (permission.isDenied) {
    permission = await Permission.locationWhenInUse.request();
  } else if (permission.isPermanentlyDenied) {
    await openAppSettings();
  }

  // Get the current position
  Position position = await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high
  );

  // Use reverse geocoding to get the address
  GeoCode geoCode = GeoCode();
  Address address = await geoCode.reverseGeocoding(
    latitude: position.latitude, 
    longitude: position.longitude
  );

  // Return the city name or 'Unknown City' if unavailable
  return address.city ?? 'Unknown City';
}
}

