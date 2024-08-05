import 'package:flutter/material.dart';
import 'package:weather_app/Screen/home.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const App());
}

final themeData = ThemeData(
  textTheme: GoogleFonts.hedvigLettersSansTextTheme(),
);

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: themeData,
      home: const HomeScreen(),
    );
  }
}
