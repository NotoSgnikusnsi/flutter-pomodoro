import 'dart:async';

import 'package:flutter/material.dart';

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
                  "Pomodoro",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 24,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.bold,
                    height: 0,
                  ),
                ),
                Text(
                  "What are you going to do now?",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 20,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w300,
                    height: 0,
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.all(10),
            ),
            TextField(
              cursorColor: Theme.of(context).colorScheme.secondary,
              style: TextStyle(color: Theme.of(context).colorScheme.secondary),
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.only(top: 0, bottom: 0, right: 10, left: 10),
                filled: true,
                fillColor: Theme.of(context).colorScheme.primary,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(10),
            ),
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
                  const Padding(
                    padding: EdgeInsets.all(5),
                  ),
                  Text(
                    "$_initialMinutes:00",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 60,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.bold,
                      height: 0,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(5),
                  ),
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
            const Padding(
              padding: EdgeInsets.all(10),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, "/work",
                    arguments: {"data": _initialMinutes});
              },
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
                  TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 24,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.bold,
                    height: 0,
                  ),
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
