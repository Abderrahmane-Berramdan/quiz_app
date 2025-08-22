import 'package:flutter/material.dart';
import 'package:quiz_app/screens/splash_screen.dart';

class ResultScreen extends StatelessWidget {
  final int correctAnswer;
  final int incorrectAnswer;
  final int totaleQuestion;

  const ResultScreen({
    super.key,
    required this.correctAnswer,
    required this.incorrectAnswer,
    required this.totaleQuestion,
  });

  @override
  Widget build(BuildContext context) {
    late double score = (correctAnswer * 100 )/ totaleQuestion;
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
        child: Center(
          child: Column(
            spacing: 10,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Congratulations 🎉🎉\nYou Got ",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "$score %",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Correct Answer : $correctAnswer",
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Incorrect Answer : $incorrectAnswer",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(15),
                  ),
                ),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => SplashScreen()),
                    (route) => false,
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    "Back To Homa Page",
                    style: TextStyle(color: Colors.black, fontSize: 17),
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
