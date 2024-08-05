import 'package:flutter/material.dart';
import 'package:weather_app/widgets/detail_header.dart';
import 'package:weather_app/widgets/five_day_forcast.dart';
import 'package:weather_app/widgets/full_day_detail.dart';

class DetailScreen extends StatelessWidget {
  final String location;
  const DetailScreen({super.key, required this.location});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.blue.shade300, Colors.blue.shade600],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight),
        ),
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              DetailHeader(location: location),
              const SizedBox(
                height: 50,
              ),
              FullDayDetail(date: DateTime.now(), location: location),
              FiveDayForcast(
                location: location,
              )
            ],
          ),
        ),
      ),
    );
  }
}
