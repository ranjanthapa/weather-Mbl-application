import 'package:weather_app/data/full_dayData.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FullDayDetail extends StatelessWidget {
  final DateTime date;
  final String location;

  const FullDayDetail({super.key, required this.date, required this.location});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getFullDayData(date, location),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          final allData = snapshot.data;
          print(allData);
          return Container(
            height: 180,
            decoration: const BoxDecoration(
              color: Color.fromRGBO(91, 61, 61, 0.098),
            ),
            padding: const EdgeInsets.all(20),
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: allData.length,
              separatorBuilder: (context, index) => const SizedBox(width: 30),
              itemBuilder: (context, index) {
                var data = allData[index];
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(
                      "https://openweathermap.org/img/wn/${data['weather'][0]['icon']}@2x.png",
                      width: 60,
                      height: 60,
                    ),
                    Text(DateFormat('h:mm a')
                        .format(DateTime.parse(data['dt_txt']))),
                    const SizedBox(height: 20),
                    Text("${data['main']['temp']}°"),
                  ],
                );
              },
            ),
          );
        }
      },
    );
  }
}
