import 'dart:io';
import 'dart:convert';

import 'package:flutter/services.dart';

class QuestionDatasource {
  static const String pathQuestions = 'json/question_datasource.json';
  // static const String pathQuestions =
  //     '/lib/data/datasources/local/entities/question_datasource.json';

  Future<dynamic> getQuestions() async {
    String contents = await rootBundle.loadString(pathQuestions);
    dynamic questions =
        json.decode(contents) as List<List<Map<String, dynamic>>>;
    print('0');
    // List<List<Map<String, dynamic>>> questions = json.decode(contents);
    // print('2');

    return questions;
  }
}
