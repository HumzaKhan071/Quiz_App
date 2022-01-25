// ignore_for_file: avoid_unnecessary_containers, deprecated_member_use

import 'package:flutter/material.dart';

import 'quiz_screen.dart';

class Result extends StatelessWidget {
  final int score;
  const Result({Key? key, required this.score}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2D046E),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              const SizedBox(
                height: 90,
              ),
              const Center(
                  child: Image(
                image: AssetImage("assets/q.png"),
                height: 300,
                width: 300,
              )),
              const Text(
                "Result",
                style: TextStyle(fontSize: 35, color: Color(0xFFA20CBE)),
              ),
              Text(
                "$score/10",
                style: TextStyle(fontSize: 60, color: Color(0xFFFFBA00)),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
                child: RaisedButton(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const QuizScreen()));
                  },
                  color: const Color(0xFFFFBA00),
                  child: const Text(
                    "RESTART",
                    style: TextStyle(fontSize: 32),
                  ),
                  textColor: Colors.white,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(
                  horizontal: 30,
                ),
                child: RaisedButton(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  color: const Color(0xFF511AAB),
                  child: const Text(
                    "EXIT",
                    style: TextStyle(fontSize: 32),
                  ),
                  textColor: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
