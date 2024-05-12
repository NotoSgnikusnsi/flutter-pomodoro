import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:PomTimer/padding.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: HomePageBody(),
    );
  }
}

class HomePageBody extends StatefulWidget {
  const HomePageBody({super.key});

  @override
  State<HomePageBody> createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {
  int _initialMinutes = 25;
  final TextEditingController _todoMessage = TextEditingController();

  void initialization() async {
    await Future.delayed(const Duration(seconds: 1));
    FlutterNativeSplash.remove();
  }

  @override
  void initState() {
    super.initState();
    initialization();
  }

  void _incrementMinutes() {
    int _minutes = _initialMinutes;
    if (_minutes >= 180) {
      return;
    } else {
      _minutes += 5;
    }
    setState(() {
      _initialMinutes = _minutes;
    });
  }

  void _decrementMinutes() {
    int _minutes = _initialMinutes;
    if (_minutes <= 5) {
      return;
    } else {
      _minutes -= 5;
    }
    setState(() {
      _initialMinutes = _minutes;
    });
  }

  void _goToTimerPage() {
    Navigator.pushNamed(
      context,
      "/work",
      arguments: {"data": _initialMinutes, "todo": _todoMessage.text},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.85,
        height: MediaQuery.of(context).size.height * 0.9,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "PomTimer",
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                Text(
                  "What are you going to do now?",
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ],
            ),
            DefaultSpace(),
            TextField(
              inputFormatters: [
                LengthLimitingTextInputFormatter(50),
              ],
              cursorColor: Theme.of(context).colorScheme.secondary,
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
              ),
              decoration: InputDecoration(
                hintStyle: TextStyle(
                  color:
                      Theme.of(context).colorScheme.secondary.withOpacity(0.5),
                ),
                hintText: "I'm going to...",
                contentPadding:
                    EdgeInsets.only(top: 0, bottom: 0, right: 10, left: 10),
                filled: true,
                fillColor: Theme.of(context).colorScheme.primary,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              controller: _todoMessage,
            ),
            DefaultSpace(),
            Container(
              width: MediaQuery.of(context).size.width * 0.85,
              height: MediaQuery.of(context).size.height * 0.3,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: _incrementMinutes,
                    icon: Icon(
                      Icons.arrow_drop_up,
                      color: Theme.of(context).colorScheme.secondary,
                      size: 40,
                    ),
                  ),
                  DefaultSpace(),
                  Text(
                    "$_initialMinutes:00",
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                  ),
                  DefaultSpace(),
                  IconButton(
                    onPressed: _decrementMinutes,
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: Theme.of(context).colorScheme.secondary,
                      size: 40,
                    ),
                  ),
                ],
              ),
            ),
            DefaultSpace(),
            TextButton(
              onPressed: _goToTimerPage,
              child: Text("START"),
              style: ButtonStyle(
                padding: MaterialStateProperty.all(
                  EdgeInsets.only(top: 15, bottom: 15, left: 40, right: 40),
                ),
                backgroundColor: MaterialStateProperty.all(
                  Theme.of(context).colorScheme.primary,
                ),
                foregroundColor: MaterialStateProperty.all(
                  Theme.of(context).colorScheme.secondary,
                ),
                textStyle: MaterialStateProperty.all(
                  Theme.of(context).textTheme.displayMedium,
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
