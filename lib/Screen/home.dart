import 'package:flutter/material.dart';
import "package:weather_app/widgets/selected_location.dart";
// import 'package:weather_app/widgets/header.dart';
import "package:weather_app/widgets/search_bar.dart";
// import "package:http/http.dart" as http;
// import "dart:convert";

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> weatherData = [];
  List<String> searchHistory = [];
  List<String> addedLocation = [];
  bool isLoading = true;
  Map<String, dynamic> currentWeather = {};

  // @override
  // void initState() {
  //   super.initState();
  //   // fetchData();
  // }

  void addToSearchHistory(String query) {
    if (!searchHistory.contains(query)) {
      searchHistory.add(query);
    }
    print("Search History list ${searchHistory}");
    print("Added Location ${addedLocation}");
  }

  void removeSearchHistory(String query) {
    setState(() {
      searchHistory.remove(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tenki apuri"),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.blue.shade300, Colors.blue.shade600],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                final result = await showSearch(
                  context: context,
                  delegate: SearchAppBar(
                    onRemoveSearchHistory: removeSearchHistory,
                    searchHistory: searchHistory,
                    onAddToSearchHistory: addToSearchHistory,
                  ),
                );
                print("this the search result response ${result}");
                if (result != null && result is String) {
                  setState(() {
                    addedLocation.add(result);
                  });
                }
              },
              icon: const Icon(Icons.search))
        ],
      ),
      body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.blue.shade300, Colors.blue.shade600],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight),
          ),
          child: ListOfSelectedWeather(
            allLocation: addedLocation,
          )),
    );
  }
}
