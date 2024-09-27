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

Future <String> getCurrentCity() async {
    PermissionStatus permission = await Permission.location.status;
    
    if (permission.isDenied) {
      permission = await Permission.locationWhenInUse.request();
    } else if (permission.isPermanentlyDenied) {
      await openAppSettings();
    }

    Position position = await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.best);

  // convert location into city name 
    // List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    GeoCode geoCode = GeoCode();
     Address city = await geoCode.reverseGeocoding(latitude: position.latitude, longitude: position.longitude);

  // extracting city name from the list placemark
  return city.toString();

    // if (permission.isGranted) {
    //   getCurrentLocation();
    // } else {
    //   permission = await Permission.locationWhenInUse.request();
    //   if (permission.isGranted) {
    //     getCurrentLocation();
    //   } else if (permission.isDenied) {
    //     await openAppSettings();
    //   } else if (permission.isPermanentlyDenied) {
    //     await openAppSettings();
    //   }
    // }
  }
}

