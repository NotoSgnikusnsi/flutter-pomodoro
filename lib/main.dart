import 'package:flutter/material.dart';
import 'package:flutter_pomodoro/breaking_page.dart';
import 'package:flutter_pomodoro/home_page.dart';
import 'package:flutter_pomodoro/resting_page.dart';
import 'package:flutter_pomodoro/working_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Pomodoro",
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          primary: Color(0xff1e1e1e),
          secondary: Color(0xffFBF4F4),
          tertiary: Color(0xff0A0A0A),
        ),
      ),
      routes: {
        "/": (context) => RestingPage(),
        "/work": (context) => WorkingPage(),
        "/break": (context) => BreakingPage(),
        "/rest": (context) => RestingPage(),
      },
    );
  }
}
