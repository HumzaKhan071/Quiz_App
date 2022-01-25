// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'quiz_screen.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarBrightness: Brightness.dark));
    return Scaffold(
      backgroundColor: Color(0xFF2D046E),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              SizedBox(
                height: 90,
              ),
              Center(
                  child: Image(
                image: AssetImage("assets/q.png"),
                height: 300,
                width: 300,
              )),
              Text(
                "Quiz",
                style: TextStyle(fontSize: 90, color: Color(0xFFA20CBE)),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 30, vertical: 40),
                child: RaisedButton(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => QuizScreen()));
                  },
                  color: Color(0xFFFFBA00),
                  child: Text(
                    "PLAY",
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
