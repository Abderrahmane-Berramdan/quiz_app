import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:quiz_app/model/quiz_model.dart';

class ApiService {
  static Future<List<QuizModel>> fetchQuestion() async {
    const url = "https://opentdb.com/api.php?amount=20&category=18";
    final uri = Uri.parse(url);
    final response = await http.get(uri);

    if (response.statusCode == 429) {
      Future.delayed(Duration(seconds: 5));
      return fetchQuestion();
    }

    if (response.statusCode == 200) {
      final body = response.body;
      final responseData = jsonDecode(body);

      final results = responseData["results"] as List<dynamic>;
      final questions = results.map((e) {
        return QuizModel.fromJson(e);
      }).toList();
      return questions;
    } else {
      throw Exception(
        "Field to load questions . status code ${response.statusCode}",
      );
    }
  }
}
