import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import '../models/questions1.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

// 6.hét
class QuizProvider5 with ChangeNotifier {
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
      text: '1.1. kérdés: Kérlek írd le, mikor, kivel és mennyit mozogtál az elmúlt héten.',
      index: 5,
      requiresTableBigger: true,
      requiresTextInput: false,
      check: true,
      extra: true,
      answers: [],
    ),
    Question(
      twoColumn: false,
      text: '1.2. kérdés: Pár hete beszéltünk olyan aktivitásokról, melyek segíthetik hosszútávon fenntartani a mozgással kapcsolatos motivációd. Melyik módszerrel próbálkoztás eddig, melyik vált be?',
      index: 6,
      requiresCheckOptions: true,
      checkOptions: [
        RadioOption(text: 'Találd meg a miérted!', nextQuestionIndex: 7),
        RadioOption(text: 'Vezess naplót!', nextQuestionIndex: 7),
        RadioOption(text: 'Találj támogató közösséget!', nextQuestionIndex: 7),
        RadioOption(text: 'Jutalmazd meg magad!', nextQuestionIndex: 7),
        RadioOption(text: 'Képzeld el a pozitív jövőt!', nextQuestionIndex: 7),
        RadioOption(text: 'Még egyiket sem', nextQuestionIndex: 7),
      ],
      requiresTextInput: false,
      answers: [],
    ),
    Question(
      twoColumn: false,
      text: '1.3. kérdés: Melyik stratégiát alkalmaztad eddig?',
      index: 7,
      requiresCheckOptions: true,
      checkOptions: [
        RadioOption(text: 'Találd meg a miérted!', nextQuestionIndex: 8),
        RadioOption(text: 'Vezess naplót!', nextQuestionIndex: 8),
        RadioOption(text: 'Találj támogató közösséget!', nextQuestionIndex: 8),
        RadioOption(text: 'Jutalmazd meg magad!', nextQuestionIndex: 8),
        RadioOption(text: 'Képzeld el a pozitív jövőt!', nextQuestionIndex: 8),
        RadioOption(text: 'Még egyiket sem', nextQuestionIndex: 9),
      ],
      requiresTextInput: false,
      answers: [],
    ),
      Question(
      twoColumn: false,
      text: '1.4. kérdés: Írd le, hogy hogyan és mikor alkalmaztad az adott stratégiát!',
      index: 8,
      requiresTextInput: true,
      answers: [],
      ),

    Question(
      twoColumn: false,
      text:
      'Köszönjük a kitartó munkádat! Hamarosan újra találkozunk. Addig is, mozgásra fel!',
      index: 9,
      requiresTextInput: false,
      requiresRadioOptions: true, // Enable radio options
      radioOptions: [
        RadioOption(text: 'Mozgásra fel!', nextQuestionIndex: 10),
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
