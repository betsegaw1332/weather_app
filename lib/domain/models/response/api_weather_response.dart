import 'dart:convert';

import 'package:equatable/equatable.dart';

class APIWeatherResponse extends Equatable {
  final List<Map<String, dynamic>> weather;
  const APIWeatherResponse({
    required this.weather,
  });

  APIWeatherResponse copyWith({
    List<Map<String, dynamic>>? weather,
  }) {
    return APIWeatherResponse(
      weather: weather ?? this.weather,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'weather': weather,
    };
  }

  factory APIWeatherResponse.fromMap(Map<String, dynamic> map) {
    return APIWeatherResponse(
      weather: List<Map<String, dynamic>>.from(
        (map['weather'] as List<dynamic>).map<Map<String, dynamic>>(
          (x) => x as Map<String, dynamic>,
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory APIWeatherResponse.fromJson(String source) =>
      APIWeatherResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [weather];
}
