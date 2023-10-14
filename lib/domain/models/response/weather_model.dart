import 'dart:convert';

import 'package:equatable/equatable.dart';

class WeatherModel extends Equatable {
  final String date;
  final String weatherIconUrl;
  final String humidity;
  final String windspeedKmph;
  const WeatherModel({
    required this.date,
    required this.weatherIconUrl,
    required this.humidity,
    required this.windspeedKmph,
  });
  



  WeatherModel copyWith({
    String? date,
    String? weatherIconUrl,
    String? humidity,
    String? windspeedKmph,
  }) {
    return WeatherModel(
      date: date ?? this.date,
      weatherIconUrl: weatherIconUrl ?? this.weatherIconUrl,
      humidity: humidity ?? this.humidity,
      windspeedKmph: windspeedKmph ?? this.windspeedKmph,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'date': date,
      'weatherIconUrl': weatherIconUrl,
      'humidity': humidity,
      'windspeedKmph': windspeedKmph,
    };
  }

  factory WeatherModel.fromMap(Map<String, dynamic> map) {

    return WeatherModel(
      date: map['date'] as String,
      weatherIconUrl: map['weatherIconUrl'] as String,
      humidity: map['humidity'] as String,
      windspeedKmph: map['windspeedKmph'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory WeatherModel.fromJson(String source) => WeatherModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [date, weatherIconUrl, humidity, windspeedKmph];
}
