import 'package:flutter/material.dart';

class BreakingPage extends StatelessWidget {
  const BreakingPage({super.key, required data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: const BreakingPageBody(),
    );
  }
}

class BreakingPageBody extends StatelessWidget {
  const BreakingPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: SizedBox(
          width: 400,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                cursorColor: Theme.of(context).colorScheme.primary,
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(
                      top: 0, bottom: 0, right: 10, left: 10),
                  hintText: "Change what you do?",
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.secondary,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(50.0),
              ),
              Text(
                "Take A Break",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: 24,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.bold,
                  height: 0,
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(10.0),
              ),
              Container(
                width: 400,
                height: 200,
                decoration: BoxDecoration(
                  color: Color(0xff518DF0),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    "25:00",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 60,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.bold,
                      height: 0,
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: null,
                icon: Icon(
                  Icons.pause,
                  color: Theme.of(context).colorScheme.secondary,
                  size: 60,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
