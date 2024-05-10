import 'package:flutter/material.dart';

class WorkingPage extends StatelessWidget {
  const WorkingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: const WorkingPageBody(),
    );
  }
}

class WorkingPageBody extends StatelessWidget {
  const WorkingPageBody({super.key});

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
              Text(
                "ポモドーロのアプリを作る",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: 30,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.bold,
                  height: 0,
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(50.0),
              ),
              Text(
                "Working",
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
                  color: const Color(0xffF06852),
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
