// {
//   "type":"multiple",
//   "difficulty":"hard",
//   "category":"Science: Computers",
//   "question":"What is the name of the process that sends one qubit of information using two bits of classical information?",
//   "correct_answer":"Quantum Teleportation",
//   "incorrect_answers":[
//     "Super Dense Coding",
//     "Quantum Entanglement",
//     "Quantum Programming"
//     ]
//   }

class QuizModel {
  final String type;
  final String difficulty;
  final String category;
  final String question;
  final String correctAnswer;
  final List incorrectAnswers;

  QuizModel({
    required this.type,
    required this.difficulty,
    required this.category,
    required this.question,
    required this.correctAnswer,
    required this.incorrectAnswers,
  });

  factory QuizModel.fromJson(Map<String, dynamic> json) {
    return QuizModel(
      type: json["type"],
      difficulty: json["difficulty"],
      category: json["category"],
      question: json["question"],
      correctAnswer: json["correct_answer"],
      incorrectAnswers: json["incorrect_answers"],
    );
  }
}
