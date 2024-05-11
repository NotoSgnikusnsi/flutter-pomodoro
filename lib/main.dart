import 'package:PomTimer/breaking_page.dart';
import 'package:PomTimer/home_page.dart';
import 'package:PomTimer/resting_page.dart';
import 'package:PomTimer/working_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
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
          secondary: Color.fromARGB(255, 255, 245, 245),
          tertiary: Color(0xff0A0A0A),
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: 60,
            fontFamily: 'Inter',
            fontWeight: FontWeight.bold,
            height: 0,
          ),
          displayMedium: TextStyle(
            fontSize: 24,
            fontFamily: 'Inter',
            fontWeight: FontWeight.bold,
            height: 0,
          ),
          displaySmall: TextStyle(
            fontSize: 20,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w300,
            height: 0,
          ),
        ),
      ),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/work':
            final args = settings.arguments as Map<String, dynamic>?;
            return MaterialPageRoute(
              builder: (context) => WorkingPage(
                data: args?['data'],
                todo: args?['todo'],
              ),
            );
          case '/break':
            final args = settings.arguments as Map<String, dynamic>?;
            return MaterialPageRoute(
              builder: (context) => BreakingPage(
                data: args?['data'],
                todo: args?['todo'],
              ),
            );
          case '/rest':
            final args = settings.arguments as Map<String, dynamic>?;
            return MaterialPageRoute(
              builder: (context) => RestingPage(
                data: args?['data'],
                todo: args?['todo'],
              ),
            );
          default:
            return MaterialPageRoute(
              builder: (context) => HomePage(),
            );
        }
      },
    );
  }
}
