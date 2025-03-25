import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import '../models/questions1.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

// 3.hét
class QuizProvider2 with ChangeNotifier {
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
      text: '1. kérdés: Hogy haladsz a programoddal?',
      index: 1,
      requiresTextInput: false,
      requiresRadioOptions: true,
      // Enable radio options
      radioOptions: [
        RadioOption(text: 'Elkezdtem megvalósítani', nextQuestionIndex: 6),
        RadioOption(text: 'Még nem kezdtem bele', nextQuestionIndex: 2),
      ],
      answers: [],
      // No direct answers for radio options
      twoColumn: false,
    ),
    Question(
      twoColumn: true,
      text:
          '1.1. kérdés:  Ha még nem kezdtél bele a megvalósításba, semmi gond. Nézzük meg, hogy mi is zajlik most Benned a változással kapcsolatban. \nTöltsd ki kérlek az alábbi táblázatot. A bal oldali oszlopba írd be, hogy milyen előnyökkel jár a számodra, hogy minden úgy maradjon ahogy most. A jobb oldali táblába pedig írd be kérlek, hogy milyen hátrányai vannak annak, ha minden úgy marad, ahogy most.',
      index: 2,
      requiresTextInput: false,
      //columnHeaders: ['Azért jó nekem, hogy ha minden úgy marad ahogy most, mert:', 'Azért lenne rossz, ha minden úgy maradna, ahogy most, mert:'],
      //isColumnFillable: [true, true], // Firs
      answers: [
        Answer(
          nextQuestionIndex: 3,
          isFillable: true,
        ),
      ],
      twoColumnEntries: [
        TwoColumnEntry(
          pros: 'Azért jó nekem, hogy ha minden úgy marad ahogy most, mert:',
          cons: 'Azért lenne rossz, ha minden úgy maradna, ahogy most, mert:',
          isFillable: true,
        ), // Example entries
      ],
      prosText: 'Azért jó nekem, hogy ha minden úgy marad ahogy most, mert:',
      // Custom text for pros
      consText:
          'Azért lenne rossz, ha minden úgy maradna, ahogy most, mert:', // Custom text for cons
    ),
    Question(
      twoColumn: true,
      text:
          '1.2 Kérdés: Köszönöm, a válaszaidat. Most nézzük meg, a korábban kitöltött táblázatodat arról, hogy miért is érné meg neked elkezdeni mozogni. \nEsetleg írnál új példákat? Jutott eszedbe még valami más? Nyugodtan írd hozzá',
      index: 3,
      requiresTextInput: false,
      oldanswers: true,
      answers: [
        Answer(
          nextQuestionIndex: 4,
          isFillable: true,
        ),
      ],
      readonlyTwoColumnEntries: [
        TwoColumnEntry(
            pros: '', cons: '', isFillable: false), // Example entries
      ],
    ),
    Question(
      twoColumn: false,
      text:
          '1.3 Kérdés: Mi az, ami miatt most, ebben a pillanatban úgy érzed, hogy megéri elkezdeni megvalósítani a tervedet? Válaszd ki a táblázatból!',
      index: 4,
      requiresTextInput: false,
      oldanswers: true,
      choose: true,
      answers: [
      ],

    ),
    Question(
      twoColumn: false,
      text: '1.4 Kérdés: Mi segíthet abban, hogy belevágj?',
      hasInfoButton: true,
      steptoquestion: 8,
      infoButtonText: 'Ide jönnek tippek',
      index: 5,
      requiresTextInput: true,
      answers: [],
    ),
    Question(
      twoColumn: false,
      text:
          'Remek, hogy nekiálltál! A kezedbe vetted az irányítást és az eltökéltséged miatt képes vagy változtatni! \nKérlek írd le, hogy mi motivált téged a leginkább abban, hogy elkezd?',
      index: 6,
      requiresTextInput: true,
      answers: [],
    ),
    Question(
      twoColumn: false,
      text:
          '1.2.2 Kérdés: Milyen sikerélményeid voltak a mozgás kapcsán? Kérlek írd le pár mondatban.',
      index: 7,
      requiresTextInput: true,
      answers: [],
    ),
    Question(
      twoColumn: false,
      text: 'Most kérlek, nézd meg ezt a videót',
      index: 8,
      answers: [
        Answer(
          nextQuestionIndex: 9,
          isVideo: true,
          video: 'majdvalami3',
        ),
      ],
    ),
    Question(
      twoColumn: false,
      text:
          '2.: Te melyik típus vagy inkább, a kitartás miatt elkerülő vagy a félelem miatti elkerülő?',
      index: 9,
      requiresRadioOptions: true,
      radioOptions: [
        RadioOption(text: 'Félelem miatti elkerülő', nextQuestionIndex: 10),
        RadioOption(text: 'Kitartás miatti elkerülő', nextQuestionIndex: 10),
        RadioOption(text: 'Vagy valami más? Írd le:', nextQuestionIndex: 10),
      ],
      allowsComment: true,
      // Enable comment option
      commentText: 'Ha valami más, ide írhatod:',
      // Prompt text for the comment
      answers: [],
    ),
    Question(
      twoColumn: false,
      text:
          '2.1: Írj kérlek példákat, hogy mikor kerülted el a mozgást az elmúlt héten!',
      index: 10,
      requiresTextInput: true,
      answers: [],
    ),
    Question(
      twoColumn: false,
      text: 'Most kérlek, nézd meg ezt a videót',
      index: 11,
      answers: [
        Answer(
          nextQuestionIndex: 12,
          isVideo: true,
          video: 'majdvalami3',
        ),
      ],
    ),
    Question(
      twoColumn: false,
      text: '3.1 Kérdés: Te hogy alkalmaznád az ütemezést? Tervezd meg!',
      index: 12,
      requiresTableBigger: true,
      requiresTextInput: false,
      check: true,
      extra: true,
      answers: [],
    ),
    Question(
      twoColumn: false,
      text: 'Most kérlek, nézd meg ezt a videót',
      index: 13,
      answers: [
        Answer(
          nextQuestionIndex: 14,
          isVideo: true,
          video: 'majdvalami4',
        ),
      ],
    ),
    Question(
      twoColumn: false,
      text:
          '4.1 Kérdés: Te milyen akadályokat látsz magad előtt? Mi hátráltat a célod megvalósításában?',
      index: 14,
      rankableOptions: [],
      requiresTextInput: false,
      requiresRanking: true,
      answers: [
        Answer(nextQuestionIndex: 15, isRankable: true),
      ],
    ),
    Question(
      twoColumn: false,
      text: 'Most kérlek, nézd meg ezt a videót',
      index: 15,
      answers: [
        Answer(
          nextQuestionIndex: 16,
          isVideo: true,
          video: 'majdvalami4',
        ),
      ],
    ),
    Question(
      text:
          '5.1 Kérdés: Kérlek írd a felsorolt nehézségek mellé, hogy hogyan fogod megoldani őket, ha szembetalálod velük magad a következő hetek folyamán!',
      index: 16,
      requiresRanking: true,
      twoColumn: true,
      answers: [
        Answer(nextQuestionIndex: 17, isRankable: false),
      ],
      rankableOptions: [
        'Activity 1',
        'Activity 2',
        'Activity 3',
        'Activity 4',
      ],
      columnHeaders: ['Nehézség', 'Megoldás'],
      isColumnFillable: [
        false,
        true
      ], // First column is not fillable, second is fillable
    ),
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
