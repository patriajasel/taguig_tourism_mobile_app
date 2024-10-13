import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:intl/intl.dart';
import 'package:taguig_tourism_mobile_app/models/weather_model.dart';
import 'package:taguig_tourism_mobile_app/services/weather_services.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService = WeatherService();
  MainWeather? _mainWeather;
  late Future<HoursAndDaysWeatherResponse> _hoursAndDayForecast;

  // fetch weather
  _fetchWeather() async {
    // get weather for current city
    String cityName = await _weatherService.getCurrentCity();

    // get weather for city
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _mainWeather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();

    _fetchWeather();
    _hoursAndDayForecast = fetchHoursAndDaysWeatherForecast();
  }

  // Method to filter today's weather data
  List<HoursAndDaysWeatherForecast> getTodayWeather(List<HoursAndDaysWeatherForecast> weatherList) {
    String today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    return weatherList.where((weather) => weather.date.startsWith(today)).toList();
  }

  // Method to find the nearest forecast time to the current time
HoursAndDaysWeatherForecast getNearestForecast(List<HoursAndDaysWeatherForecast> weatherList) {
  DateTime now = DateTime.now();
  
  // Find the forecast closest to the current time
  HoursAndDaysWeatherForecast? nearestForecast = weatherList.reduce((a, b) {
    DateTime aDate = DateTime.parse(a.date);
    DateTime bDate = DateTime.parse(b.date);
    
    return (aDate.isBefore(now) && now.difference(aDate).abs() < now.difference(bDate).abs()) ? a : b;
  });

  return nearestForecast;
}

