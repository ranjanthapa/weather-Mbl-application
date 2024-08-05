import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:weather_app/auth/secrets.dart';

Future<Map<String, dynamic>> fetchCurrentData(String location) async {
  Map<String, dynamic> data = {};
  try {
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$location&appid=$SECRETKEY&units=metric'));

    if (response.statusCode != 200) {
      print('Failed to load weather data: ${response.statusCode}');
      return {"message": "Failed to load weather data"};
    }

    final Map<String, dynamic> jsonData = jsonDecode(response.body);
    data['name'] = jsonData['name'];
    data['temp'] = jsonData['main']['temp'];
    data['temp_min'] = jsonData['main']['temp_min'];
    data['temp_max'] = jsonData['main']['temp_max'];
    data['description'] = jsonData['weather'][0]['description'];
    data['iconCode'] = jsonData['weather'][0]['icon'];
    data['cod'] = 200;
    print(data);
    return data;
  } catch (e) {
    print('Exception details: $e');
    return {"message": "Incorrect location"};
  }
}
