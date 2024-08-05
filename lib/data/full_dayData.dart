import "package:http/http.dart" as http;
import "dart:convert";

import "package:weather_app/auth/secrets.dart";

Future getFullDayData(DateTime requireDate, String location) async {
  List<Map<String, dynamic>> allData = [];
  final response = await http.get(Uri.parse(
      "https://api.openweathermap.org/data/2.5/forecast?q=$location&appid=$SECRETKEY&units=metric"));
  if (response.statusCode != 200) {
    print("failed to fetch the data");
  } else {
    final decodedData = jsonDecode(response.body);
    String strRequireDate = requireDate.toString().split(' ')[0];
    String date = '';
    for (var data in decodedData['list']) {
      date = data['dt_txt'].toString().split(' ')[0];
      if (strRequireDate == date) {
        allData.add(data);
      }
    }
    return allData;
  }
}
