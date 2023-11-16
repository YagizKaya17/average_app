import 'package:average_app/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
            centerTitle: true,
            elevation: 0,
          ),
          fontFamily: GoogleFonts.rubik().fontFamily),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
