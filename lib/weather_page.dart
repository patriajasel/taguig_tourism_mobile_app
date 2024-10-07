import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:taguig_tourism_mobile_app/models/weather_model.dart';
import 'package:taguig_tourism_mobile_app/services/weather_services.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService = WeatherService('a786e9363cae616d391836e9a3a4f905');
  Weather? _weather;

  // fetch weather
  _fetchWeather() async {
    // get weather for current city
    String cityName = await _weatherService.getCurrentCity();

    // get weather for city
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();

    _fetchWeather();
  }

  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'lib/assets/anim/loading.json';

    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'lib/assets/anim/weather_cloudy.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'lib/assets/anim/weather_rain.json';
      case 'thunderstorm':
        return 'lib/assets/anim/weather_rain_thunder.json';
      case 'clear':
        return 'lib/assets/anim/weather_sunny.json';
      default:
        return 'lib/assets/anim/weather_sunny.json';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            // City
            SizedBox(
              height: 10,
            ),
            Text(
              _weather?.cityName ?? 'Loading City...',
              style: TextStyle(
                fontSize: 26,
                color: Colors.black87,
              ),
            ),
        
            
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Weather Animation
                SizedBox(
                  width: 100,
                  height: 100,
                  child: Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),
                  ),

                SizedBox(
                  width: 100,
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        // Temperature
                        Text(
                          '${_weather?.temperature.round() ?? "--"}°C',
                          style: TextStyle(
                            fontSize: 36,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        
                        SizedBox(
                          width: 10,
                        ),
                                
                        // Weather Condition/State
                        Column(
                          children: [
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              _weather?.mainCondition ?? '',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
