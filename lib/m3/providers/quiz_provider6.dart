import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import '../models/questions1.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

// 7-8.hét
class QuizProvider6 with ChangeNotifier {
  List<String> previousAnswers =
      []; // Add this property to store previous answers

  // Method to save answers from question 4.1 (index 14)
  void savePreviousAnswers(List<String> answers) {
    previousAnswers = answers;
    notifyListeners();
  }

  final List<Question> _questions = [
    Question(
      text: 'Szia! \nHogy vagy? Mit sikerült megvalósítani a tervedből?',
      index: 0,
      requiresTextInput: false,
      requiresVideo: false,
      requiresRadioOptions: true, // Enable radio options
      radioOptions: [
        RadioOption(text: 'Még nem álltam neki', nextQuestionIndex: 1),
        RadioOption(text: 'Már haladok az úton', nextQuestionIndex: 5),
      ],
      answers: [],
      twoColumn: false, // No d
    ),
    Question(
      text: 'Próbálj ki valamit!',
      index: 1,
      requiresTextInput: false,
      requiresRadioOptions: true, // Enable radio options
      radioOptions: [
        RadioOption(text: 'JOKER', nextQuestionIndex: 2),
        RadioOption(text: 'JOKER', nextQuestionIndex: 3),
        RadioOption(text: 'JOKER', nextQuestionIndex: 4),
      ],
      answers: [],
      twoColumn: false, // No d
    ),
    Question(
      text: 'Ez egy 10-15 perces hasi átmozgató torna',
      index: 2,
      requiresTextInput: false,
      nooption: true,
      answers: [],
      twoColumn: false,
      steptoquestion: 6,
    ),
    Question(
      text: 'Ez egy 10-15 perces hasi légzés',
      index: 3,
      requiresTextInput: false,
      answers: [],
      nooption: true,
      twoColumn: false, // No d
      steptoquestion: 6,
    ),
    Question(
      text: 'Ez egy 10-15 perces progresszív izomrelaxáció',
      index: 4,
      requiresTextInput: false,
      answers: [],
      twoColumn: false,
      nooption: true,
      steptoquestion: 6,
    ),
    Question(
      twoColumn: false,
      text: '1.1. kérdés: Mi volt az elmúlt pár heted legnagyobb sikere mozgás szempontjából? Mit sikerült megvalósítani a tervedből?',
      index: 5,
      requiresTableBigger: true,
      requiresTextInput: false,
      check: true,
      extra: true,
      answers: [],
    ),
    Question(
      twoColumn: false,
      text:
      '1.2 Kérdés: Változtatnál valamit a terveden? Növelnéd a gyakoriságot vagy új mozgást hoznál be? Most itt a lehetőség, hogy módosítsd a terved.',
      index: 6,
      requiresTextInput: false,
      requiresTableBigger: true,
      check: true,
      extra: true,
      answers: [],
    ),
    Question(
      twoColumn: false,
      text:
      'Köszönjük a kitartó munkádat! Hamarosan újra találkozunk, addig is, mozgásra fel!',
      index: 7,
      requiresTextInput: false,
      requiresRadioOptions: true, // Enable radio options
      radioOptions: [
        RadioOption(text: 'Mozgásra fel!', nextQuestionIndex: 8),
      ],
      answers: [],    ),

  ];

  int _currentQuestionIndex = 0;
  int _score = 0;

  Question get currentQuestion => _questions[_currentQuestionIndex];

  bool get isQuizFinished => _currentQuestionIndex >= _questions.length;

  int get score => _score;

  void answerQuestion(int nextQuestionIndex) {
    if (nextQuestionIndex <= _questions.length) {
      _currentQuestionIndex = nextQuestionIndex;
    } else {
      _currentQuestionIndex = _questions.length + 1; // Mark as finished
    }
    _score++;
    notifyListeners();
  }


  void nextQuestion() {
    // Get the current question
    Question currentQuestion = _questions[_currentQuestionIndex];

    // Check if the current question has a 'steptoquestion' defined
    if (currentQuestion.steptoquestion != -1 && currentQuestion.steptoquestion < _questions.length) {
      // Jump to the question specified by 'steptoquestion'
      _currentQuestionIndex = currentQuestion.steptoquestion;
    } else if (_currentQuestionIndex < _questions.length - 1) {
      // Proceed to the next question if not at the end
      _currentQuestionIndex++;
    } else {
      // Mark as finished if at the end of the question list
      _currentQuestionIndex = _questions.length;
    }

    // Notify listeners about the change
    notifyListeners();
  }


  void resetQuiz() {
    _currentQuestionIndex = 0;
    _score = 0;
    notifyListeners();
  }

  void updateRankableOptions(List<String> options) {
    _questions[_currentQuestionIndex].rankableOptions = options;
    notifyListeners();
  }

  List<String> getAnswersForQuestion(int questionIndex) {
    return _questions[questionIndex]
        .answers
        .map((answer) => answer.text)
        .toList();
  }

  Future<void> saveUserResponse(Map<String, List<String>> answeerMap) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String jsonString = json.encode(answeerMap.map(
        (key, list) =>
            MapEntry(key, list.map((item) => item.toString()).toList()),
      ));
      await prefs.setString('user_response', jsonString);
    } catch (e) {
      print('Here we got exception in save data $e');
    }
  }
}
