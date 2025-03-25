import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/hipnom3_questions1.dart';
//1-2het
class QuizProvider1 with ChangeNotifier {
  final List<Question> questions = [
    Question(
      text: 'Kérlek, nézd meg ezt a videót!',
      index: 0,
      requiresTextInput: false,
      twoColumn: false,
      answers: [
        Answer(
          nextQuestionIndex: 1,
          isVideo: true,
          video: 'http://pigssh.ddns.net:8080/assets/assets/Video_1_1.mp4',
        ), // Provide the video URL here
      ],
    ),
    Question(
      twoColumn: false,
      text:
          '1: Mindenkinek más jut először az eszébe a saját fájdalmáról. Van aki úgy érzi, hogy a fájdalom megfosztja a jó dolgoktól, de van olyan is, aki ugyan úgy éli az életét a fájdalom ellenére, mint azelőtt. Te mit gondolsz a saját fájdalmadról? Írj le bármit, ami eszedbe jut!',
      index: 1,
      requiresTextInput: true,
      answers: [],
    ),
    Question(
      twoColumn: false,
      text: 'Most kérlek, nézd meg ezt a videót!',
      index: 2,
      requiresTextInput: false,
      answers: [
        Answer(
          nextQuestionIndex: 3,
          isVideo: true,
          video: 'http://pigssh.ddns.net:8080/assets/assets/Video_1_2.mp4',
        ), // Provide the video URL here
      ],
    ),
    Question(
      twoColumn: false,
      text:
          '2: Te is észrevetted már, hogy sok mindentől függ az, mikor és mennyire jelentkezik a fájdalmad? Kérlek, írj pár összefüggést, amit megfigyeltél eddig!',
      index: 3,
      requiresTextInput: true,
      answers: [],
    ),
    Question(
      twoColumn: false,
      text: 'Most kérlek, nézd meg ezt a videót!',
      index: 4,
      requiresTextInput: false,
      answers: [
        Answer(
          nextQuestionIndex: 5,
          isVideo: true,
          video: 'http://pigssh.ddns.net:8080/assets/assets/Video_1_3_4.mp4',
        ), // Provide the video URL here
      ],
    ),
    Question(
      twoColumn: false,
      text:
          '3.1: Most hogy elkezdünk közösen dolgozni, mennyire érzed motiváltnak magad a mozgásra? Állítsd be a csúszkán a motivációd szintjét! ',
      index: 5,
      answers: [
        Answer(nextQuestionIndex: 6, isScale: true),
      ],
    ),
    Question(
      twoColumn: false,
      text: '3.2: Mit jelent számodra a mozgás?',
      index: 6,
      requiresTextInput: true,
      answers: [],
    ),
    Question(
      twoColumn: false,
      text:
          '3.3: Szoktál rendszeresen mozogni? (A tesi óra most nem számít… 😊)',
      index: 7,
      requiresVideo: false,
      requiresRadioOptions: true, // Enable radio options
      radioOptions: [
        RadioOption(text: 'nem mozgok semmit', nextQuestionIndex: 9),
        RadioOption(
            text: 'néha-néha mozgok (havi 1-2 alkalommal)',
            nextQuestionIndex: 8),
        RadioOption(
            text: 'hetente szoktam mozogni (legalább heti 1 x 1-1,5 órát)',
            nextQuestionIndex: 8),
        RadioOption(
            text: 'rendszeresen szoktam mozogni (legalább heti 2x 1-1,5 órát)',
            nextQuestionIndex: 8),
        RadioOption(
            text: 'élsportoló vagyok (heti több edzés, hétvégén versenyek)',
            nextQuestionIndex: 8),
      ],
      answers: [], // No direct answers for radio options
    ),
    Question(
      twoColumn: false,
      text:
          '3.3.1: Mit szoktál mozogni? Ha több féle mozgást végzel, kérlek, írd oda, milyen rendszerességgel és mennyi ideig végzed az adott mozgást!',
      index: 8,
      requiresTextInput: true,
      answers: [],
    ),
    Question(
      twoColumn: false,
      text:
          '3.4: Részt veszel a testnevelés órákon, vagy felmentésed van?',
      index: 9,
      requiresRadioOptions: true,
      radioOptions: [
        RadioOption(text: 'Részt veszek', nextQuestionIndex: 10),
        RadioOption(text: 'Felmentésem van', nextQuestionIndex: 10),
      ],
      allowsComment: true, // Enable comment option
      commentText:
          'Ha van valamilyen megjegyzésed ezzel kapcsolatban, ide írhatod:', // Prompt text for the comment
      answers: [],
    ),
    Question(
      twoColumn: false,
      text:
          '3.5: Volt-e olyan az elmúlt pár hétben, hogy elkezdtél mozogni és az beindította vagy felerősítette a fájdalmadat?',
      index: 10,
      requiresRadioOptions: true, // Enable radio options
      radioOptions: [
        RadioOption(text: 'igen', nextQuestionIndex: 11),
        RadioOption(text: 'nem', nextQuestionIndex: 12),
      ],
      answers: [],
    ),
    Question(
      twoColumn: false,
      text:
          '3.5.1: Hogyan történt ez? Kivel voltál és mik voltak a körülmények? Kérlek, írd le olyan részletesen, ahogy tudod!',
      index: 11,
      requiresTextInput: true,
      answers: [],
    ),
    Question(
      twoColumn: false,
      text:
          '3.6: Volt-e olyan az elmúlt pár hétben, hogy elkezdtél mozogni és az enyhítette, vagy elmulasztotta a fájdalmadat?',
      index: 12,
      requiresRadioOptions: true, // Enable radio options
      radioOptions: [
        RadioOption(text: 'igen', nextQuestionIndex: 13),
        RadioOption(text: 'nem', nextQuestionIndex: 14),
      ],
      answers: [],
    ),
    Question(
      twoColumn: false,
      text:
          '3.6.1: Hogyan történt ez? Kivel voltál és mik voltak a körülmények? Kérlek, írd le olyan részletesen, ahogy tudod!',
      index: 13,
      requiresTextInput: true,
      answers: [],
    ),
    Question(
      twoColumn: false,
      text: 'Most kérlek, nézd meg ezt a videót!',
      index: 14,
      requiresTextInput: false,
      answers: [
        Answer(
          nextQuestionIndex: 15,
          isVideo: true,
          video: 'http://pigssh.ddns.net:8080/assets/assets/Video_1_5.mp4',
        ), // Provide the video URL here
      ],
    ),
    Question(
      twoColumn: false,
      text:
          '4.1: Előfordult olyan, hogy annak ellenére is mozogtál, aktív voltál, hogy fájdalmad volt közben?',
      index: 15,
      requiresRadioOptions: true, // Enable radio options
      radioOptions: [
        RadioOption(text: 'igen', nextQuestionIndex: 16),
        RadioOption(text: 'nem', nextQuestionIndex: 17),
      ],
      answers: [],
    ),
    Question(
      twoColumn: false,
      text:
          '4.1.1: Hogyan történt ez? Milyen mozgás, aktivitás volt az? Kivel voltál és mik voltak a körülmények? Kérlek, írd le olyan részletesen, ahogy tudod!',
      index: 16,
      requiresTextInput: true,
      answers: [],
    ),
    Question(
      twoColumn: false,
      text: 'Most kérlek, nézd meg ezt a videót!',
      index: 17,
      requiresTextInput: false,
      answers: [
        Answer(
          nextQuestionIndex: 18,
          isVideo: true,
          video: 'http://pigssh.ddns.net:8080/assets/assets/Video_1_6.mp4',
        ), // Provide the video URL here
      ],
    ),
    Question(
      twoColumn: false,
      text:
          '5.1: Kérlek, írj legalább 5 olyan mozgást, sportot vagy aktív tevékenységet, amit szívesen csinálnál, vagy akár régebben csináltad és most újrakezdenéd! Először jöjjenek az ötletek, aztán utána rendezd őket sorrendbe! Az első legyen az, amit most a legszívesebben csinálnál, kipróbálnál és így tovább.',
      index: 18,
      requiresRanking: true,
      hasInfoButton: true,
      infoButtonText:
          'Itt egy lista arról, hogy milyen mozgásokat végeznek szívesen a kortársaid (ide akár betehetnénk erről egy hivatkozást is, ha megjelenik a cikk)',
      answers: [
        Answer(nextQuestionIndex: 19, isRankable: true),
      ],
      rankableOptions: [],
    ),
    Question(
      text:
          '5.2: Most hogy rangsoroltad, hogy milyen mozgást csinálnál szívesen, kérlek, gondolkozz el azon, hogy milyen céljaid vannak az egyes mozgásokkal, amiket felsoroltál! Például: séta – heti 3x 30 perc azért, hogy kimozduljak otthonról, vagy otthoni torna – heti 2x 45 perc azért, mert szeretnék megerősödni',
      index: 19,
      requiresRanking: true,
      twoColumn: true,
      answers: [
        Answer(nextQuestionIndex: 20, isRankable: false),
      ],
      rankableOptions: [
        'Activity 1',
        'Activity 2',
        'Activity 3',
        'Activity 4',
      ],
      columnHeaders: ['Mozgás', 'Cél'],
      isColumnFillable: [
        false,
        true
      ], // First column is not fillable, second is fillable
    ),
    Question(
      twoColumn: false,
      text: 'Most kérlek, nézd meg ezt a videót!',
      index: 20,
      requiresTextInput: false,
      answers: [
        Answer(
          nextQuestionIndex: 21,
          isVideo: true,
          video: 'http://pigssh.ddns.net:8080/assets/assets/Video_1_7.mp4',
        ), // Provide the video URL here
      ],
    ),
    Question(
      twoColumn: true, // Enable two-column input
      text:
          '6.1: Jelenleg mi okoz számodra nehézséget abban, hogy többet mozogj? Gondold végig és írd le, mik azok, amik miatt mégis megéri Neked mozogni!',
      hasInfoButton: true,
      infoButtonText:
          'Itt egy lista arról, hogy milyen nehézségekbe ütköznek a kortársaid és egy lista arról, hogy miért éri meg mégis a számukra a mozgás (ide akár betehetnénk erről egy hivatkozást is, ha megjelenik a cikk)',
      index: 22,
      requiresTextInput: false,
      columnHeaders: ['Nehézségek', 'Előnyök, amiért megéri'],
      isColumnFillable: [true, true], // Firs
      answers: [
        Answer(
          nextQuestionIndex: 23,
          isFillable: true,
        ),
      ],
      twoColumnEntries: [
        TwoColumnEntry(
            pros: 'Nehézségek',
            cons: 'Előnyök, amiért megéri',
            isFillable: true), // Example entries
      ],
      prosText: 'Nehézségek', // Custom text for pros
      consText: 'Előnyök, amiért megéri', // Custom text for cons
    ),
    
    Question(
      twoColumn: true, // Enable two-column input
      text:
          '6.2: Nézz rá kérlek, a hátrányok-előnyök táblázatra! Látsz olyan elemeket, amik összefüggenek? Látsz-e olyan elemeket az előnyök oszlopban, amik megoldást kínálnak egy általad megnevezett nehézségre? \n Pl.: nehézség: fáradt vagyok elkezdeni a mozgást - előny: a mozgás energiával tölt fel. Itt láthatod, hogy a mozgás megadja azt, ami miatt nehéz belekezdeni. Minél többet mozogsz, annál kevésbé leszel fáradt belekezdeni és annál inkább többet fogsz mozogni. Ez egy önmagát erősítő kör. Keress hasonlókat, és írd le őket!',
      index: 23,
      requiresTextInput: true,
      answers: [
        Answer(
          nextQuestionIndex: 24,
          isFillable: false,
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
          '7.1: Az előbb megnevezett legalább 5 mozgásos cél közül mi lesz az, amit az elkövetkező 2 hétben elkezdesz megvalósítani?',
      index: 24,
      requiresTextInput: true,
      answers: [],
    ),
    Question(
      twoColumn: false,
      text: 'Most kérlek, nézd meg ezt a videót!',
      index: 25,
      requiresTextInput: false,
      answers: [
        Answer(
          nextQuestionIndex: 26,
          isVideo: true,
          video: 'http://pigssh.ddns.net:8080/assets/assets/Video_1_8_1.mp4',
        ), // Provide the video URL here
      ],
    ),
    Question(
      twoColumn: false,
      text:
          '7.2: A következő oldalon látható táblázatban összeállíthatod a mozgástervedet a következő 2 hétre.',
      index: 26,
      requiresTextInput: false,
      requiresRadioOptions: true,
      radioOptions: [
        RadioOption(text: 'Lássuk!!', nextQuestionIndex: 27),
      ],
      answers: [],
    ),

    Question(
      twoColumn: false,
      text:
          '7.3: Írd be, a most kiválasztott mozgást ahhoz a naphoz és napszakhoz, amikor szerinted a leginkább valószínű, hogy meg is csinálod',
      index: 27,
      requiresTextInput: false,
      requiresTable: true,
      answers: [
        Answer(
          nextQuestionIndex: 28,
        ),
      ],
    ),
    Question(
      twoColumn: false,
      text:
          '7.4: Mennyire vagy biztos abban, hogy meg is fogod csinálni? Ezt a számot írd az adott sor végéhez! Az 1-es a Tuti nem, a 10-es a 100%, hogy megcsinálom.',
      index: 28,
      requiresTextInput: false,
      requiresTableBigger: true,
      answers: [
        Answer(
          nextQuestionIndex: 29,
        ),
      ],
    ),
    Question(
      twoColumn: false,
      text: 'Most kérlek, nézd meg ezt a videót!',
      index: 29,
      requiresTextInput: false,
      answers: [
        Answer(
          nextQuestionIndex: 30,
          isVideo: true,
          video:
              'http://pigssh.ddns.net:8080/assets/assets/Video_1_8_2_segítő.mp4',
        ), // Provide the video URL here
      ],
    ),
    Question(
      twoColumn: false,
      text:
          '7.2.1: Írd be, hogy ki és hogyan tudna Neked segíteni, hogy biztosan megvalósuljon a terved!',
      index: 30,
      requiresTextInput: false,
      requiresTableBigger: true,
      check: true,
      answers: [
        Answer(
          nextQuestionIndex: 31,
        ),
      ],
    ),
    
    Question(
      twoColumn: false,
      text: 'Most kérlek, nézd meg ezt a videót!',
      index: 31,
      requiresTextInput: false,
      answers: [
        Answer(
          nextQuestionIndex: 32,
          isVideo: true,
          video:
              'http://pigssh.ddns.net:8080/assets/assets/Video_1_9_zárás.mp4',
        ), // Provide the video URL here
      ],
    ),
    
    
    Question(
      twoColumn: false,
      text:
          '8: Most hogy segítettem ezt végiggondolni veled, mennyire érzed motiváltnak magad a mozgásra? Állítsd be a csúszkán a motivációd szintjét!',
      index: 32,
      answers: [
        Answer(nextQuestionIndex: 33, isScale: true),
      ],
    ),
  
  ];

  int _currentQuestionIndex = 0;
  int _score = 0;

  Question get currentQuestion => questions[_currentQuestionIndex];

  bool get isQuizFinished => _currentQuestionIndex >= questions.length;

  int get score => _score;

  void answerQuestion(int nextQuestionIndex) {
    if (nextQuestionIndex <= questions.length) {
      _currentQuestionIndex = nextQuestionIndex;
    } else {
      _currentQuestionIndex = questions.length + 1; // Mark as finished
    }
    // print(
    //     'here is new index $_currentQuestionIndex   $nextQuestionIndex    ${_questions.length}       ${_currentQuestionIndex == _questions.length}');
    _score++;
    notifyListeners();
  }

  void nextQuestion() {
    if (_currentQuestionIndex < questions.length - 1) {
      _currentQuestionIndex++;
    } else {
      _currentQuestionIndex = questions.length; // Mark as finished
    }
    notifyListeners();
  }

  void resetQuiz() {
    _currentQuestionIndex = 0;
    _score = 0;
    notifyListeners();
  }

  void updateRankableOptions(List<String> options) {
    questions[_currentQuestionIndex].rankableOptions = options;
    notifyListeners();
  }

  List<String> getAnswersForQuestion(int questionIndex) {
    return questions[questionIndex]
        .answers
        .map((answer) => answer.text)
        .toList();
  }
  saveUserResponse(
Map<String,List<String>> answeerMap)async{
    try{
       final SharedPreferences  prefs = await SharedPreferences.getInstance();
    String jsonString = json.encode(answeerMap.map(
      (key, list) => MapEntry(key, list.map((item) => item.toString()).toList()),
    ));
    await prefs.setString('user_response', jsonString);
    }catch(e){
      print('Here we got exception in save data $e');
    }}
}
