import 'package:flutter/material.dart';
import 'package:weather_app/widgets/header_card.dart';

class ListOfSelectedWeather extends StatefulWidget {
  final List<String>? allLocation;
  const ListOfSelectedWeather({super.key, this.allLocation});

  @override
  State<ListOfSelectedWeather> createState() {
    return _LocationWeatherState();
  }
}

class _LocationWeatherState extends State<ListOfSelectedWeather> {
  void _onRemoveLocation(String location) {
    final locationIndex = widget.allLocation!.indexOf(location);
    setState(() {
      widget.allLocation!.remove(location);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 3),
      content: Text("$location remove from the list"),
      action: SnackBarAction(
        label: "Undo",
        onPressed: () => setState(() {
          widget.allLocation!.insert(locationIndex, location);
        }),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final locations = widget.allLocation ?? [];
    return GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            crossAxisSpacing: 20,
            childAspectRatio: 8 / 2,
            mainAxisSpacing: 20),
        padding: const EdgeInsets.all(16),
        children: locations
            .map((location) => Dismissible(
                  key: Key(location),
                  onDismissed: (direction) {
                    _onRemoveLocation(location);
                  },
                  child: HeaderCard(location: location),
                ))
            .toList());
  }
}
