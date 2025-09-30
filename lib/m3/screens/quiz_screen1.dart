import 'package:bethesda_2/m3/ModuleOpening_M3.dart';
import 'package:bethesda_2/m3/models/questions1.dart';
import 'package:bethesda_2/m3/screens/quiz_screen6.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/quiz_screen3.dart';
import '../screens/quiz_screen1.dart';
import '../screens/quiz_screen2.dart';
import '../screens/quiz_screen3.dart';
import '../screens/quiz_screen4.dart';
import '../screens/quiz_screen5.dart';
import '../screens/quiz_screen6.dart';
import '../screens/quiz_screen7.dart';


import '../providers/quiz_provider2.dart';
import '../providers/quiz_provider3.dart';
import '../providers/quiz_provider4.dart';
import '../providers/quiz_provider5.dart';
import '../providers/quiz_provider6.dart';
import '../providers/quiz_provider7.dart';
import '../ModuleM3_12het.dart';
import '../providers/quiz_provider1.dart';
import 'package:provider/provider.dart';

import 'package:bethesda_2/constants/colors.dart';
import 'package:bethesda_2/constants/styles.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../../constants/meno_gomb.dart';
import '../../appbar/appbar.dart';

class QuizScreen1 extends StatefulWidget {
  static const routeName = '/quiz1';

  const QuizScreen1({super.key});

  @override
  _QuizScreenState1 createState() => _QuizScreenState1();
}

class _QuizScreenState1 extends State<QuizScreen1> {
  late WebSocketChannel _channel = WebSocketChannel.connect(
    Uri.parse('wss://szerver.hasifajdalomkezeles.hu:8089'),
  );


  Map<String, List<String>> answerMap = {};
  void saveAsnwere(Question obj) {
    answerMap.addAll({obj.text.toString().split(':').first: obj.userResponse!});
    print('answerMap $answerMap');
    setState(() {});
  }

  final List<String> _rankableOptions_ = ["1", "2", "3", "4"];
  var icon_most = {
    1: Icons.videocam,
    2: Icons.camera,
    3: Icons.inbox,
    4: Icons.star
  };
  var felirat_most = {
    1: "Kora reggel",
    2: "Délelőtt",
    3: "Kora Délután",
    4: "Délután-este"
  };
  final List<int> _Types = [1, 2, 3, 4];
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _commentController = TextEditingController();
  final List<TextEditingController> _optionControllers = [];
  final List<TextEditingController> _optionControllers2 = [];
  final List<TextEditingController> _optionControllers3 = [];
  List<String> _rankableOptions = [];
  final List<TextEditingController> _prosControllers = [];
  final List<TextEditingController> _consControllers = [];

  List<List<TextEditingController>> matrix = List.generate(4, (_) => List.generate(9, (_) => TextEditingController()));
  final List<TextEditingController> _optionController52 = List.generate(5, (_) => TextEditingController());

  bool _isReordering = false;
  double _sliderValue = 0.0;
  final ScrollController _scrollController = ScrollController();
  int _selectedAnswerIndex = -1;
  bool is_hat_ketto = true;
  Map<String, List<String>> answeerMap = {};

  @override
  void initState() {
    super.initState();
    _loadPreviousAnswers();
  }

