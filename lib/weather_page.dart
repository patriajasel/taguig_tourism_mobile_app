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
  List<HoursAndDaysWeatherForecast> getTodayWeather(
      List<HoursAndDaysWeatherForecast> weatherList) {
    String today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    return weatherList
        .where((weather) => weather.date.startsWith(today))
        .toList();
  }

  // Method to filter next 4 days' weather data
  List<HoursAndDaysWeatherForecast> getNextDaysWeather(
      List<HoursAndDaysWeatherForecast> weatherList) {
    List<HoursAndDaysWeatherForecast> nextDaysWeather = [];

    // Ensure we have at least 40 items in the list (5 days * 8 items per day)
    if (weatherList.length >= 40) {
      // We want the 11th, 19th, 27th, and 35th items, which are index positions: 10, 18, 26, 34
      nextDaysWeather.add(weatherList[10]); // 11th forecast
      nextDaysWeather.add(weatherList[18]); // 19th forecast
      nextDaysWeather.add(weatherList[26]); // 27th forecast
      nextDaysWeather.add(weatherList[34]); // 35th forecast
    }

    return nextDaysWeather;
  }

  // Method to format time in 12-hour format
  String formatTime(String dateTime) {
    DateTime time = DateTime.parse(dateTime);
    return DateFormat('hh:mm a')
        .format(time); // Format to 12-hour period with AM/PM
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
    double screenHeight = MediaQuery.of(context).size.height;

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
            List<HoursAndDaysWeatherForecast> todayWeather =
                getTodayWeather(snapshot.data!.weatherList);

            // Next days' forecast based on nearest forecast time
            List<HoursAndDaysWeatherForecast> nextDaysWeather =
                getNextDaysWeather(snapshot.data!.weatherList);

            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                  horizontal: screenHeight * 0.02632,
                  vertical: screenHeight * 0.02039),
              child: Column(
                children: [
                  // City and date display
                  Padding(
                    padding: EdgeInsets.only(bottom: screenHeight * 0.02039),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _mainWeather?.cityName ?? 'Loading City...',
                              style: TextStyle(
                                fontSize: screenHeight * 0.03533,
                                color: Colors.black87,
                              ),
                            ),
                            Text(
                              DateFormat('MMMM dd, yyyy')
                                  .format(DateTime.now()),
                              style: TextStyle(
                                fontSize: screenHeight * 0.01903,
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
                        width: screenHeight * 0.10193,
                        height: screenHeight * 0.10193,
                        child: Lottie.asset(getMainWeatherAnimation(
                            _mainWeather?.mainCondition)),
                      ),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '${_mainWeather?.temperature.round() ?? "--"}°',
                            style: TextStyle(
                              fontSize: screenHeight * 0.0571,
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
                                  fontSize: screenHeight * 0.01903,
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(
                                height: screenHeight * 0.01053,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),

                  SizedBox(
                    height: screenHeight * 0.01359,
                  ),

                  // Current more details weather forecast
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenHeight * 0.01974),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // For wind speed
                            Container(
                              width: screenHeight * 0.07237,
                              height: screenHeight * 0.07237,
                              padding: EdgeInsets.all(screenHeight * 0.02174),
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 228, 232, 238),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child:
                                  Image.asset('lib/assets/icons/windspeed.png'),
                            ),

                            // For clouds
                            Container(
                              width: screenHeight * 0.07237,
                              height: screenHeight * 0.07237,
                              padding: EdgeInsets.all(screenHeight * 0.02174),
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 228, 232, 238),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Image.asset('lib/assets/icons/clouds.png'),
                            ),

                            // For humidity
                            Container(
                              width: screenHeight * 0.07237,
                              height: screenHeight * 0.07237,
                              padding: EdgeInsets.all(screenHeight * 0.02174),
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 228, 232, 238),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child:
                                  Image.asset('lib/assets/icons/humidity.png'),
                            )
                          ],
                        ),
                        SizedBox(
                          height: screenHeight * 0.0068,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenHeight * 0.00395),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                height: screenHeight * 0.02718,
                                width: screenHeight * 0.0658,
                                child: Text(
                                    '${_mainWeather?.windSpeed ?? '--'}km/h',
                                    style: TextStyle(
                                        fontSize: screenHeight * 0.01579),
                                    textAlign: TextAlign.center),
                              ),
                              SizedBox(
                                height: screenHeight * 0.02718,
                                width: screenHeight * 0.0658,
                                child: Text('${_mainWeather?.clouds ?? '--'}%',
                                    style: TextStyle(
                                        fontSize: screenHeight * 0.01579),
                                    textAlign: TextAlign.center),
                              ),
                              SizedBox(
                                height: screenHeight * 0.02718,
                                width: screenHeight * 0.0658,
                                child: Text(
                                    '${_mainWeather?.humidity ?? '--'}%',
                                    style: TextStyle(
                                        fontSize: screenHeight * 0.01579),
                                    textAlign: TextAlign.center),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),

                  // Display today's weather in a scrollable row
                  Padding(
                    padding: EdgeInsets.only(
                        top: screenHeight * 0.02039,
                        bottom: screenHeight * 0.01359),
                    child: Text('Today',
                        style: TextStyle(
                            fontSize: screenHeight * 0.02446,
                            fontWeight: FontWeight.bold)),
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
                            width: screenHeight * 0.13158,
                            height: screenHeight * 0.20381,
                            padding: EdgeInsets.all(screenHeight * 0.01631),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  formatTime(weather.date),
                                  style: TextStyle(
                                      fontSize: screenHeight * 0.01631),
                                ),
                                SizedBox(height: screenHeight * 0.01359),
                                Image.asset(
                                  getForecastWeatherIcon(weather.mainCondition),
                                  width: screenHeight * 0.06794,
                                  height: screenHeight * 0.06794,
                                ),
                                SizedBox(height: screenHeight * 0.01359),
                                Text(
                                  '${weather.temperature.round()} °C',
                                  style: TextStyle(
                                      fontSize: screenHeight * 0.01631,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.01359),

                  // Display next days' forecast based on nearest forecast time
                  Container(
                    padding: EdgeInsets.fromLTRB(
                        screenHeight * 0.02105,
                        screenHeight * 0.01631,
                        screenHeight * 0.02105,
                        screenHeight * 0.00816),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 228, 232, 238),
                      borderRadius:
                          BorderRadius.circular(10), // Rounded rectangle
                    ),
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start, // Align title to start
                      children: [
                        // Next Days Title
                        Text(
                          'Next Days',
                          style: TextStyle(
                            fontSize: screenHeight * 0.02174,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: screenHeight * 0.01359),

                        // List of weather forecast for the next days
                        Column(
                          children: nextDaysWeather.map((weather) {
                            return Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: screenHeight * 0.01087),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '${DateFormat('EEE').format(DateTime.parse(weather.date))} • ${formatTime(weather.date)}',
                                        style: TextStyle(
                                            fontSize: screenHeight * 0.01631),
                                      ),
                                      Image.asset(
                                        getForecastWeatherIcon(
                                            weather.mainCondition),
                                        width: screenHeight * 0.05435,
                                        height: screenHeight * 0.05435,
                                      ),
                                      Text(
                                        '${weather.temperature.round()} °C',
                                        style: TextStyle(
                                            fontSize: screenHeight * 0.01631),
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
