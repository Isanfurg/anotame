//call a http request from the api openweathercast
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:anotame/models/weather_model.dart';

class WeatherApiClient {
  String KEY = "03c4ace116740e04bf75ff5bd9857a27";
  Future<Weather>? getCurrentWeather(String lat, String long) async {
    String url = "https://api.openweathermap.org/data/2.5/weather?lat=" +
        lat +
        "&lon=" +
        long +
        "&dt=1643803200&appid=" +
        KEY;
    print(url);
    var endpoint = Uri.parse(url);
    var response = await http.get(endpoint);

    var data = jsonDecode(response.body);

    Weather weather = Weather.fromJson(data);

    return weather;
  }
}