  Future<void> _loadPreviousAnswers() async {
    final quizProvider1 = Provider.of<QuizProvider1>(context, listen: false);
    if (quizProvider1.currentQuestion.index > 0) {
      _restorePreviousAnswers(quizProvider1.currentQuestion);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _commentController.dispose();
    for (var controller in _optionControllers) {
      controller.dispose();
    }
    for (var controller in _prosControllers) {
      controller.dispose();
    }
    for (var controller in _consControllers) {
      controller.dispose();
    }
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0.0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  void _sendAnswer(int questionIndex, String answer, String question) {
    String message = 'save|Azonosito;M3;1-2;$questionIndex,$answer';
    _channel.sink.add(message);
  }

  void _handleBackButton(QuizProvider1 quizProvider1) {
    final currentIndex = quizProvider1.currentQuestion.index;

    if (currentIndex == 22 || currentIndex == 23) {
      setState(() => is_hat_ketto = true);
    } else if (currentIndex == 19) {
      setState(() => _isReordering = false);
    }

    quizProvider1.previousQuestion();
    _restorePreviousAnswers(quizProvider1.currentQuestion);
    _scrollToTop();
  }

  void _restorePreviousAnswers(Question question) {
    // Clear all controllers first
    _controller.clear();
    _commentController.clear();
    _optionControllers.clear();
    _optionControllers2.clear();
    _optionControllers3.clear();
    _rankableOptions.clear();
    _selectedAnswerIndex = -1;
    _sliderValue = 0.0;

    if (question.userResponse == null) return;

    // Text input
    if (question.requiresTextInput) {
      _controller.text = question.userResponse!.first;
    }

    // Radio options
    if (question.requiresRadioOptions) {
      final response = question.userResponse!.first;
      final index = question.radioOptions.indexWhere((opt) => opt.text == response);
      if (index != -1) _selectedAnswerIndex = index;

      if (question.allowsComment && question.userResponse!.length > 1) {
        _commentController.text = question.userResponse![1].replaceFirst('comment:', '');
      }
    }

    // Slider
    if (question.answers.any((a) => a.isScale)) {
      _sliderValue = double.tryParse(question.userResponse!.first) ?? 0.0;
    }

    // Two column questions
    if (question.twoColumn) {
      for (var response in question.userResponse!) {
        final parts = response.split(':');
        if (parts.length == 2) {
          _optionControllers2.add(TextEditingController(text: parts[0]));
          _optionControllers3.add(TextEditingController(text: parts[1]));
        }
      }
    }

    // Ranking questions
    if (question.requiresRanking) {
      _rankableOptions = List.from(question.userResponse!);
      _isReordering = true;
    }

    // Table questions
    if (question.requiresTable || question.requiresTableBigger) {
      for (int i = 0; i < question.userResponse!.length; i++) {
        final row = i ~/ 7;
        final col = i % 7;
        if (row < matrix.length && col < matrix[row].length) {
          matrix[row][col].text = question.userResponse![i];
        }
      }
    }
  }

  void saveAnswer(Question obj) {
    try {
      // Initialize userResponse if null
      obj.userResponse ??= [];

      if (obj.requiresTextInput) {
        obj.userResponse = [_controller.text];
      } else if (obj.requiresRadioOptions && _selectedAnswerIndex != -1) {
        obj.userResponse = [
          obj.radioOptions[_selectedAnswerIndex].text,
          if (obj.allowsComment && _commentController.text.isNotEmpty)
            'comment:${_commentController.text}'
        ].where((e) => e != null).cast<String>().toList();
      } else if (obj.answers.any((a) => a.isScale)) {
        obj.userResponse = [_sliderValue.toString()];
      } else if (obj.twoColumn) {
        obj.userResponse = [];
        for (int i = 0; i < _optionControllers2.length; i++) {
          if (_optionControllers2[i].text.isNotEmpty && _optionControllers3[i].text.isNotEmpty) {
            obj.userResponse!.add('${_optionControllers2[i].text}:${_optionControllers3[i].text}');
          }
        }
      } else if (obj.requiresRanking) {
        obj.userResponse = List.from(_rankableOptions);
      } else if (obj.requiresTable || obj.requiresTableBigger) {
        obj.userResponse = [];
        for (var row in matrix) {
          for (var cell in row) {
            if (cell.text.isNotEmpty) {
              obj.userResponse!.add(cell.text);
            }
          }
        }
      }

      if (obj.userResponse!.isNotEmpty) {
        answeerMap[obj.text.toString().split(':').first] = obj.userResponse!;
        print('Answer saved: ${obj.userResponse}');
      }
    } catch (e) {
      print('Error saving answer: $e');
    }
  }


  String selectedActivity0 = "a";


  @override
  Widget build(BuildContext context) {
    final quizProvider1 = Provider.of<QuizProvider1>(context);
    final currentQuestion = quizProvider1.currentQuestion;
    double progressValue = (quizProvider1.currentQuestion.index + 1) / 32;

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Kutatási fázis',
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                Stack(
                  children: [
                    Column(
                      children: [
                        Container(
                          color: AppColors.lightshade,
                          padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.27,
                            right: MediaQuery.of(context).size.width * 0.05,
                          ),
                          child: Column(
                            children: <Widget>[
                              const SizedBox(height: 25.0),
                              Center(
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width * 0.55,
                                      margin: const EdgeInsets.only(top: 20.0),
                                      padding: const EdgeInsets.all(16.0),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                          color: Colors.grey.shade600,
                                          width: 1.5,
                                        ),
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      child: Text(
                                        currentQuestion.text,
                                        style: TextStyle(
                                          fontSize: 24.0,
                                          fontStyle: FontStyle.italic,
                                          color: Colors.grey.shade600,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Positioned(
                                      top: 5,
                                      left: 30,
                                      right: 30,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20.0),
                                          border: Border.all(
                                            color: Colors.grey.shade600,
                                            width: 1.5,
                                          ),
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(18.0),
                                          child: LinearProgressIndicator(
                                            value: progressValue,
                                            backgroundColor: AppColors.whitewhite,
                                            valueColor: const AlwaysStoppedAnimation<Color>(Colors.yellow),
                                            minHeight: 20.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              /*
                              if (currentQuestion.hasInfoButton) ...[
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: MediaQuery.of(context).size.width * 0.06),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        "Nincs ötleted? Szeretnéd, hogy segítsek?",
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.grey.shade600,
                                        ),
                                      ),
                                      const SizedBox(width: 8.0),
                                      Tooltip(
                                        message: "a",//currentQuestion.infoButtonText,
                                        child: const Icon(Icons.info_outline, color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                               */
                              if (currentQuestion.hasInfoButton) ...[
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: MediaQuery.of(context).size.width * 0.06),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        "Nincs ötleted? Szeretnéd, hogy segítsek? Kattints ide:",
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.grey.shade600,
                                        ),
                                      ),
                                      const SizedBox(width: 8.0),
                                      InkWell(
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: const Text('Információ'),
                                                content: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    // Ide tedd a képed widgetjét (pl. Image.asset vagy Image.network)
                                                    Image.asset('assets/images/szofelho.png'),
                                                  ],
                                                ),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context).pop();
                                                    },
                                                    child: const Text('OK'),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                        child: const Icon(Icons.info_outline, color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                              SizedBox(height: MediaQuery.of(context).size.width * 0.03),

                              // Question types handling
                              if (currentQuestion.requiresRanking) _buildRankingQuestion(currentQuestion, quizProvider1),
                              if (currentQuestion.requiresRadioOptions) _buildRadioQuestion(currentQuestion, quizProvider1),
                              if (currentQuestion.twoColumn) _buildTwoColumnQuestion(currentQuestion, quizProvider1),
                              if (currentQuestion.requiresTable) _buildTableQuestion(currentQuestion, quizProvider1),
                              if (currentQuestion.requiresTableBigger) _buildBiggerTableQuestion(currentQuestion, quizProvider1),
                              if (currentQuestion.requiresTextInput) _buildTextInputQuestion(currentQuestion, quizProvider1),
                              if (currentQuestion.answers.any((a) => a.isScale)) _buildScaleQuestion(currentQuestion, quizProvider1),


                              // Video and scale answers
                              ...currentQuestion.answers.map((answer) {
                                if (answer.isVideo) {
                                  return Column(
                                    children: [
                                      Center(
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(20.0),
                                          child: Container(
                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
                                            child: SizedBox(
                                              child: HtmlWidget(
                                                '<video controls controlsList="nodownload" style="border:none; margin:0; padding:0; width:100%; height:100%;" src="${answer.video}"></video>',
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: MediaQuery.of(context).size.width * 0.02),
                                      GradientButton(
                                        text: 'MEGNÉZTEM',
                                        gradient: const LinearGradient(colors: [Colors.yellow, AppColors.yellow]),
                                        onPressed: () async {
                                          _sendAnswer(currentQuestion.index, "Watched Video", currentQuestion.text);
                                          saveAnswer(currentQuestion);
                                          quizProvider1.nextQuestion();
                                          _scrollToTop();
                                          if (quizProvider1.isQuizFinished) {
                                            await quizProvider1.saveUserResponse(answeerMap);
                                            Navigator.of(context).pushReplacement(
                                                MaterialPageRoute(builder: (context) => ModuleOpening_M3('Azonosito',0)));
                                          }
                                        },
                                        showIcon: true,
                                      ),
                                    ],
                                  );
                                }
                                return Container();
                              }).toList(),
                            ],
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.width * 0.5,
                          color: AppColors.lightshade,
                        ),
                      ],
                    ),
                    /*
                    Positioned(
                      top: 0,
                      left: 0,
                      bottom: 0,
                      child: // A build metóduson belül, a sidebar rész módosítása
                      Container(
                        width: MediaQuery.of(context).size.width * 0.25,
                        color: Colors.white.withOpacity(1),
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.width * 0.03,
                            left: MediaQuery.of(context).size.width * 0.04,
                          ),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.3,
                            color: Colors.white.withOpacity(0.3),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                              Text(
                              'Fájdalomkezelési kisokos',
                              textAlign: TextAlign.left,
                              style: MyTextStyles.huszonkettobekezdes(context),
                            ),
                            Container(
                              color: AppColors.lightshade,
                              child: Container(
                                height: MediaQuery.of(context).size.width * 0.03,
                                decoration: const BoxDecoration(
                                  color: AppColors.whitewhite,
                                  borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(20.0),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                color: AppColors.lightshade,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20.0),
                                  bottomLeft: Radius.circular(20.0),
                                ),
                              ),
                              child: ListTile(
                                leading: Image.asset('assets/images/2icon_m.png'),
                                title: Text('Kérdések', style: MyTextStyles.vastagyellow(context)),
                                onTap: () {
                                  // Maradhat üres vagy hozzáadhatsz más logikát
                                },
                              ),
                            ),
                            Container(
                              color: AppColors.lightshade,
                              child: Container(
                                height: MediaQuery.of(context).size.width * 0.02,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20.0),
                                  ),
                              ),
                            ),
                          ),
                          Text(
                            'Anyagok',
                            textAlign: TextAlign.left,
                            style: MyTextStyles.huszonegybekezdes(context),
                          ),
                          Container(
                            color: AppColors.whitewhite,
                            child: Container(
                              height: MediaQuery.of(context).size.width * 0.02,
                              decoration: BoxDecoration(
                                color: AppColors.whitewhite,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20.0),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            decoration: const BoxDecoration(
                              color: AppColors.whitewhite,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20.0),
                                bottomLeft: Radius.circular(20.0),
                              ),
                            ),
                            child: ListTile(
                              leading: Image.asset('assets/images/5icon_m.png'),
                              title: Text('1-2. hét', style: MyTextStyles.vastagbekezdes(context)),
                              subtitle: Text('Zárolva', style: MyTextStyles.kicsibekezdes(context)),
                              onTap: () {
                                // Zárolva, nincs navigáció
                              },
                            ),
                          ),
                          Container(
                            color: AppColors.whitewhite,
                            child: Container(
                              height: MediaQuery.of(context).size.width * 0.02,
                              decoration: BoxDecoration(
                                color: AppColors.whitewhite,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20.0),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            decoration: const BoxDecoration(
                              color: AppColors.whitewhite,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20.0),
                                bottomLeft: Radius.circular(20.0),
                              ),
                            ),
                            child: ListTile(
                              leading: Image.asset('assets/images/4icon_m.png'),
                              title: Text('3. hét', style: MyTextStyles.vastagbekezdes(context)),
                              subtitle: Text('Elérhető', style: MyTextStyles.kicsibekezdes(context)),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => QuizScreen3()),
                                );
                              },
                            ),
                          ),
                          Container(
                            color: AppColors.whitewhite,
                            child: Container(
                              height: MediaQuery.of(context).size.width * 0.02,
                              decoration: BoxDecoration(
                                color: AppColors.whitewhite,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20.0),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            decoration: const BoxDecoration(
                              color: AppColors.whitewhite,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20.0),
                                bottomLeft: Radius.circular(20.0),
                              ),
                            ),
                            child: ListTile(
                              leading: Image.asset('assets/images/6icon_m.png'),
                              title: Text('4. hét', style: MyTextStyles.vastagbekezdes(context)),
                              subtitle: Text('Elérhető', style: MyTextStyles.kicsibekezdes(context)),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => QuizScreen4()),
                                );
                              },
                            ),
                          ),
                          Container(
                            color: AppColors.whitewhite,
                            child: Container(
                              height: MediaQuery.of(context).size.width * 0.02,
                              decoration: BoxDecoration(
                                color: AppColors.whitewhite,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20.0),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            decoration: const BoxDecoration(
                              color: AppColors.whitewhite,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20.0),
                                bottomLeft: Radius.circular(20.0),
                              ),
                            ),
                            child: ListTile(
                              leading: Image.asset('assets/images/3icon_m.png'),
                              title: Text('5. hét', style: MyTextStyles.vastagbekezdes(context)),
                              subtitle: Text('Elérhető', style: MyTextStyles.kicsibekezdes(context)),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => QuizScreen5()),
                                );
                              },
                            ),
                          ),
                          Container(
                            color: AppColors.whitewhite,
                            child: Container(
                              height: MediaQuery.of(context).size.width * 0.02,
                              decoration: const BoxDecoration(
                                color: AppColors.whitewhite,
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(20.0),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            decoration: const BoxDecoration(
                              color: AppColors.whitewhite,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20.0),
                                bottomLeft: Radius.circular(20.0),
                              ),
                            ),
                            child: ListTile(
                              leading: Image.asset('assets/images/7icon_m.png'),
                              title: Text('6. hét', style: MyTextStyles.vastagbekezdes(context)),
                              subtitle: Text('Elérhető', style: MyTextStyles.kicsibekezdes(context)),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => QuizScreen6()),
                                );
                              },
                            ),
                          ),
                          Container(
                            color: AppColors.whitewhite,
                            child: Container(
                              height: MediaQuery.of(context).size.width * 0.02,
                              decoration: const BoxDecoration(
                                color: AppColors.whitewhite,
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(20.0),
                                ),
                              ),
                            ),
                          ),
                          ],
                        ),
                      ),
                    ),
                    ),
                    ),

                     */
                    Positioned(
                      top: 0,
                      left: 0,
                      bottom: 0,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.25,
                        color: Colors.white.withOpacity(1),
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.width * 0.03,
                            left: MediaQuery.of(context).size.width * 0.04,
                          ),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.3,
                            color: Colors.white.withOpacity(0.3),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Fájdalomkezelési kisokos',
                                  textAlign: TextAlign.left,
                                  style: MyTextStyles.huszonkettobekezdes(context),
                                ),
                                Container(
                                  color: AppColors.lightshade,
                                  child: Container(
                                    height: MediaQuery.of(context).size.width * 0.03,
                                    decoration: const BoxDecoration(
                                      color: AppColors.whitewhite,
                                      borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(20.0),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: const BoxDecoration(
                                    color: AppColors.lightshade,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20.0),
                                      bottomLeft: Radius.circular(20.0),
                                    ),
                                  ),
                                  child: ListTile(
                                    leading: Image.asset('assets/images/2icon_m.png'),
                                    title: Text(
                                      'Kérdések',
                                      style: MyTextStyles.vastagyellow(context),
                                    ),
                                    onTap: () async {},
                                  ),
                                ),
                                Container(
                                  color: AppColors.lightshade,
                                  child: Container(
                                    height: MediaQuery.of(context).size.width * 0.02,
                                    decoration: const BoxDecoration(
                                      color: AppColors.whitewhite,
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(20.0),
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  'Anyagok',
                                  textAlign: TextAlign.left,
                                  style: MyTextStyles.huszonegybekezdes(context),
                                ),
                                Container(
                                  color: AppColors.whitewhite,
                                  child: Container(
                                    height: MediaQuery.of(context).size.width * 0.02,
                                    decoration: BoxDecoration(
                                      color: AppColors.whitewhite,
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(20.0),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: const BoxDecoration(
                                    color: AppColors.whitewhite,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20.0),
                                      bottomLeft: Radius.circular(20.0),
                                    ),
                                  ),
                                  child: ListTile(
                                    leading: Image.asset('assets/images/5icon_m.png'),
                                    title: Text(
                                      '1-2. hét',
                                      style: MyTextStyles.vastagbekezdes(context),
                                    ),
                                    subtitle: Text(
                                      'Jelenlegi',
                                      style: MyTextStyles.kicsibekezdes(context),
                                    ),
                                    onTap: () {},
                                  ),
                                ),
                                Container(
                                  color: AppColors.whitewhite,
                                  child: Container(
                                    height: MediaQuery.of(context).size.width * 0.02,
                                    decoration: const BoxDecoration(
                                      color: AppColors.whitewhite,
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(20.0),
                                      ),
                                    ),
                                  ),
                                ),
                                ListTile(
                                  leading: Image.asset('assets/images/4icon_m.png'),
                                  title: Text(
                                    '3. hét',
                                    style: MyTextStyles.vastagbekezdes(context),
                                  ),
                                  subtitle: Text(
                                    'Zárolva',
                                    style: MyTextStyles.kicsibekezdes(context),
                                  ),
                                  onTap: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) => const QuizScreen2(),
                                      ),
                                    );
                                  },
                                ),
                                Container(
                                  color: AppColors.whitewhite,
                                  child: Container(
                                    height: MediaQuery.of(context).size.width * 0.02,
                                    decoration: const BoxDecoration(
                                      color: AppColors.whitewhite,
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(20.0),
                                      ),
                                    ),
                                  ),
                                ),
                                ListTile(
                                  leading: Image.asset('assets/images/6icon_m.png'),
                                  title: Text(
                                    '4. hét',
                                    style: MyTextStyles.vastagbekezdes(context),
                                  ),
                                  subtitle: Text(
                                    'Zárolva',
                                    style: MyTextStyles.kicsibekezdes(context),
                                  ),
                                  onTap: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) => const QuizScreen3(),
                                      ),
                                    );
                                  },
                                ),
                                Container(
                                  color: AppColors.whitewhite,
                                  child: Container(
                                    height: MediaQuery.of(context).size.width * 0.02,
                                    decoration: const BoxDecoration(
                                      color: AppColors.whitewhite,
                                      borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(20.0),
                                      ),
                                    ),
                                  ),
                                ),
                                ListTile(
                                  leading: Image.asset('assets/images/3icon_m.png'),
                                  title: Text(
                                    '5. hét',
                                    style: MyTextStyles.vastagbekezdes(context),
                                  ),
                                  subtitle: Text(
                                    'Zárolva',
                                    style: MyTextStyles.kicsibekezdes(context),
                                  ),
                                  onTap: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) => const QuizScreen4(),
                                      ),
                                    );
                                  },
                                ),
                                Container(
                                  color: AppColors.whitewhite,
                                  child: Container(
                                    height: MediaQuery.of(context).size.width * 0.02,
                                    decoration: const BoxDecoration(
                                      color: AppColors.whitewhite,
                                      borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(20.0),
                                      ),
                                    ),
                                  ),
                                ),
                                ListTile(
                                  leading: Image.asset('assets/images/7icon_m.png'),
                                  title: Text(
                                    '6. hét',
                                    style: MyTextStyles.vastagbekezdes(context),
                                  ),
                                  subtitle: Text(
                                    'Zárolva',
                                    style: MyTextStyles.kicsibekezdes(context),
                                  ),
                                  onTap: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) => const QuizScreen5(),
                                      ),
                                    );
                                  },
                                ),
                                Container(
                                  color: AppColors.whitewhite,
                                  child: Container(
                                    height: MediaQuery.of(context).size.width * 0.02,
                                    decoration: const BoxDecoration(
                                      color: AppColors.whitewhite,
                                      borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(20.0),
                                      ),
                                    ),
                                  ),
                                ),
                                ListTile(
                                  leading: Image.asset('assets/images/7icon_m.png'),
                                  title: Text(
                                    '7-8. hét',
                                    style: MyTextStyles.vastagbekezdes(context),
                                  ),
                                  subtitle: Text(
                                    'Zárolva',
                                    style: MyTextStyles.kicsibekezdes(context),
                                  ),
                                  onTap: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) => const QuizScreen6(),
                                      ),
                                    );
                                  },
                                ),
                                Container(
                                  color: AppColors.whitewhite,
                                  child: Container(
                                    height: MediaQuery.of(context).size.width * 0.02,
                                    decoration: const BoxDecoration(
                                      color: AppColors.whitewhite,
                                      borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(20.0),
                                      ),
                                    ),
                                  ),
                                ),
                                ListTile(
                                  leading: Image.asset('assets/images/7icon_m.png'),
                                  title: Text(
                                    '9-11. hét',
                                    style: MyTextStyles.vastagbekezdes(context),
                                  ),
                                  subtitle: Text(
                                    'Zárolva',
                                    style: MyTextStyles.kicsibekezdes(context),
                                  ),
                                  onTap: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) => const QuizScreen7(),
                                      ),
                                    );
                                  },
                                ),
                                Container(
                                  color: AppColors.lightshade,
                                  child: Container(
                                    height: MediaQuery.of(context).size.width * 0.02,
                                    decoration: const BoxDecoration(
                                      color: AppColors.whitewhite,
                                      borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(20.0),
                                      ),
                                    ),
                                  ),
                                ),
                                ListTile(
                                  leading: Image.asset('assets/images/7icon_m.png'),
                                  title: Text(
                                    '12. hét',
                                    style: MyTextStyles.vastagbekezdes(context),
                                  ),
                                  subtitle: Text(
                                    'Zárolva',
                                    style: MyTextStyles.kicsibekezdes(context),
                                  ),
                                  onTap: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) => const M3_12het(),
                                      ),
                                    );
                                  },
                                ),
                                Container(
                                  color: AppColors.whitewhite,
                                  child: Container(
                                    height: MediaQuery.of(context).size.width * 0.02,
                                    decoration: const BoxDecoration(
                                      color: AppColors.whitewhite,
                                      borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(20.0),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: MediaQuery.of(context).size.width * 0.029,
                      left: 0,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.03,
                        height: MediaQuery.of(context).size.height * 0.05,
                        color: AppColors.yellow,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (quizProvider1.currentQuestion.index > 0)
            Positioned(
              bottom: 20,
              left: MediaQuery.of(context).size.width-100,
              child: FloatingActionButton(
                backgroundColor: Colors.yellow,
                onPressed: () => _handleBackButton(quizProvider1),
                child: const Icon(Icons.arrow_back, color: Colors.black),
              ),
            ),

        ],
      ),
    );
  }

  Widget _buildRankingQuestion(Question currentQuestion, QuizProvider1 quizProvider1) {
    return Column(
      children: [
        if (_optionControllers.isNotEmpty && !_isReordering)
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _optionControllers.length,
              itemBuilder: (context, index) {
                var controller = _optionControllers[index];
                return Padding(
                  key: ValueKey(controller),
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  child: Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: TextField(
                          controller: controller,
                          decoration: InputDecoration(
                            labelText: 'Az ötleted...',
                            labelStyle: TextStyle(color: Colors.grey.shade600),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.green, width: 2.0),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.yellow, width: 2.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey.shade600, width: 2.0),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          style: TextStyle(color: Colors.grey.shade600),
                          maxLines: null,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.grey),
                        onPressed: () {
                          setState(() => _optionControllers.removeAt(index));
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        if (_isReordering)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: (currentQuestion.twoColumn || currentQuestion.index==19) // TODOADI: Ezt tettem be pluszba:  " || currentQuestion.index==19 "
                    ? MediaQuery.of(context).size.width * 0.45
                    : MediaQuery.of(context).size.width * 0.3,
                child: (currentQuestion.twoColumn || currentQuestion.index==19) // TODOADI: Ezt tettem be pluszba:  " || currentQuestion.index==19 "
                    ? Row(
                  children: [
                    Expanded(
                      child: ListView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          for (int index = 0; index < _rankableOptions.length; index++)
                            Padding(
                              key: ValueKey(_rankableOptions[index]),
                              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                              child: Row(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width * 0.2,
                                    decoration: BoxDecoration(
                                      color: AppColors.whitewhite,
                                      border: Border.all(color: Colors.grey.shade600, width: 1.0),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: ListTile(
                                      title: Text(_rankableOptions[index], style: TextStyle(color: Colors.grey.shade600)),
                                      tileColor: Colors.grey.shade100,
                                    ),
                                  ),
                                  SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                                  if (currentQuestion.twoColumn || currentQuestion.index==19) // TODOADI: Ezt tettem be pluszba:  " || currentQuestion.index==19 "
                                    Container(
                                      width: MediaQuery.of(context).size.width * 0.2,
                                      decoration: BoxDecoration(
                                        color: AppColors.whitewhite,
                                        border: Border.all(color: Colors.grey.shade600, width: 1.0),
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                      child: ListTile(
                                        title: TextField(
                                          controller: _optionController52[index],
                                          style: TextStyle(color: Colors.grey.shade600),
                                        ),
                                        tileColor: Colors.grey.shade100,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                )
                    : ReorderableListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  onReorder: (int oldIndex, int newIndex) {
                    setState(() {
                      if (newIndex > oldIndex) newIndex -= 1;
                      final item = _rankableOptions.removeAt(oldIndex);
                      _rankableOptions.insert(newIndex, item);
                    });
                  },
                  children: [
                    for (int index = 0; index < _rankableOptions.length; index++)
                      Padding(
                        key: ValueKey(_rankableOptions[index]),
                        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                        child: Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.2,
                              decoration: BoxDecoration(
                                color: AppColors.whitewhite,
                                border: Border.all(color: Colors.grey.shade600, width: 1.0),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: ListTile(
                                title: Text(_rankableOptions[index], style: TextStyle(color: Colors.grey.shade600)),
                                tileColor: Colors.grey.shade100,
                              ),
                            ),
                            if (currentQuestion.twoColumn || currentQuestion.index==19) // TODOADI: Ezt tettem be pluszba:  " || currentQuestion.index==19 "
                              Container(
                                width: MediaQuery.of(context).size.width * 0.2,
                                decoration: BoxDecoration(
                                  color: AppColors.whitewhite,
                                  border: Border.all(color: Colors.grey.shade600, width: 1.0),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: ListTile(
                                  title: TextField(
                                    style: TextStyle(color: Colors.grey.shade600),
                                  ),
                                  tileColor: Colors.grey.shade100,
                                ),
                              ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        SizedBox(height: MediaQuery.of(context).size.width * 0.02),
        if (_optionControllers.isNotEmpty && _isReordering)
          GradientButton(
            text: 'SZERKESZTÉS',
            gradient: const LinearGradient(colors: [AppColors.whitewhite, Colors.yellow]),
            onPressed: () => setState(() => _isReordering = false),
            showIcon: false,
          ),
        SizedBox(height: MediaQuery.of(context).size.width * 0.02),
        if (_optionControllers.isNotEmpty && _isReordering)
          GradientButton(
            text: 'VÁLASZ MENTÉSE',
            gradient: const LinearGradient(colors: [Colors.yellow, AppColors.yellow]),
            onPressed: () async {
              List<String> values = [];
              List<String> oldValues = _rankableOptions;
              for (int ix = 0; ix < _rankableOptions.length; ix++) {
                if (_optionController52[ix].text.isEmpty && quizProvider1.currentQuestion.index == 19) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Kérlek, válaszolj!')));
                  return;
                } else if (_optionController52[ix].text.isNotEmpty && quizProvider1.currentQuestion.index == 19) {
                  values.add('${oldValues[ix]}%%${_optionController52[ix].text}');
                }
              }

              currentQuestion.userResponse = values;
              saveAnswer(currentQuestion);
              _sendAnswer(quizProvider1.currentQuestion.index, _rankableOptions.join(', '), currentQuestion.text);

              quizProvider1.nextQuestion();
              _scrollToTop();
              if (quizProvider1.isQuizFinished) {
                await quizProvider1.saveUserResponse(answeerMap);
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => ModuleOpening_M3('Azonosito',0)));
              }
            },
            showIcon: true,
          ),
        SizedBox(height: MediaQuery.of(context).size.width * 0.02),
        if (_optionControllers.isEmpty || !_isReordering )
          GradientButton(
            text: 'ÚJ MEGADÁSA', // TALAN ITT A MEGOLDAS
            gradient: const LinearGradient(colors: [AppColors.whitewhite, Colors.yellow]),
            onPressed: () => setState(() => _optionControllers.add(TextEditingController())),
            showIcon: false,
          ),
        SizedBox(height: MediaQuery.of(context).size.width * 0.02),
        if (_optionControllers.isNotEmpty && !_isReordering)
          GradientButton(
            text: 'EDDIGIEK MENTÉSE, SORBARENDEZÉS MEGKEZDÉSE',
            gradient: const LinearGradient(colors: [Colors.yellow, Colors.yellow]),
            onPressed: () {
              setState(() {
                List<String> answers = _optionControllers
                    .map((controller) => controller.text)
                    .where((text) => text.isNotEmpty)
                    .toList();

                if (answers.length >= 5 && answers.toSet().length == answers.length) {
                  currentQuestion.userResponse = answers;
                  saveAnswer(currentQuestion);
                  _rankableOptions = answers;
                  _isReordering = true;
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Kérlek, adj meg legalább 5 különböző választ.')));
                }
              });
            },
            showIcon: false,
          ),
      ],
    );
  }

  Widget _buildRadioQuestion(Question currentQuestion, QuizProvider1 quizProvider1) {
    return Column(
      children: [
        ...currentQuestion.radioOptions.map((radioOption) {
          int index = currentQuestion.radioOptions.indexOf(radioOption);
          bool isSelected = _selectedAnswerIndex == index;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
            child: Theme(
              data: Theme.of(context).copyWith(
                unselectedWidgetColor: Colors.grey,
                radioTheme: RadioThemeData(
                  fillColor: MaterialStateColor.resolveWith(
                          (states) => states.contains(MaterialState.selected)
                          ? AppColors.yellow
                          : Colors.grey
                  ),
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow:
                  [
                    BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4.0,
                    spreadRadius: 1.0,
                    offset: Offset(0, 2),),
                    ],
                  border: Border.all(
                  color: isSelected ? Colors.yellow : Colors.grey,
                  width: 1.5,
                  ),
                ),
                child: RadioListTile(
                  title: Text(radioOption.text),
                  value: index,
                  groupValue: _selectedAnswerIndex,
                  onChanged: (int? value) => setState(() => _selectedAnswerIndex = value!),
                ),
              ),
            ),
          );
        }).toList(),
        if (currentQuestion.allowsComment) ...[
          const SizedBox(height: 20.0),
          Text(
            currentQuestion.commentText,
            style: TextStyle(fontSize: 16.0, color: Colors.grey.shade600),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: TextField(
                controller: _commentController,
                decoration: InputDecoration(
                  labelText: 'Megjegyzés...',
                  labelStyle: const TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(color: Colors.grey.shade600, width: 1.5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(color: Colors.yellow, width: 1.5),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(color: Colors.grey, width: 1.5),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                style: TextStyle(color: Colors.grey.shade600),
                maxLines: null,
              ),
            ),
          ),
        ],
        SizedBox(height: MediaQuery.of(context).size.width * 0.02),
        GradientButton(
          text: 'TOVÁBB',
          gradient: const LinearGradient(colors: [Colors.yellow, AppColors.yellow]),
          onPressed: () async {
            if (_selectedAnswerIndex != -1) {
              _sendAnswer(
                  currentQuestion.index,
                  currentQuestion.radioOptions[_selectedAnswerIndex].text,
                  currentQuestion.text);

              currentQuestion.userResponse = currentQuestion.allowsComment == true
                  ? [
                currentQuestion.radioOptions[_selectedAnswerIndex].text,
                'comment:${_commentController.text}'
              ]
                  : [currentQuestion.radioOptions[_selectedAnswerIndex].text];

              saveAnswer(currentQuestion);
              quizProvider1.answerQuestion(
                  currentQuestion.radioOptions[_selectedAnswerIndex].nextQuestionIndex);
              _scrollToTop();

              if (quizProvider1.isQuizFinished) {
                await quizProvider1.saveUserResponse(answeerMap);
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => ModuleOpening_M3('Azonosito',0)));
              }
            }
          },
          showIcon: true,
        ),
      ],
    );
  }

  /*
  Widget _buildTwoColumnQuestion(Question currentQuestion, QuizProvider1 quizProvider1) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05),
                  child: Text(
                    currentQuestion.prosText,
                    style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.grey.shade600),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.05),
                  child: Text(
                    currentQuestion.consText,
                    style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.grey.shade600),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: MediaQuery.of(context).size.width * 0.02),
        Column(
          children: [
            is_hat_ketto
                ? SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _optionControllers2.length,
                itemBuilder: (context, index) {
                  var controller = _optionControllers2[index];
                  var controller2 = _optionControllers3[index];
                  return Padding(
                    key: ValueKey(controller),
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.01),
                            child: TextField(
                              controller: controller,
                              decoration: InputDecoration(
                                labelText: 'nehézség...',
                                labelStyle: TextStyle(color: Colors.grey.shade600),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(color: Colors.grey.shade600, width: 1.5),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: const BorderSide(color: Colors.yellow, width: 1.5),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: const BorderSide(color: Colors.grey, width: 1.5),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              style: TextStyle(color: Colors.grey.shade800),
                              maxLines: null,
                            ),
                          ),
                        ),
                        SizedBox(width: MediaQuery.of(context).size.width * 0.1),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.01),
                            child: TextField(
                              controller: controller2,
                              decoration: InputDecoration(
                                labelText: 'előny...',
                                labelStyle: TextStyle(color: Colors.grey.shade600),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(color: Colors.grey.shade600, width: 1.5),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: const BorderSide(color: Colors.yellow, width: 1.5),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: const BorderSide(color: Colors.grey, width: 1.5),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              style: TextStyle(color: Colors.grey.shade800),
                              maxLines: null,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            )
                : SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _optionControllers2.length,
                itemBuilder: (context, index) {
                  var text2 = _optionControllers2[index].text;
                  var text3 = _optionControllers3[index].text;
                  return Padding(
                    key: ValueKey(text2),
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.01),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade600, width: 2.0),
                                borderRadius: BorderRadius.circular(8.0),
                                color: Colors.white,
                              ),
                              padding: const EdgeInsets.all(8.0),
                              child: Text(text2, style: TextStyle(color: Colors.grey.shade800)),
                            ),
                          ),
                        ),
                        SizedBox(width: MediaQuery.of(context).size.width * 0.1),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.01),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade600, width: 2.0),
                                borderRadius: BorderRadius.circular(8.0),
                                color: Colors.white,
                              ),
                              padding: const EdgeInsets.all(8.0),
                              child: Text(text3, style: TextStyle(color: Colors.grey.shade800)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            ...currentQuestion.answers.map((answer) {
              if (answer.isFillable) {
                return Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.width * 0.02),
                    GradientButton(
                      text: 'ÚJ MEGADÁSA',
                      gradient: const LinearGradient(colors: [AppColors.whitewhite, Colors.yellow]),
                      onPressed: () {
                        setState(() {
                          _optionControllers2.add(TextEditingController());
                          _optionControllers3.add(TextEditingController());
                        });
                      },
                      showIcon: false,
                    ),
                    SizedBox(height: MediaQuery.of(context).size.width * 0.02),
                  ],
                );
              } else {
                return Container();
              }
            }).toList(),
            if (is_hat_ketto)
              GradientButton(
                text: 'TOVÁBB',
                gradient: const LinearGradient(colors: [Colors.yellow, AppColors.yellow]),
                onPressed: () async {
                  if (_optionControllers2.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Adj meg legalább egy választ!')));
                    return;
                  }

                  List<String> combinedAnswers = [];
                  for (int i = 0; i < _optionControllers2.length; i++) {
                    if (_optionControllers2[i].text.isEmpty || _optionControllers3[i].text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Kérlek, válaszolj!')));
                      return;
                    }
                    combinedAnswers.add('${_optionControllers2[i].text}:${_optionControllers3[i].text}');
                  }

                  setState(() => is_hat_ketto = false);
                  currentQuestion.userResponse = combinedAnswers;
                  saveAnswer(currentQuestion);
                  _sendAnswer(currentQuestion.index, combinedAnswers.join(','), currentQuestion.text);

                  quizProvider1.nextQuestion();
                  _scrollToTop();
                  if (quizProvider1.isQuizFinished) {
                    await quizProvider1.saveUserResponse(answeerMap);
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => ModuleOpening_M3('Azonosito',0)));
                  }
                  _controller.clear();
                },
                showIcon: true,
              ),
          ],
        ),
        SizedBox(height: MediaQuery.of(context).size.width * 0.02),
      ],
    );
  }

   */
  Widget _buildTwoColumnQuestion(Question currentQuestion, QuizProvider1 quizProvider1) {
    // Ellenőrizzük, hogy van-e columnHeaders, különben prosText/consText használata
    final String prosHeader = currentQuestion.columnHeaders.isNotEmpty
        ? currentQuestion.columnHeaders[0]
        : (currentQuestion.prosText.isNotEmpty ? currentQuestion.prosText : 'Oszlop 1');
    final String consHeader = currentQuestion.columnHeaders.isNotEmpty
        ? currentQuestion.columnHeaders[1]
        : (currentQuestion.consText.isNotEmpty ? currentQuestion.consText : 'Oszlop 2');
    final bool isFirstColumnEditable = currentQuestion.isColumnFillable.isNotEmpty
        ? currentQuestion.isColumnFillable[0]
        : true;
    final bool isSecondColumnEditable = currentQuestion.isColumnFillable.isNotEmpty
        ? currentQuestion.isColumnFillable[1]
        : true;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05),
                  child: Text(
                    prosHeader,
                    style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.grey.shade600),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.05),
                  child: Text(
                    consHeader,
                    style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.grey.shade600),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: MediaQuery.of(context).size.width * 0.02),
        Column(
          children: [
            if (is_hat_ketto)
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _optionControllers2.length,
                  itemBuilder: (context, index) {
                    var controller = _optionControllers2[index];
                    var controller2 = _optionControllers3[index];
                    return Padding(
                      key: ValueKey(controller),
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.01),
                              child: isFirstColumnEditable
                                  ? TextField(
                                controller: controller,
                                decoration: InputDecoration(
                                  labelText: prosHeader,
                                  labelStyle: TextStyle(color: Colors.grey.shade600),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide(color: Colors.grey.shade600, width: 1.5),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: const BorderSide(color: Colors.yellow, width: 1.5),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: const BorderSide(color: Colors.grey, width: 1.5),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                                style: TextStyle(color: Colors.grey.shade800),
                                maxLines: null,
                              )
                                  : Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey.shade600, width: 2.0),
                                  borderRadius: BorderRadius.circular(8.0),
                                  color: Colors.white,
                                ),
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  controller.text.isNotEmpty ? controller.text : currentQuestion.rankableOptions[index],
                                  style: TextStyle(color: Colors.grey.shade800),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: MediaQuery.of(context).size.width * 0.1),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.01),
                              child: isSecondColumnEditable
                                  ? TextField(
                                controller: controller2,
                                decoration: InputDecoration(
                                  labelText: consHeader,
                                  labelStyle: TextStyle(color: Colors.grey.shade600),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide(color: Colors.grey.shade600, width: 1.5),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: const BorderSide(color: Colors.yellow, width: 1.5),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: const BorderSide(color: Colors.grey, width: 1.5),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                                style: TextStyle(color: Colors.grey.shade800),
                                maxLines: null,
                              )
                                  : Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey.shade600, width: 2.0),
                                  borderRadius: BorderRadius.circular(8.0),
                                  color: Colors.white,
                                ),
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  controller2.text,
                                  style: TextStyle(color: Colors.grey.shade800),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              )
            else
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _optionControllers2.length,
                  itemBuilder: (context, index) {
                    var text2 = _optionControllers2[index].text;
                    var text3 = _optionControllers3[index].text;
                    return Padding(
                      key: ValueKey(text2),
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.01),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey.shade600, width: 2.0),
                                  borderRadius: BorderRadius.circular(8.0),
                                  color: Colors.white,
                                ),
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  text2.isNotEmpty ? text2 : currentQuestion.rankableOptions[index],
                                  style: TextStyle(color: Colors.grey.shade800),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: MediaQuery.of(context).size.width * 0.1),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.01),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey.shade600, width: 2.0),
                                  borderRadius: BorderRadius.circular(8.0),
                                  color: Colors.white,
                                ),
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  text3,
                                  style: TextStyle(color: Colors.grey.shade800),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ...currentQuestion.answers.map((answer) {
              if (answer.isFillable) {
                return Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.width * 0.02),
                    GradientButton(
                      text: 'ÚJ MEGADÁSA',
                      gradient: const LinearGradient(colors: [AppColors.whitewhite, Colors.yellow]),
                      onPressed: () {
                        setState(() {
                          _optionControllers2.add(TextEditingController());
                          _optionControllers3.add(TextEditingController());
                        });
                      },
                      showIcon: false,
                    ),
                    SizedBox(height: MediaQuery.of(context).size.width * 0.02),
                  ],
                );
              } else {
                return Container();
              }
            }).toList(),
            if (is_hat_ketto)
              GradientButton(
                text: 'TOVÁBB',
                gradient: const LinearGradient(colors: [Colors.yellow, AppColors.yellow]),
                onPressed: () async {
                  if (_optionControllers2.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Adj meg legalább egy választ!'),
                    ));
                    return;
                  }

                  List<String> combinedAnswers = [];
                  for (int i = 0; i < _optionControllers2.length; i++) {
                    if (_optionControllers2[i].text.isEmpty || _optionControllers3[i].text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Kérlek, válaszolj!'),
                      ));
                      return;
                    }
                    String answerRow = '${_optionControllers2[i].text}:${_optionControllers3[i].text}';
                    combinedAnswers.add(answerRow);
                  }
                  setState(() {
                    is_hat_ketto = false;
                  });
                  String finalAnswer = combinedAnswers.join(',');
                  currentQuestion.userResponse = combinedAnswers;
                  saveAsnwere(currentQuestion);
                  _sendAnswer(currentQuestion.index, finalAnswer, currentQuestion.text);
                  quizProvider1.nextQuestion();
                  _scrollToTop();
                  if (quizProvider1.isQuizFinished) {
                    bool saved = await quizProvider1.saveUserResponse(answerMap);
                    if (saved) {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => ModuleOpening_M3('Azonosito', 0)),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Hiba történt a válaszok mentése közben!')),
                      );
                    }
                  }
                  _controller.clear();
                },
                showIcon: true,
              ),
          ],
        ),
        SizedBox(height: MediaQuery.of(context).size.width * 0.02),
      ],
    );
  }


  Widget _buildTableQuestion(Question currentQuestion, QuizProvider1 quizProvider1) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.85,
          height: MediaQuery.of(context).size.width * 0.30,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey.shade600, width: 1.0),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey.shade600, width: 1.0),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.1,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey.shade600, width: 1.0),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: ListTile(
                          title: Text("idősáv", style: TextStyle(color: Colors.grey.shade800)),
                          tileColor: Colors.grey.shade100,
                        ),
                      ),
                      for (int i = 1; i <= 7; i++)
                        Container(
                          width: MediaQuery.of(context).size.width * 0.05,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey.shade600, width: 1.0),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: ListTile(
                            title: Text("$i.nap", style: TextStyle(color: Colors.grey.shade800)),
                            tileColor: Colors.grey.shade100,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              for (int index = 0; index < _rankableOptions_.length; index++)
                Padding(
                  key: ValueKey(_rankableOptions_[index]),
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey.shade600, width: 1.0),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.1,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey.shade600, width: 1.0),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: ListTile(
                            title: Text(felirat_most[_Types[index]]!, style: TextStyle(color: Colors.grey.shade800)),
                            tileColor: Colors.grey.shade100,
                          ),
                        ),
                        for (int i = 0; i < 7; i++)
                          Builder(builder: (context) {
                            var myController = matrix[index][i];
                            return Container(
                              width: MediaQuery.of(context).size.width * 0.05,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.grey.shade600, width: 1.0),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: ListTile(
                                title: TextField(
                                  controller: myController,
                                  style: TextStyle(color: Colors.grey.shade800),
                                ),
                                tileColor: Colors.grey.shade100,
                              ),
                            );
                          }),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.width * 0.02),
        GradientButton(
          text: 'TOVÁBB',
          gradient: const LinearGradient(colors: [Colors.yellow, AppColors.yellow]),
          onPressed: () async {
            bool hasValue = false;
            List<String> enterValues = [];
            for (int index = 0; index < _rankableOptions_.length; index++) {
              for (int i = 0; i < 7; i++) {
                enterValues.add(matrix[index][i].text);
                if (matrix[index][i].text.isNotEmpty) hasValue = true;
              }
            }

            if (hasValue) {
              _sendAnswer(currentQuestion.index, _controller.text, currentQuestion.text);
              currentQuestion.userResponse = enterValues;
              saveAnswer(currentQuestion);
              quizProvider1.nextQuestion();
              _scrollToTop();
            }

            if (quizProvider1.isQuizFinished) {
              await quizProvider1.saveUserResponse(answeerMap);
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => ModuleOpening_M3('Azonosito',0)));
            }
          },
          showIcon: true,
        ),
      ],
    );
  }

  Widget _buildBiggerTableQuestion(Question currentQuestion, QuizProvider1 quizProvider1) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.85,
          height: MediaQuery.of(context).size.width * 0.30,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey.shade600, width: 1.0),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey.shade600, width: 1.0),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.1,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey.shade600, width: 1.0),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: ListTile(
                          title: Text("idősáv", style: TextStyle(color: Colors.grey.shade800)),
                          tileColor: Colors.grey.shade100,
                        ),
                      ),
                      for (int i = 1; i <= 7; i++)
                        Container(
                          width: MediaQuery.of(context).size.width * 0.05,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey.shade600, width: 1.0),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: ListTile(
                            title: Text("$i.nap", style: TextStyle(color: Colors.grey.shade800)),
                            tileColor: Colors.grey.shade100,
                          ),
                        ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.1,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey.shade600, width: 1.0),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: ListTile(
                          title: Text("Magabiztossági szint", style: TextStyle(color: Colors.grey.shade800)),
                          tileColor: Colors.grey.shade100,
                        ),
                      ),
                      currentQuestion.check == true
                          ? Container(
                        width: MediaQuery.of(context).size.width * 0.1,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey.shade600, width: 1.0),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: ListTile(
                          title: Text("Segítők – hogyan?", style: TextStyle(color: Colors.grey.shade800)),
                          tileColor: Colors.grey.shade100,
                        ),
                      )
                          : const SizedBox.shrink()
                    ],
                  ),
                ),
              ),
              for (int index = 0; index < _rankableOptions_.length; index++)
                Padding(
                  key: ValueKey(_rankableOptions_[index]),
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey.shade600, width: 1.0),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Builder(builder: (context) {
                      int myIndex = currentQuestion.check == true ? 9 : 8;
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.1,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.grey.shade600, width: 1.0),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: ListTile(
                              title: Text(felirat_most[_Types[index]]!, style: TextStyle(color: Colors.grey.shade800)),
                              tileColor: Colors.grey.shade100,
                            ),
                          ),
                          for (int i = 0; i < myIndex; i++)
                            Builder(builder: (context) {
                              var myController = matrix[index][i];
                              return Container(
                                width: (i < 7)
                                    ? MediaQuery.of(context).size.width * 0.05
                                    : MediaQuery.of(context).size.width * 0.1,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.grey.shade600, width: 1.0),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: ListTile(
                                  title: (i < 7)
                                      ? SizedBox(child: Center(child: Text(myController.text)))
                                      : (i < myIndex - 1)
                                      ? SizedBox(child: Center(child: Text(myController.text)))
                                      : TextField(
                                    decoration: const InputDecoration(),
                                    controller: myController,
                                    readOnly: (i < 7) ? true : (i < myIndex - 1) ? true : false,
                                    style: TextStyle(color: Colors.grey.shade800),
                                  ),
                                  tileColor: Colors.grey.shade100,
                                ),
                              );
                            }),
                        ],
                      );
                    }),
                  ),
                ),
            ],
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.width * 0.02),
        GradientButton(
          text: 'TOVÁBB',
          gradient: const LinearGradient(colors: [Colors.yellow, AppColors.yellow]),
          onPressed: () async {
            int myIndex = currentQuestion.check == true ? 9 : 8;
            List<String> enterValues = [];
            for (int index = 0; index < _rankableOptions_.length; index++) {
              for (int i = 0; i < myIndex; i++) {
                enterValues.add(matrix[index][i].text);
              }
            }

            currentQuestion.userResponse = enterValues;
            saveAnswer(currentQuestion);
            _sendAnswer(currentQuestion.index, _controller.text, currentQuestion.text);
            quizProvider1.nextQuestion();
            _scrollToTop();

            if (quizProvider1.isQuizFinished) {
              await quizProvider1.saveUserResponse(answeerMap);
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => ModuleOpening_M3('Azonosito',0)));
            }
          },
          showIcon: true,
        ),
      ],
    );
  }



  Widget _buildScaleQuestion(Question currentQuestion, QuizProvider1 quizProvider1) {
    // Get the answer from question 27 if current question is index 33
    String? answerFromQuestion27;
    if (currentQuestion.index == 33) {
      final question27 = quizProvider1.questions[27];
      if (question27.userResponse != null && question27.userResponse!.isNotEmpty) {
        answerFromQuestion27 = question27.userResponse!.first;
      }
    }

    return Column(
      children: [
        // Display the answer from question 27 if available and we're on question 33
        if (currentQuestion.index == 33 && answerFromQuestion27 != null) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.grey.shade300),
              ),
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'A tervezett mozgásod: $answerFromQuestion27',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey.shade800,
                ),
              ),
            ),
          ),
          SizedBox(height: 16),
        ],

        // Slider widget
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
          child: Slider(
            value: _sliderValue,
            min: 0.0,
            max: 10.0,
            divisions: 10,
            label: _sliderValue.round().toString(),
            activeColor: AppColors.yellow,
            inactiveColor: Colors.grey.shade300,
            onChanged: (double value) {
              setState(() {
                _sliderValue = value;
              });
            },
          ),
        ),

        // Slider labels
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Tuti nem', style: TextStyle(color: Colors.grey.shade600)),
              Text('100%', style: TextStyle(color: Colors.grey.shade600)),
            ],
          ),
        ),

        // Next button
        SizedBox(height: MediaQuery.of(context).size.width * 0.02),
        GradientButton(
          text: 'TOVÁBB',
          gradient: const LinearGradient(colors: [Colors.yellow, AppColors.yellow]),
          onPressed: () async {
            _sendAnswer(currentQuestion.index, _sliderValue.toString(), currentQuestion.text);
            currentQuestion.userResponse = [_sliderValue.toString()];
            saveAnswer(currentQuestion);
            quizProvider1.nextQuestion();
            _scrollToTop();
            if (quizProvider1.isQuizFinished) {
              await quizProvider1.saveUserResponse(answeerMap);
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => ModuleOpening_M3('Azonosito',0)));
            }
          },
          showIcon: true,
        ),
      ],
    );
  }
