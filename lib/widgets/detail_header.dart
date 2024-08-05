import 'package:flutter/material.dart';
import 'package:weather_app/data/current_weather.dart';

class DetailHeader extends StatelessWidget {
  final String location;
  const DetailHeader({super.key, required this.location});

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
            return Column(
              children: [
                Text(
                  location,
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                Text(
                  "${data['temp']}°",
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                Text("${data['description']}",
                    style: const TextStyle(fontSize: 18)),
                Text("H:${data['temp_max']}° L: ${data['temp_min']}°",
                    style: const TextStyle(fontSize: 16)),
              ],
            );
          }
        });
  }
}
