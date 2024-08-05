import "package:http/http.dart" as http;

import "dart:convert";

import "package:weather_app/auth/secrets.dart";

Future getFiveDaysForcastData(String location) async {
  final response = await http.get(Uri.parse(
      "https://api.openweathermap.org/data/2.5/forecast?q=${location}&appid=$SECRETKEY&units=metric"));
  if (response.statusCode == 200) {
    final decodedData = jsonDecode(response.body);
    // return decodedData;
    List<Map<String, dynamic>> allData = [];
    double temp = 0;
    double temp_min = 0;
    double temp_max = 0;
    String date = "";

    int counter = 0;
    for (var data in decodedData['list']) {
      if (counter == 0) {
        date = data['dt_txt'].split(' ')[0];
      }

      if (counter < 6) {
        temp += data['main']['temp'];
        temp_min += data['main']['temp_min'];
        temp_max += data['main']['temp_max'];
        counter++;
      } else {
        Map<String, dynamic> dayWeather = {
          "date": date,
          "temp": (temp / 6).toStringAsFixed(2),
          "temp_min": (temp_min / 6).toStringAsFixed(2),
          "temp_max": (temp_max / 6).toStringAsFixed(2),
        };
        allData.add(dayWeather);
        counter = 0;
        temp = 0;
        temp_min = 0;
        temp_max = 0;
      }
    }
    return allData;
  }
}
