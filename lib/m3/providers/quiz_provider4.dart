import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import '../models/questions1.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

// 5.hét
class QuizProvider4 with ChangeNotifier {
  List<String> previousAnswers =
      []; // Add this property to store previous answers

  // Method to save answers from question 4.1 (index 14)
  void savePreviousAnswers(List<String> answers) {
    previousAnswers = answers;
    notifyListeners();
  }

  final List<Question> _questions = [
    Question(
      text: 'Kérlek, nézd meg ezt a videót!',
      index: 0,
      requiresTextInput: false,
      requiresVideo: false,
      twoColumn: false,
      answers: [
        Answer(
          nextQuestionIndex: 1,
          isVideo: true,
          video: 'majdvalami',
        ),
        // Provide the video URL here
      ],
    ),
    Question(
      text: '1. kérdés:  Mi volt az elmúlt pár heted legnagyobb sikere mozgás szempontjából? Mit sikerült megvalósítani a tervedből?',
      index: 1,
      twoColumn: false,
      requiresTextInput: true,
      answers: [],
    ),
    Question(
      index: 2,
      twoColumn: false,
      text: 'Kérlek, nézd meg ezt a videót!',
        requiresVideo: true,

        requiresTextInput: false,
        answers: [
        Answer(
        nextQuestionIndex: 3,
        isVideo: true,
        video: 'majdvalami', ),]
    ),
    Question(
      twoColumn: false,
      text:
          '1.2 Kérdés: Változtatnál valamit a terveden? Növelnéd a gyakoriságot vagy új mozgást hoznál be? Most itt a lehetőség, hogy módosítsd a terved.',
      index: 3,
      requiresTextInput: false,
      requiresTableBigger: true,
      check: true,
      extra: true,
        answers: [],
    ),
    Question(
      twoColumn: false,
      text: 'Kérlek, nézd meg ezt a videót!',
      requiresVideo: true,
      index: 4,
      requiresTextInput: false,
      answers: [
        Answer(
          nextQuestionIndex: 5,
          isVideo: true,
          video: 'majdvalami', ),]
    ),
    Question(
      twoColumn: false,
      text: '1.4 Kérdés: Van valami, amit szívesen megosztanál a programmal kapcsolatban? NE tartsd magadban, írd meg nekünk!',
      index: 5,
      requiresTextInput: true,
      answers: [],
    ),
    Question(
      twoColumn: false,
      text:
          'Köszönjük a kitartó munkádat! Hamarosan újra találkozunk. Addig is, mozgásra fel!',
      index: 6,
      requiresTextInput: false,
      requiresRadioOptions: true, // Enable radio options
      radioOptions: [
        RadioOption(text: 'Mozgásra fel!', nextQuestionIndex: 7),
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
