import 'package:flutter/material.dart';
import 'package:quiz_app/screens/quiz_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.lightBlue,
              const Color.fromARGB(255, 21, 101, 192),
              const Color.fromARGB(255, 13, 71, 161),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            spacing: 5,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset("assets/balloon.png"),
              Text(
                "Welcome to our",
                style: TextStyle(fontSize: 15, color: Colors.grey[400]),
              ),
              Text(
                "Quiz App",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 15),
              Text(
                "Enjoy playing the quiz game as the same time gaining knowledge as well !",
                style: TextStyle(fontSize: 15, color: Colors.grey[400]),
              ),
              Spacer(),
              Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => QuizScreen()),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 30),
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width - 75,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Text(
                      "Continue",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
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
