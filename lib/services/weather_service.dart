import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:weatherapp/models/weather_model.dart';

class WeatherService {
  final String apiKey = '45f91bf86b2f0e8bf1af4cc11b0bd728';
  final String baseURL = 'https://api.openweathermap.org/data/2.5/weather';
  final String endPoint = '&appid=45f91bf86b2f0e8bf1af4cc11b0bd728';

  Future<WeatherModel> fetchWeather(String city) async {
    final response = await http.get(Uri.parse(baseURL + '?q=$city' + endPoint));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return WeatherModel.fromJson(jsonData);
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
