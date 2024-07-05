import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:foodfinder_app/HomePage.dart';
import 'RecipePage.dart';

void main() {
  runApp(const MyFirstApp());
}

class MyFirstApp extends StatelessWidget {
  const MyFirstApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "FoodFinder",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.purple,
          primary: Colors.white,
          onPrimary: const Color(0xFFF5DC51),
          secondary: const Color(0xFFED736B),
          onSecondary: const Color(0xFF71BD71),
        ),
        scaffoldBackgroundColor: const Color(0xFFFFFBF9),
        appBarTheme: const AppBarTheme(
          backgroundColor: const Color(0xFFFFFBF9),
        ),
        primaryColor: const Color(0xFFFBF9),
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        textTheme: TextTheme(
          titleLarge: GoogleFonts.afacad(
            fontSize: 32,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          bodyMedium: GoogleFonts.afacad(
            color: Colors.black,
            fontSize: 10,
            letterSpacing: 0,
          ),
        ),
      ),
      home: RecipePage(
        portionen: 2,
        zutaten: [
          ['200', 'ml', 'Pesto'],
          ['100', 'g','Walnüsse'],
          ['400', 'g', 'Pasta'],
          ['', '', 'Basilikum'],
          ['1', 'Prise', 'Salz']
        ],
      ),
    );
  }
}
