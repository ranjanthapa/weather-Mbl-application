import 'package:flutter/material.dart';
import 'package:weather_app/data/five_day_forcast_data.dart';

import 'package:intl/intl.dart';

DateTime today = DateTime.now();
DateTime tomorrow = today.add(const Duration(days: 1));
DateFormat dateFormat = DateFormat('EEEE');

class FiveDayForcast extends StatelessWidget {
  final String location;
  const FiveDayForcast({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getFiveDaysForcastData(location),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          final alldata = snapshot.data!;

          return Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Color.fromRGBO(91, 61, 61, 0.098),
            ),
            child: Column(
              children: alldata.map<Widget>((data) {
                bool isToday = today.toString().split(' ')[0] == data['date'];
                bool isTomorrow =
                    tomorrow.toString().split(' ')[0] == data['date'];
                String dayText;

                if (isToday) {
                  dayText = "Today";
                } else if (isTomorrow) {
                  dayText = "Tomorrow";
                } else {
                  dayText = dateFormat.format(DateTime.parse(data['date']));
                }
                return Column(
                  children: [
                    InkWell(
                      onTap: () => print("Tapped on ${data['date']}"),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            dayText,
                            style: const TextStyle(fontSize: 18),
                          ),
                          Text(
                            "${data['temp_max']}° / ${data['temp_min']}°",
                            style: const TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                );
              }).toList(),
            ),
          );
        }
      },
    );
  }
}