// Method to filter next 4 days' weather data based on the nearest time slot
List<HoursAndDaysWeatherForecast> getNextDaysWeather(List<HoursAndDaysWeatherForecast> weatherList, String targetTime) {
  List<HoursAndDaysWeatherForecast> nextDaysWeather = [];
  DateTime now = DateTime.now();
  String todayDate = DateFormat('yyyy-MM-dd').format(now);
  Set<String> uniqueDays = {};

  for (HoursAndDaysWeatherForecast weather in weatherList) {
    DateTime weatherDate = DateTime.parse(weather.date);

    // Get the day part (yyyy-MM-dd) and time part (HH:mm:ss)
    String dayString = DateFormat('yyyy-MM-dd').format(weatherDate);
    String timeString = DateFormat('HH:mm:ss').format(weatherDate);

    // Skip today's forecasts and include only future days matching the nearest time
    if (weatherDate.isAfter(now) && dayString != todayDate && timeString == targetTime && uniqueDays.length < 4) {
      if (!uniqueDays.contains(dayString)) {
        nextDaysWeather.add(weather);
        uniqueDays.add(dayString);
      }
    }

    // Stop once we've collected the next 4 days
    if (nextDaysWeather.length == 4) break;
  }

  return nextDaysWeather;
}
  // Method to format time in 12-hour format
  String formatTime(String dateTime) {
    DateTime time = DateTime.parse(dateTime);
    return DateFormat('hh:mm a').format(time);  // Format to 12-hour period with AM/PM
  }

  // Main weather icon animation function
  String getMainWeatherAnimation(String? mainCondition) {
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

  // Forecast weather icons only
  String getForecastWeatherIcon(String? mainCondition) {
    if (mainCondition == null) return 'lib/assets/anim/loading.json';

    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'lib/assets/weather/04d.png';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'lib/assets/weather/10d.png';
      case 'thunderstorm':
        return 'lib/assets/weather/11d.png';
      case 'clear':
        return 'lib/assets/weather/01d.png';
      default:
        return 'lib/assets/weather/01n.png';
    }
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    body: FutureBuilder<HoursAndDaysWeatherResponse>(
      future: _hoursAndDayForecast,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error loading data'));
        } else if (snapshot.hasData) {
          // Today's forecast list
          List<HoursAndDaysWeatherForecast> todayWeather = getTodayWeather(snapshot.data!.weatherList);

          // Find nearest forecast to the current time
          HoursAndDaysWeatherForecast nearestForecast = getNearestForecast(todayWeather);

          // Use nearest forecast's time for next days
          String targetTime = DateFormat('HH:mm:ss').format(DateTime.parse(nearestForecast.date));

          // Next days' forecast based on nearest forecast time
          List<HoursAndDaysWeatherForecast> nextDaysWeather = getNextDaysWeather(snapshot.data!.weatherList, targetTime);

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                // City and date display
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _mainWeather?.cityName ?? 'Loading City...',
                            style: TextStyle(
                              fontSize: 26,
                              color: Colors.black87,
                            ),
                          ),
                          Text(
                            DateFormat('MMMM dd, yyyy').format(DateTime.now()),
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Current Weather Animation
                    SizedBox(
                      width: 75,
                      height: 75,
                      child: Lottie.asset(getMainWeatherAnimation(_mainWeather?.mainCondition)),
                    ),
          
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '${_mainWeather?.temperature.round() ?? "--"} °',
                          style: TextStyle(
                            fontSize: 42,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                                
                        // Current Weather Condition/State
                        Column(
                          children: [
                            Text(
                              _mainWeather?.mainCondition ?? '',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),

                            SizedBox(
                              height: 12,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                
                SizedBox(
                  height: 10,
                ),
                
                // Current more details weather forecast
                Column (
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // For wind speed
                        Container(
                          width: 60,
                          height: 60,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 228, 232, 238),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Image.asset('lib/assets/icons/windspeed.png'),
                        ),

                        // For clouds
                        Container(
                          width: 60,
                          height: 60,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 228, 232, 238),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Image.asset('lib/assets/icons/clouds.png'),
                        ),

                        // For humidity
                        Container(
                          width: 60,
                          height: 60,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 228, 232, 238),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Image.asset('lib/assets/icons/humidity.png'),
                        )
                      ],
                    ),

                    SizedBox(
                      height: 5,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 20,
                          width: 60,
                          child: Text('${_mainWeather?.windSpeed ?? '--'}km/h',
                          style: const TextStyle(fontSize: 12),
                          textAlign: TextAlign.center
                          ),
                        ),

                        SizedBox(
                          height: 20,
                          width: 60,
                          child: Text('${_mainWeather?.clouds ?? '--'}%',
                          style: const TextStyle(fontSize: 12),
                          textAlign: TextAlign.center
                          ),
                        ),

                        SizedBox(
                          height: 20,
                          width: 60,
                          child: Text('${_mainWeather?.humidity?? '--'}%',
                          style: const TextStyle(fontSize: 12),
                          textAlign: TextAlign.center
                          ),
                        )
                      ],
                    )
                  ],
                ),

                // Display today's weather in a scrollable row
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 10),
                  child: Text('Today',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold)
                  ),
                ),

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: todayWeather.map((weather) {
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        color: const Color.fromARGB(255, 228, 232, 238),
                        child: Container(
                          width: 100,
                          height: 150, // Set a width for the card
                          padding: EdgeInsets.all(12),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                formatTime(weather.date),
                                style: TextStyle(fontSize: 12),
                              ),
                              SizedBox(height: 10),
                              Image.asset(
                                getForecastWeatherIcon(weather.mainCondition),
                                width: 50,
                                height: 50,
                              ), // Display Lottie animation
                              SizedBox(height: 10),
                              Text(
                                '${weather.temperature.round()} °C',
                                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),

                SizedBox(height: 10),

                // Display next days' forecast based on nearest forecast time
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 228, 232, 238),
                    borderRadius: BorderRadius.circular(10), // Rounded rectangle
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start, // Align title to start
                    children: [
                      // Next Days Title
                      Text(
                        'Next Days',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: 10),

                      // List of weather forecast for the next days
                      Column(
                        children: nextDaysWeather.map((weather) {
                          return Container(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${DateFormat('EEE').format(DateTime.parse(weather.date))} • ${formatTime(weather.date)}',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    Image.asset(
                                      getForecastWeatherIcon(weather.mainCondition),
                                      width: 40,
                                      height: 40,
                                    ),
                                    Text(
                                      '${weather.temperature.round()} °C',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                                Divider(
                                  thickness: 0.4,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else {
          return Center(child: Text('No data available'));
        }
      },
    ),
  );
}
}