/*
  Widget _buildScaleQuestion(Question currentQuestion, QuizProvider1 quizProvider1) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
          child: Slider(
            value: _sliderValue,
            min: 0.0,
            max: 10.0, // Példa: 0-10 skála a motivációhoz
            divisions: 10,
            label: _sliderValue.round().toString(),
            activeColor: AppColors.yellow,
            inactiveColor: Colors.grey.shade300,
            onChanged: (double value) {
              setState(() {
                _sliderValue = value;
              });
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Tuti nem', style: TextStyle(color: Colors.grey.shade600)),
              Text('100%', style: TextStyle(color: Colors.grey.shade600)),
            ],
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.width * 0.02),
        GradientButton(
          text: 'TOVÁBB',
          gradient: const LinearGradient(colors: [Colors.yellow, AppColors.yellow]),
          onPressed: () async {
            _sendAnswer(currentQuestion.index, _sliderValue.toString(), currentQuestion.text);
            currentQuestion.userResponse = [_sliderValue.toString()];
            saveAnswer(currentQuestion);
            quizProvider1.nextQuestion();
            _scrollToTop();
            if (quizProvider1.isQuizFinished) {
              bool saved = await quizProvider1.saveUserResponse(answerMap);
              if (saved) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => ModuleOpening_M3('Azonosito', 0)),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Hiba történt a válaszok mentése közben!')),
                );
              }
            }
          },
          showIcon: true,
        ),
      ],
    );
  }
 */




  Widget _buildTextInputQuestion(Question currentQuestion, QuizProvider1 quizProvider1) {
    bool isQuestion24 = currentQuestion.index == 24;
    List<String>? previousActivities = [];
    String? selectedActivity;

    if (isQuestion24) {
      final question18 = quizProvider1.questions[18];
      if (question18.userResponse != null && question18.userResponse!.isNotEmpty) {
        previousActivities = question18.userResponse;
      }
    }

    return Column(
      children: [
        if (isQuestion24 && previousActivities!.isNotEmpty) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.grey.shade300, width: 1.0),
              ),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Korábban megadott mozgásos céljaid - válassz egyet:',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  ...previousActivities!.map((activity) {
                    bool isSelected = selectedActivity == activity;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedActivity = activity;
                          _controller.text = activity;
                          selectedActivity0 = activity;
                        });
                      },
                      child: Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(bottom: 8.0),
                        padding: const EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          color: isSelected ? AppColors.yellow.withOpacity(0.2) : Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(
                            color: isSelected ? AppColors.yellow : Colors.grey.shade300,
                            width: isSelected ? 2.0 : 1.0,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              isSelected ? Icons.check_circle : Icons.radio_button_unchecked,
                              color: isSelected ? AppColors.yellow : Colors.grey.shade400,
                            ),
                            const SizedBox(width: 12.0),
                            Expanded(
                              child: Text(
                                activity,
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.grey.shade800,
                                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16.0),

          // Vagy saját válasz opció
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedActivity = null;
                  _controller.clear();
                  selectedActivity0 = "SAJAT";
                });
              },
              child: Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: selectedActivity == null ? AppColors.yellow.withOpacity(0.2) : Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                    color: selectedActivity == null ? AppColors.yellow : Colors.grey.shade300,
                    width: selectedActivity == null ? 2.0 : 1.0,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      selectedActivity == null ? Icons.check_circle : Icons.radio_button_unchecked,
                      color: selectedActivity == null ? AppColors.yellow : Colors.grey.shade400,
                    ),
                    const SizedBox(width: 12.0),
                    Text(
                      'Más mozgást szeretnék választani',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey.shade800,
                        fontWeight: selectedActivity == null ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16.0),
        ],

        const SizedBox(height: 16.0),
        (currentQuestion.index == 28)?
        Text(
          "Az általad választott mozgás: " +selectedActivity0,
          style: TextStyle(
            fontSize: 14.0,
            color: Colors.grey.shade800,
          ),
        ):SizedBox(),

        (currentQuestion.index == 27)?
        Text(
          "Az általad választott mozgás: " +selectedActivity0,
          style: TextStyle(
            fontSize: 14.0,
            color: Colors.grey.shade800,
          ),
        ):SizedBox(),
        const SizedBox(height: 16.0),
        const SizedBox(height: 16.0),


        // Szöveges válasz mező (csak akkor látható, ha nincs kiválasztva korábbi válasz vagy ha "Más" opció van kiválasztva)
        if (!isQuestion24 || selectedActivity == null) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  labelText: isQuestion24
                      ? 'Írd be a választott mozgást...'
                      : 'A válaszod...',
                  labelStyle: TextStyle(color: Colors.grey.shade600),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(color: Colors.grey.shade600, width: 1.5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(color: Colors.yellow, width: 1.5),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(color: Colors.grey, width: 1.5),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                style: TextStyle(color: Colors.grey.shade600),
                maxLines: null,
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.width * 0.02),
        ],


        GradientButton(
          text: 'TOVÁBB',
          gradient: const LinearGradient(colors: [Colors.yellow, AppColors.yellow]),
          onPressed: () async {
            String answer = selectedActivity ?? _controller.text;

            if (answer.isNotEmpty) {
              _sendAnswer(currentQuestion.index, answer, currentQuestion.text);
              quizProvider1.nextQuestion();
              currentQuestion.userResponse = [answer];
              saveAnswer(currentQuestion);
              _scrollToTop();

              if (quizProvider1.isQuizFinished) {
                await quizProvider1.saveUserResponse(answeerMap);
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => ModuleOpening_M3('Azonosito',0)));
              }
              _controller.clear();
              setState(() {
                selectedActivity = null;
              });
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Kérlek, válassz vagy írj be egy választ!')));
            }
          },
          showIcon: true,
        ),
      ],
    );
  }



}