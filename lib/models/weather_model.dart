class MainWeather {
  final String cityName;
  final double temperature;
  final String mainCondition;
  final double windSpeed;
  final int clouds;
  final int humidity;

  MainWeather({
    required this.cityName,
    required this.temperature,
    required this.mainCondition, 
    required this.windSpeed,
    required this.clouds,
    required this.humidity,
   });

  factory MainWeather.fromJson(Map<String, dynamic> json) {
    return MainWeather(
      cityName: json['name'],
      temperature: json['main']['temp'].toDouble(),
      mainCondition: json['weather'][0]['main'],
      windSpeed: json['wind']['speed'].toDouble(),
      clouds: json['clouds']['all'],
      humidity: json['main']['humidity'],
      );
  }
}

class HoursAndDaysWeatherForecast {
  final double temperature;
  final String mainCondition;
  final String date;

  HoursAndDaysWeatherForecast({
    required this.temperature,
    required this.mainCondition,
    required this.date,
    });

  factory HoursAndDaysWeatherForecast.fromJson(Map<String, dynamic> json) {
    return HoursAndDaysWeatherForecast(
      temperature: json['main']['temp'].toDouble(),
      mainCondition: json['weather'][0]['main'],
      date: json['dt_txt'],
      );
  }
}