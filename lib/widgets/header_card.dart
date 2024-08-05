import 'package:flutter/material.dart';
import 'package:weather_app/Screen/weather_detail.dart';
import "package:weather_app/data/current_weather.dart";

class HeaderCard extends StatelessWidget {
  final String location;
  const HeaderCard({super.key, required this.location});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchCurrentData(location),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            final data = snapshot.data!;

            return InkWell(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailScreen(
                      location: data['name'],
                    ),
                  )),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white30,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          location,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Text("${data['temp_max']}° / ${data['temp_min']}°")
                      ],
                    ),
                    Text(
                      "${data['temp']}°",
                      style: Theme.of(context).textTheme.displayMedium,
                    )
                  ],
                ),
              ),
            );
            // }
          }
        });
  }
}
