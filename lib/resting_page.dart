import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:PomTimer/padding.dart';
import 'dart:async';

import 'package:PomTimer/timer.dart';

class RestingPage extends StatelessWidget {
  final int data;
  final String todo;
  const RestingPage({super.key, required this.data, required this.todo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: RestingPageBody(data: data, todo: todo),
    );
  }
}

class RestingPageBody extends StatefulWidget {
  final int data;
  final String todo;
  const RestingPageBody({super.key, required this.data, required this.todo});

  @override
  State<RestingPageBody> createState() => _RestingPageBodyState();
}

class _RestingPageBodyState extends State<RestingPageBody> {
  late String _todoMessage;
  final TextEditingController _newTodoMessage = TextEditingController();
  late int _initialMinutes;
  late Timer? _changeTimerState;
  late String _minutes = "";
  late String _second = "";

  final PomodoroTimer _pomodoroTimer = PomodoroTimer();

  @override
  void initState() {
    super.initState();
    _initialMinutes = widget.data;
    _todoMessage = widget.todo;
    _pomodoroTimer.startTimer(_initialMinutes, TimerState.resting);
    _changeTimerState = Timer.periodic(const Duration(seconds: 1), _updateTime);
  }

  @override
  void dispose() {
    _pomodoroTimer.resetTimer();
    _changeTimerState?.cancel();
    super.dispose();
  }

  void _setTimerState() {
    if (_changeTimerState!.isActive) {
      _pomodoroTimer.stopTimer();
      _changeTimerState?.cancel();
    } else {
      _pomodoroTimer.startTimer(0, TimerState.working);
      _changeTimerState =
          Timer.periodic(const Duration(seconds: 1), _updateTime);
    }

    setState(() {});
  }

  void _resetAllTimer() {
    _pomodoroTimer.resetTimer();
    _changeTimerState?.cancel();
  }

  void _goBackPage(BuildContext context) {
    String message = "";
    _resetAllTimer();
    if (_newTodoMessage.text == "") {
      message = _todoMessage;
    } else {
      message = _newTodoMessage.text;
    }
    Navigator.pop(context, message);
  }

  void _updateTime(Timer timer) {
    String _currentMinutes =
        _pomodoroTimer.getCurrentMinutes().toString().padLeft(2, "0");
    String _currentSeconds =
        _pomodoroTimer.getCurrentSeconds().toString().padLeft(2, "0");
    if (_currentMinutes == "00" && _currentSeconds == "00") {
      _goBackPage(context);
    }

    setState(() {
      _minutes = _currentMinutes;
      _second = _currentSeconds;
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
            TextField(
              inputFormatters: [
                LengthLimitingTextInputFormatter(50),
              ],
              cursorColor: Theme.of(context).colorScheme.primary,
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
              ),
              decoration: InputDecoration(
                hintText: "$_todoMessage",
                contentPadding:
                    EdgeInsets.only(top: 0, bottom: 0, right: 10, left: 10),
                filled: true,
                fillColor: Theme.of(context).colorScheme.secondary,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              controller: _newTodoMessage,
            ),
            DefaultSpace(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    _goBackPage(context);
                  },
                  icon: Icon(
                    Icons.arrow_left,
                    color: Theme.of(context).colorScheme.secondary,
                    size: 32,
                  ),
                ),
                Text(
                  "Rest",
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                ),
                IconButton(
                  onPressed: null,
                  icon: Icon(
                    Icons.arrow_right,
                    color: Theme.of(context).colorScheme.tertiary,
                    size: 32,
                  ),
                ),
              ],
            ),
            DefaultSpace(),
            Container(
              width: MediaQuery.of(context).size.width * 0.85,
              height: MediaQuery.of(context).size.height * 0.3,
              decoration: BoxDecoration(
                color: const Color(0xffC5F051),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  "$_minutes:$_second",
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                _setTimerState();
              },
              icon: Icon(
                _changeTimerState!.isActive ? Icons.pause : Icons.play_arrow,
                color: Theme.of(context).colorScheme.secondary,
                size: 60,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
