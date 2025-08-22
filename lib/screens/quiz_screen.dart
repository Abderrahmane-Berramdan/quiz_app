import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quiz_app/model/quiz_model.dart';
import 'package:quiz_app/screens/result_screen.dart';
import 'package:quiz_app/service/api_service.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int seconds = 60;
  Timer? timer;
  int? selectIndex;
  bool? isCorrect;
  bool isLoading = false;
  int indexQuestion = 0;
  List<QuizModel> quizList = [];
  List answers = [];
  int correctAnswer = 0;
  int incorrectAnswer = 0;

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (seconds > 0) {
        setState(() {
          seconds--;
        });
      } else {
        indexQuizIncrement();
      }
    });
  }

  void indexQuizIncrement() {
    setState(() {
      selectIndex = null;
      isCorrect = null;
      indexQuestion++;
      timer!.cancel();
      seconds = 60;
      startTimer();
      answers = List.from(quizList[indexQuestion].incorrectAnswers);
      answers.add(quizList[indexQuestion].correctAnswer);
      answers.shuffle();
    });
  }

  bool verify(dynamic answer, QuizModel question) {
    if (answer == question.correctAnswer) {
      correctAnswer++;
      return true;
    } else {
      incorrectAnswer++;
      return false;
    }
  }

  Future<void> fetchQuiz() async {
    setState(() {
      isLoading = true;
    });
    final response = await ApiService.fetchQuestion();
    setState(() {
      quizList = response;
      answers = List.from(quizList[indexQuestion].incorrectAnswers);
      answers.add(quizList[indexQuestion].correctAnswer);
      isLoading = false;
    });
    startTimer();
  }

  @override
  void initState() {
    super.initState();
    fetchQuiz();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.lightBlue,
              const Color.fromARGB(255, 21, 101, 192),
              const Color.fromARGB(255, 13, 71, 161),
            ],
          ),
        ),
        child: SafeArea(
          child: isLoading
              ? Center(child: CircularProgressIndicator(color: Colors.white))
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 20,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              timer!.cancel();
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.cancel_outlined,
                              color: Colors.red[700],
                              size: 70,
                            ),
                          ),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Text(
                                "$seconds",
                                style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 60,
                                width: 60,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 4,
                                  value: seconds / 60,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          height: 170,
                          width: 170,
                          child: Image.asset("assets/ideas.png"),
                        ),
                      ),
                      Text(
                        "Question ${indexQuestion + 1} of ${quizList.length}",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        quizList[indexQuestion].question,
                        style: TextStyle(fontSize: 16, color: Colors.grey[400]),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: answers.length,
                          itemBuilder: (context, i) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectIndex = i;
                                  isCorrect = verify(
                                    answers[i],
                                    quizList[indexQuestion],
                                  );
                                });

                                if (indexQuestion < quizList.length - 1) {
                                  Future.delayed(
                                    Duration(milliseconds: 200),
                                    () {
                                      indexQuizIncrement();
                                    },
                                  );
                                } else {
                                  timer!.cancel();
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ResultScreen(
                                        correctAnswer: correctAnswer,
                                        incorrectAnswer: incorrectAnswer,
                                        totaleQuestion: quizList.length,
                                      ),
                                    ),
                                    (route) => false,
                                  );
                                }
                              },
                              child: Container(
                                margin: EdgeInsets.only(bottom: 15),
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width - 75,
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: selectIndex == i
                                      ? isCorrect!
                                            ? Colors.green
                                            : Colors.red
                                      : Colors.white,
                                ),
                                child: Text(
                                  "${answers[i]}",
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}