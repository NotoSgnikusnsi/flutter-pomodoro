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

class HomePageBody extends StatelessWidget {
  const HomePageBody({super.key});

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
                style:
                    TextStyle(color: Theme.of(context).colorScheme.secondary),
                decoration: InputDecoration(
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
                width: 400,
                height: 300,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: null,
                      icon: Icon(
                        Icons.arrow_drop_up,
                        color: Theme.of(context).colorScheme.secondary,
                        size: 60,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(5),
                    ),
                    Text(
                      "25:00",
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
                      onPressed: null,
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: Theme.of(context).colorScheme.secondary,
                        size: 60,
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(10),
              ),
              TextButton(
                onPressed: null,
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
      ),
    );
  }
}
