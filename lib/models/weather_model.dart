class Weather {
  final String cityName;
  final double temperature;
  final String mainCondition;

  Weather({required this.cityName, required this.temperature, required this.mainCondition});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['city']['name'],
      temperature: json['list'][0]['main']['temp'].toDouble(),
      mainCondition: json['list'][0]['weather'][0]['main'],
      );
  }
}