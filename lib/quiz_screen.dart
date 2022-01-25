

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:quiz_app/quiz_helper.dart';
import 'package:http/http.dart' as http;
import 'package:quiz_app/result.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  var apiURL =
      "https://opentdb.com/api.php?amount=10&category=18&type=multiple";

  QuizHelper? quizHelper;
  int currentQuestion = 0;

  int totalSeconds = 30;
  int elapsedSeconds = 0;

  late Timer timer;

  int score = 0;

  @override
  void initState() {
    fetchAllQuiz();
    super.initState();
  }

  fetchAllQuiz() async {
    var response = await http.get(Uri.parse(apiURL));

    var body = response.body;

    var json = jsonDecode(body);

    setState(() {
      quizHelper = QuizHelper.fromJson(json);
      quizHelper!.results![currentQuestion].incorrectAnswers!
          .add(quizHelper!.results![currentQuestion].correctAnswer!);

      quizHelper!.results![currentQuestion].incorrectAnswers!.shuffle();

      initTmer();
    });
  }

  initTmer() {
    timer = Timer.periodic(Duration(seconds: 1), (t) {
      if (t.tick == totalSeconds) {
        print("Time Completed");
        t.cancel();
        changeQuestion();
      } else {
        setState(() {
          elapsedSeconds = t.tick;
        });
      }
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  checkAnswer(answer) {
    String correctAnswer = quizHelper!.results![currentQuestion].correctAnswer!;
    if (correctAnswer == answer) {
      score += 1;
    } else {
      print("Wrong");
    }
    changeQuestion();
  }

  changeQuestion() {
    timer.cancel();

    if (currentQuestion == quizHelper!.results!.length - 1) {
      print("Quiz Completed");
      print("Socre $score");

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => Result(score: score)));
    } else {
      setState(() {
        currentQuestion += 1;
      });

      quizHelper!.results![currentQuestion].incorrectAnswers!
          .add(quizHelper!.results![currentQuestion].correctAnswer!);

      quizHelper!.results![currentQuestion].incorrectAnswers!.shuffle();

      initTmer();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (quizHelper != null) {
      return Scaffold(
        backgroundColor: const Color(0xFF2D046E),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 60),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Image(
                      image: AssetImage("assets/q.png"),
                      width: 70,
                      height: 70,
                    ),
                    Text(
                      "${elapsedSeconds}s",
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "Q. ${quizHelper!.results![currentQuestion].question}",
                  style: const TextStyle(
                    fontSize: 35,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
                  child: Column(
                    children: quizHelper!
                        .results![currentQuestion].incorrectAnswers!
                        .map((option) => Container(
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              child: RaisedButton(
                                onPressed: () {
                                  checkAnswer(option);
                                },
                                color: const Color(0xFF511AA8),
                                colorBrightness: Brightness.dark,
                                padding: const EdgeInsets.symmetric(vertical: 20),
                                child: Text(
                                  option,
                                  style: const TextStyle(fontSize: 18),
                                ),
                              ),
                            ))
                        .toList(),
                  ))
            ],
          ),
        ),
      );
    } else {
      return const Scaffold(
        backgroundColor: const Color(0xFF2D046E),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }
}
