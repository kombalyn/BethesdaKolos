import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import '../models/questions1.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

//4.hét
class QuizProvider3 with ChangeNotifier {
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
      steptoquestion: 3,
      answers: [],
      twoColumn: false,
    ),
    Question(
      text: 'Ez egy 10-15 perces hasi légzés',
      index: 3,
      requiresTextInput: false,
      nooption: true,
      steptoquestion: 4,
      answers: [],
      twoColumn: false, // No d
    ),
    Question(
      text: 'Ez egy 10-15 perces progresszív izomrelaxáció',
      index: 4,
      requiresTextInput: false,
      nooption: true,
      steptoquestion: 5,
      answers: [],
      twoColumn: false, // No d
    ),
    Question(
      twoColumn: false,
      text: 'kérdés: Kérlek írd le, mikor, kivel és mennyit mozogtál az elmúlt héten.',
      index: 5,
      requiresTextInput: true,
      answers: [],
    ),
    Question(
      twoColumn: false,
      text:
      'Ez a kérdőív véget ért. \n \n Köszönjük a válaszaidat!',
      index: 6,
      answers: [],
      //answers: [Answer(nextQuestionIndex: 27)],
    ),

  ];

  int _currentQuestionIndex = 0;
  int _score = 0;

  // History to track navigation for back functionality
  List<int> _navigationHistory = [];

  Question get currentQuestion => _questions[_currentQuestionIndex];

  bool get isQuizFinished => _currentQuestionIndex >= _questions.length;

  int get score => _score;

  // Check if we can go back to previous question
  bool canGoBack() {
    return _navigationHistory.isNotEmpty;
  }

  // Go to previous question
  void previousQuestion() {
    if (_navigationHistory.isNotEmpty) {
      _currentQuestionIndex = _navigationHistory.removeLast();
      notifyListeners();
    }
  }

  void answerQuestion(int nextQuestionIndex) {
    if (nextQuestionIndex >= 0 && nextQuestionIndex < _questions.length) {
      // Save current index to history before navigating
      _navigationHistory.add(_currentQuestionIndex);
      _currentQuestionIndex = nextQuestionIndex;
      notifyListeners();
    } else {
      // Kérdőív vége kezelése
      _currentQuestionIndex = _questions.length;
      notifyListeners();
      // Ide jöhet egy callback vagy navigáció
    }
  }

  void nextQuestion() {
    // Get the current question
    Question currentQuestion = _questions[_currentQuestionIndex];

    // Save current index to history before navigating
    _navigationHistory.add(_currentQuestionIndex);

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
    _navigationHistory.clear();
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