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
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/work':
            final args = settings.arguments as Map<String, dynamic>?;
            return MaterialPageRoute(
              builder: (context) => WorkingPage(data: args?['data']),
            );
          // case '/break':
          //   final args = settings.arguments as Map<String, dynamic>?;
          //   return MaterialPageRoute(
          //     builder: (context) => BreakingPage(data: args?['data']),
          //   );
          // case '/rest':
          //   final args = settings.arguments as Map<String, dynamic>?;
          //   return MaterialPageRoute(
          //     builder: (context) => RestingPage(data: args?['data']),
          //   );
          default:
            return MaterialPageRoute(builder: (context) => HomePage());
        }
      },
    );
  }
}
