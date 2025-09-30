import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import '../models/questions1.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

// 5.hét
class QuizProvider4 with ChangeNotifier {
  List<String> previousAnswers = [];

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
          video: 'https://storage.googleapis.com/lomeeibucket/o%CC%88to%CC%88dik_he%CC%81t_1_uj.mp4',
        ),
      ],
    ),
    Question(
      text: 'Mi volt az elmúlt pár heted legnagyobb sikere mozgás szempontjából? Mit sikerült megvalósítani a tervedből?',
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
            video: 'https://storage.googleapis.com/lomeeibucket/o%CC%88to%CC%88dik_he%CC%81t_2_uj.mp4',
          ),
        ]
    ),
    Question(
      twoColumn: false,
      text: 'Változtatnál valamit a terveden? Növelnéd a gyakoriságot vagy új mozgást hoznál be? Most itt a lehetőség, hogy módosítsd a terved.',
      index: 3,
      requiresTextInput: false,
      requiresTableBigger: true,
      check: true,
      extra: true,
      answers: [],
      // Hozzáadjuk a "Semmin sem változtatnék" opciót
      nooption: true,
      steptoquestion: 4, // Ugrás a következő kérdésre (index 4)
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
            video: 'https://storage.googleapis.com/lomeeibucket/o%CC%88to%CC%88dik_he%CC%81t_3_uj.mp4',
          ),
        ]
    ),
    Question(
      twoColumn: false,
      text: 'Van valami, amit szívesen megosztanál a programmal kapcsolatban? NE tartsd magadban, írd meg nekünk!',
      index: 5,
      requiresTextInput: true,
      answers: [],
    ),
    Question(
      twoColumn: false,
      text: 'Köszönjük a kitartó munkádat! Hamarosan újra találkozunk. Addig is, mozgásra fel!',
      index: 6,
      requiresTextInput: false,
      requiresRadioOptions: true,
      radioOptions: [
        RadioOption(text: 'Mozgásra fel!', nextQuestionIndex: 7),
      ],
      answers: [],
    ),
    Question(
      twoColumn: false,
      text: 'Ez a kérdőív véget ért. \n \n Köszönjük a válaszaidat!',
      index: 7,
      answers: [],
    ),
  ];

  int _currentQuestionIndex = 0;
  int _score = 0;

  // History for back navigation
  List<int> _navigationHistory = [];

  Question get currentQuestion {
    if (_currentQuestionIndex < 0 || _currentQuestionIndex >= _questions.length) {
      return _questions.isNotEmpty
          ? _questions.last
          : Question(
        text: "A kérdőív véget ért",
        index: -1,
        requiresTextInput: false,
        answers: [],
        twoColumn: false,
      );
    }
    return _questions[_currentQuestionIndex];
  }

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
      // Kérdőív vége kezelése - állítsuk be az utolsó kérdésre
      _currentQuestionIndex = _questions.length - 1;
      notifyListeners();
    }
  }

  void nextQuestion() {
    // Save current index to history before navigating
    if (_currentQuestionIndex < _questions.length) {
      _navigationHistory.add(_currentQuestionIndex);
    }

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
    _navigationHistory.clear();
    notifyListeners();
  }

  void updateRankableOptions(List<String> options) {
    if (_currentQuestionIndex >= 0 && _currentQuestionIndex < _questions.length) {
      _questions[_currentQuestionIndex].rankableOptions = options;
      notifyListeners();
    }
  }

  List<String> getAnswersForQuestion(int questionIndex) {
    if (questionIndex >= 0 && questionIndex < _questions.length) {
      return _questions[questionIndex]
          .answers
          .map((answer) => answer.text)
          .toList();
    }
    return [];
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