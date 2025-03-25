import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../hipnom3_34_ModuleOpening_M3.dart';
import '../hipnom3_12_ModuleHipno.dart';
import '../hipnom3_56_ModuleHipno_page2.dart';
import '../hipnom3_78_ModuleM3_4het.dart';
import '../hipnom3_910_ModuleHipno_page3.dart';
import '../models/hipnom3_questions1.dart';
import '../providers/hipnom3_3_4_quiz_provider1.dart';
import '../providers/hipnom3_7_quiz_provider2.dart';
import '../providers/hipnom3_8_quiz_provider3.dart';
import '../providers/hipnom3_11_quiz_provider4.dart';
import '../providers/hipnom3_12_quiz_provider5.dart';
import '../screens/hipnom3_1_2_quiz_screen1.dart';
import '../screens/hipnom3_7_quiz_screen2.dart';
import '../screens/hipnom3_8_quiz_screen3.dart';
import '../screens/hipnom3_11_quiz_screen4.dart';
import '../screens/hipnom3_12_quiz_screen5.dart';
import '../screens/hipnom3_result_screen1.dart';
import '../screens/hipnom3_show_response.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

// import '../models/questions1.dart';
import 'package:bethesda_2/constants/colors.dart';
import 'package:bethesda_2/constants/styles.dart';
// import '../ModuleOpening_M3.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../../constants/meno_gomb.dart';
import '../../appbar/appbar.dart';

class QuizScreen3 extends StatefulWidget {
  static const routeName = '/quiz3';

  const QuizScreen3({super.key});

  @override
  _QuizScreenState3 createState() => _QuizScreenState3();
}

class _QuizScreenState3 extends State<QuizScreen3> {
  final List<String> _rankableOptions_ = ["1", "2", "3", "4"];
  // Other instance variables and controllers...

  // Define the color state lists as instance variables
  List<Color> colorStates1 = [];
  List<Color> colorStates2 = [];
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
  List<List<TextEditingController>> matrix = [
    [
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
    ],
    [
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
    ],
    [
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
    ],
    [
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
    ],
  ];
  final List<TextEditingController> _optionController52 = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];
  bool _isReordering = false;
  double _sliderValue = 0.0;
  final ScrollController _scrollController = ScrollController();
  int _selectedAnswerIndex = -1;
  bool is_hat_ketto = true;
  bool _isSecondColumnVisible = false;

  List<String> _secondColumnTexts = [];

  // WebSocketChannel? _channel;

  @override
  void initState() {
    super.initState();
    colorStates1 = List<Color>.filled(_optionControllers2.length, Colors.white,
        growable: true);
    colorStates2 = List<Color>.filled(_optionControllers3.length, Colors.white,
        growable: true);

    // _channel = WebSocketChannel.connect(
    //   // Uri.parse('wss://34.72.67.6:8089'),
    //   Uri.parse('wss://146.148.43.137:8089'),
    // );

    // _channel?.stream.listen((message) {
    //   print('Received message: $message');
    // });
  }

  Map<String, List<String>> answeerMap = {};
  saveAsnwere(Question obj) {
    answeerMap
        .addAll({obj.text.toString().split(':').first: obj.userResponse!});
    print('ans map $answeerMap');
    setState(() {});
  }

  void _sendAnswer(int questionIndex, String answer, String quetion) {
    String message = 'save|Azonosito;M3;1-2;$questionIndex,$answer';
    // _channel?.sink.add(message);
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
    // _channel?.sink.close();
    super.dispose();
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0.0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  // Future<List<String>> getAnswersForQuestionIndex(int questionIndex, List<Question> questionList) async {
  //   try {
  //     final SharedPreferences prefs = await SharedPreferences.getInstance();
  //     String? jsonString = prefs.getString('user_response');
  //
  //     if (jsonString != null) {
  //       Map<String, dynamic> decodedMap = json.decode(jsonString);
  //       answeerMap = decodedMap.map(
  //             (key, value) => MapEntry(
  //           key,
  //           List<String>.from(value.map((item) => item as String)),
  //         ),
  //       );
  //
  //       // Get the key for the question at the specified index (e.g., 22)
  //       String questionKey = questionList[questionIndex].text.toString().split(':').first;
  //
  //       // Return the answers corresponding to the key
  //       return answeerMap[questionKey] ?? [];
  //     }
  //   } catch (e) {
  //     print('Error fetching answers: $e');
  //   }
  //
  //   // Return an empty list if something goes wrong
  //   return [];
  // }
  Widget _buildNoOption(Question question) {
    // Use a null check for 'nooption'
    if (!(question.nooption ?? false)) {
      return Container(); // Return an empty container if 'nooption' is not true or is null
    }

    // Return only the 'Tovább' button if 'nooption' is true
    return Align(
      alignment: Alignment.center,
      child: GradientButton(
        text: 'TOVÁBB',
        gradient: const LinearGradient(
          colors: [Colors.yellow, AppColors.yellow],
        ),
        onPressed: () {
          // Navigate directly to the next question index specified in the question
          _navigateToNextQuestion(question.steptoquestion);
        },
        showIcon: true,
      ),
    );
  }

// Ensure to define this method in your class
  void _navigateToNextQuestion(int nextQuestionIndex) {
    final quizProvider = Provider.of<QuizProvider3>(context, listen: false);

    // Assuming you have a method like answerQuestion or goToQuestion
    quizProvider.answerQuestion(nextQuestionIndex); // Or any other relevant method

    // Additional navigation logic if needed
    // For example, you could navigate to a new screen or update the state
  }

//


  Widget _buildCheckBoxOptions(Question question) {
    if (!question.requiresCheckOptions || question.checkOptions.isEmpty) {
      return Container(); // Return an empty container if no checkbox options are required
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...question.checkOptions.map((option) {
          return GestureDetector(
            onTap: () {
              setState(() {
                if (question.userResponse == null) {
                  question.userResponse = [];
                }
                if (question.userResponse!.contains(option.text)) {
                  question.userResponse!.remove(option.text);
                } else {
                  question.userResponse!.add(option.text);
                }
              });
            },
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(
                  color: question.userResponse != null && question.userResponse!.contains(option.text)
                      ? AppColors.yellow
                      : Colors.grey,
                  width: 2.0,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Icon(
                    question.userResponse != null && question.userResponse!.contains(option.text)
                        ? Icons.check_box
                        : Icons.check_box_outline_blank,
                    color: AppColors.yellow,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      option.text,
                      style: MyTextStyles.bekezdes(context),
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),

        // Add a custom GradientButton below the checkbox options
        SizedBox(height: 16.0), // Space between checkboxes and button
        Align(
          alignment: Alignment.center,
          child: GradientButton(
            text: 'TOVÁBB',
            gradient: const LinearGradient(
              colors: [Colors.yellow, AppColors.yellow],
            ),
            onPressed: () async {
              if (question.userResponse == null || question.userResponse!.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Kérlek, válassz legalább egy lehetőséget!')),
                );
              } else {
                // Send the selected answer and navigate to the next question
                _sendAnswer(
                  question.index,
                  question.userResponse!.join(", "), // Convert selected options to a single string
                  question.text,
                );
                print('Save answer ${question.userResponse}');
                saveAsnwere(question);

                // Fetch quizProvider instance correctly here
                final quizProvider = Provider.of<QuizProvider3>(context, listen: false);

                int nextQuestionIndex = question.checkOptions
                    .firstWhere((option) => question.userResponse!.contains(option.text))
                    .nextQuestionIndex;

                quizProvider.answerQuestion(nextQuestionIndex);
                _scrollToTop(); // Scroll back to top after navigating

                if (quizProvider.isQuizFinished) {
                  await quizProvider.saveUserResponse(answeerMap);
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => hipnom3_ModuleOpening_M3('Azonosito',0),
                    ),
                  );
                }
              }
            },
            showIcon: true,
          ),
        ),
      ],
    );
  }
// Method to scroll back to top of the screen

  @override
  Widget build(BuildContext context) {
    final quizProvider = Provider.of<QuizProvider3>(context, listen: true);

    final currentQuestion = quizProvider.currentQuestion;
    double progressValue = (quizProvider.currentQuestion.index + 1) / 5;

    return Scaffold(
      appBar: CustomAppBar(title: 'Kutatási fázis'),
      body: SingleChildScrollView(
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
                                  width:
                                      MediaQuery.of(context).size.width * 0.55,
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
                                        valueColor:
                                            const AlwaysStoppedAnimation<Color>(
                                          Colors.yellow,
                                        ),
                                        minHeight: 20.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (currentQuestion.hasInfoButton) ...[
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width * 0.06),
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
                                    message: currentQuestion.infoButtonText,
                                    child: const Icon(
                                      Icons.info_outline,
                                      color: Colors.grey, // Custom color (blue)
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                          SizedBox(
                              height: MediaQuery.of(context).size.width * 0.03),
                          if (currentQuestion.nooption ?? false)
                            _buildNoOption(currentQuestion),
                          if (currentQuestion.requiresRanking) ...[
                            Column(
                              children: [
                                // For Question 4.1 (index == 14)
                                if (quizProvider.currentQuestion.index ==
                                    14) ...[
                                  if (_optionControllers.isNotEmpty)
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: _optionControllers.length,
                                        itemBuilder: (context, index) {
                                          var controller =
                                              _optionControllers[index];
                                          return Padding(
                                            key: ValueKey(controller),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0, vertical: 4.0),
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.4,
                                                  child: TextField(
                                                    controller: controller,
                                                    decoration: InputDecoration(
                                                      labelText:
                                                          'Az ötleted...',
                                                      labelStyle: TextStyle(
                                                          color: Colors
                                                              .grey.shade600),
                                                      border:
                                                          const OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors.green,
                                                            width: 2.0),
                                                      ),
                                                      focusedBorder:
                                                          const OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                Colors.yellow,
                                                            width: 2.0),
                                                      ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors
                                                                .grey.shade600,
                                                            width: 2.0),
                                                      ),
                                                      filled: true,
                                                      fillColor: Colors.white,
                                                    ),
                                                    style: TextStyle(
                                                        color: Colors
                                                            .grey.shade600),
                                                    maxLines: null,
                                                  ),
                                                ),
                                                IconButton(
                                                  icon: const Icon(Icons.delete,
                                                      color: Colors.grey),
                                                  onPressed: () {
                                                    setState(() {
                                                      _optionControllers
                                                          .removeAt(index);
                                                    });
                                                  },
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.02),
                                  GradientButton(
                                    text: 'ÚJ MEGADÁSA',
                                    gradient: const LinearGradient(colors: [
                                      AppColors.whitewhite,
                                      Colors.yellow,
                                    ]),
                                    onPressed: () {
                                      setState(() {
                                        _optionControllers
                                            .add(TextEditingController());
                                      });
                                    },
                                    showIcon: false,
                                  ),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.02),
                                  GradientButton(
                                    text: 'VÁLASZ MENTÉSE',
                                    gradient: const LinearGradient(colors: [
                                      Colors.yellow,
                                      AppColors.yellow,
                                    ]),
                                    onPressed: () async {
                                      List<String> values = [];
                                      for (var controller
                                          in _optionControllers) {
                                        if (controller.text.isNotEmpty) {
                                          values.add(controller.text);
                                        }
                                      }
                                      if (values.isEmpty) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              content:
                                                  Text('Kérlek, válaszolj!')),
                                        );
                                        return;
                                      }
                                      currentQuestion.userResponse =
                                          values; // Save the answers to the current question
                                      quizProvider.savePreviousAnswers(
                                          values); // Save to provider
                                      saveAsnwere(currentQuestion);
                                      quizProvider.nextQuestion();
                                      _scrollToTop();
                                    },
                                    showIcon: true,
                                  ),
                                ],

                                // For Question 5.1 (index == 16)
                                if (quizProvider.currentQuestion.index ==
                                    16) ...[
                                  if (quizProvider.previousAnswers.isNotEmpty)
                                    ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount:
                                          quizProvider.previousAnswers.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0, vertical: 4.0),
                                          child: Row(
                                            children: [
                                              // Display previous answer
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.35, // Narrower width
                                                decoration: BoxDecoration(
                                                  color: Colors
                                                      .white, // Background color set to white
                                                  border: Border.all(
                                                    color: Colors.grey.shade600,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                                child: ListTile(
                                                  title: Text(
                                                    quizProvider
                                                        .previousAnswers[index],
                                                    style: TextStyle(
                                                        color: Colors
                                                            .grey.shade600),
                                                  ),
                                                  tileColor: Colors
                                                      .white, // Ensure tile background is white
                                                ),
                                              ),
                                              SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.01), // Narrower spacing
                                              // Input field for user response to the displayed answer
                                              Expanded(
                                                child: TextField(
                                                  controller:
                                                      _optionController52[
                                                          index],
                                                  decoration: InputDecoration(
                                                    hintText: 'A megoldás...',
                                                    filled: true,
                                                    fillColor: Colors
                                                        .white, // Background color set to white
                                                    border: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.yellow,
                                                          width:
                                                              1.5), // Yellow outline
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                    ),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.yellow,
                                                          width:
                                                              1.5), // Yellow outline
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.yellow,
                                                          width:
                                                              2.0), // Yellow outline
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                    ),
                                                  ),
                                                  style: TextStyle(
                                                      color:
                                                          Colors.grey.shade600),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.02),
                                  GradientButton(
                                    text: 'VÁLASZ MENTÉSE',
                                    gradient: const LinearGradient(colors: [
                                      Colors.yellow,
                                      AppColors.yellow,
                                    ]),
                                    onPressed: () async {
                                      if (quizProvider.previousAnswers.isEmpty)
                                        return; // Early return if empty

                                      List<String> values = [];
                                      for (int i = 0;
                                          i <
                                              quizProvider
                                                  .previousAnswers.length;
                                          i++) {
                                        if (_optionController52[i]
                                            .text
                                            .isEmpty) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                                content: Text(
                                                    'Kérlek, töltsd ki az összes mezőt!')),
                                          );
                                          return;
                                        }
                                        values.add(
                                            '${quizProvider.previousAnswers[i]}%%${_optionController52[i].text}');
                                      }
                                      currentQuestion.userResponse = values;
                                      saveAsnwere(currentQuestion);
                                      quizProvider.nextQuestion();
                                      _scrollToTop();
                                    },
                                    showIcon: true,
                                  ),
                                ],
                              ],
                            ),
                          ] else if (currentQuestion.requiresRadioOptions) ...[
                            Column(
                              children: [
                                ...currentQuestion.radioOptions
                                    .map((radioOption) {
                                  int index = currentQuestion.radioOptions
                                      .indexOf(radioOption);
                                  bool isSelected =
                                      _selectedAnswerIndex == index;
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 24.0, vertical: 8.0),
                                    child: Theme(
                                      data: Theme.of(context).copyWith(
                                        unselectedWidgetColor: Colors.grey,
                                        radioTheme: RadioThemeData(
                                          fillColor:
                                              MaterialStateColor.resolveWith(
                                                  (states) => states.contains(
                                                          MaterialState
                                                              .selected)
                                                      ? AppColors.yellow
                                                      : Colors.grey),
                                        ),
                                      ),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Colors.black12,
                                              blurRadius: 4.0,
                                              spreadRadius: 1.0,
                                              offset: Offset(0, 2),
                                            ),
                                          ],
                                          border: Border.all(
                                            color: isSelected
                                                ? Colors.yellow
                                                : Colors.grey,
                                            width: 1.5,
                                          ),
                                        ),
                                        child: RadioListTile(
                                          title: Text(radioOption.text),
                                          value: index,
                                          groupValue: _selectedAnswerIndex,
                                          onChanged: (int? value) {
                                            setState(() {
                                              _selectedAnswerIndex = value!;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                                if (currentQuestion.allowsComment) ...[
                                  const SizedBox(height: 20.0),
                                  Text(
                                    currentQuestion.commentText,
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.grey.shade600,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 10.0),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 24.0, vertical: 8.0),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                      child: TextField(
                                        controller: _commentController,
                                        decoration: InputDecoration(
                                          labelText: 'Megjegyzés...',
                                          labelStyle: const TextStyle(
                                              color: Colors.grey),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            borderSide: BorderSide(
                                                color: Colors.grey.shade600,
                                                width: 1.5),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            borderSide: const BorderSide(
                                                color: Colors.yellow,
                                                width: 1.5),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            borderSide: const BorderSide(
                                                color: Colors.grey, width: 1.5),
                                          ),
                                          filled: true,
                                          fillColor: Colors.white,
                                        ),
                                        style: TextStyle(
                                            color: Colors.grey.shade600),
                                        maxLines: null,
                                      ),
                                    ),
                                  ),
                                ],
                                SizedBox(
                                    height: MediaQuery.of(context).size.width *
                                        0.02),
                                GradientButton(
                                  text: 'TOVÁBB',
                                  gradient: const LinearGradient(
                                    colors: [Colors.yellow, AppColors.yellow],
                                  ),
                                  onPressed: () async {
                                    if (_selectedAnswerIndex != -1) {
                                      _sendAnswer(
                                          currentQuestion.index,
                                          currentQuestion
                                              .radioOptions[
                                                  _selectedAnswerIndex]
                                              .text,
                                          currentQuestion.text);
                                      currentQuestion.userResponse =
                                          currentQuestion.allowsComment == true
                                              ? [
                                                  currentQuestion
                                                      .radioOptions[
                                                          _selectedAnswerIndex]
                                                      .text,
                                                  'comment:${_commentController.text}'
                                                ]
                                              : [
                                                  currentQuestion
                                                      .radioOptions[
                                                          _selectedAnswerIndex]
                                                      .text,
                                                ];
                                      print(
                                          'Save answere ${currentQuestion.userResponse}');
                                      saveAsnwere(currentQuestion);

                                      quizProvider.answerQuestion(
                                          currentQuestion
                                              .radioOptions[
                                                  _selectedAnswerIndex]
                                              .nextQuestionIndex);
                                      _scrollToTop();
                                      if (quizProvider.isQuizFinished) {
                                        await quizProvider
                                            .saveUserResponse(answeerMap);
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    hipnom3_ModuleOpening_M3(
                                                        'Azonosito',0)));
                                      }
                                    }
                                  },
                                  showIcon: true,
                                ),
                              ],
                            ),
                          ] else if (currentQuestion.twoColumn) ...[
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Center(
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              left: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.05),
                                          child: Text(
                                            currentQuestion.prosText,
                                            style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey.shade600,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Center(
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              right: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.05),
                                          child: Text(
                                            currentQuestion.consText,
                                            style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey.shade600,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.width *
                                        0.02),
                                Column(
                                  children: [
                                    is_hat_ketto
                                        ? SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.5,
                                            child: ListView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemCount:
                                                  _optionControllers2.length,
                                              itemBuilder: (context, index) {
                                                var controller =
                                                    _optionControllers2[index];
                                                var controller2 =
                                                    _optionControllers3[index];
                                                return Padding(
                                                  key: ValueKey(controller),
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 8.0,
                                                      vertical: 4.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Expanded(
                                                        child: Padding(
                                                          padding: EdgeInsets.only(
                                                              left: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.01),
                                                          child: TextField(
                                                            controller:
                                                                controller,
                                                            decoration:
                                                                InputDecoration(
                                                              labelText: '...',
                                                              labelStyle: TextStyle(
                                                                  color: Colors
                                                                      .grey
                                                                      .shade600),
                                                              border:
                                                                  OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8.0),
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .grey
                                                                        .shade600,
                                                                    width: 1.5),
                                                              ),
                                                              focusedBorder:
                                                                  OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8.0),
                                                                borderSide: const BorderSide(
                                                                    color: Colors
                                                                        .yellow,
                                                                    width: 1.5),
                                                              ),
                                                              enabledBorder:
                                                                  OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8.0),
                                                                borderSide:
                                                                    const BorderSide(
                                                                        color: Colors
                                                                            .grey,
                                                                        width:
                                                                            1.5),
                                                              ),
                                                              filled: true,
                                                              fillColor:
                                                                  Colors.white,
                                                            ),
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .grey
                                                                    .shade800),
                                                            maxLines: null,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.1),
                                                      Expanded(
                                                        child: Padding(
                                                          padding: EdgeInsets.only(
                                                              right: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.01),
                                                          child: TextField(
                                                            controller:
                                                                controller2,
                                                            decoration:
                                                                InputDecoration(
                                                              labelText: '...',
                                                              labelStyle: TextStyle(
                                                                  color: Colors
                                                                      .grey
                                                                      .shade600),
                                                              border:
                                                                  OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8.0),
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .grey
                                                                        .shade600,
                                                                    width: 1.5),
                                                              ),
                                                              focusedBorder:
                                                                  OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8.0),
                                                                borderSide: const BorderSide(
                                                                    color: Colors
                                                                        .yellow,
                                                                    width: 1.5),
                                                              ),
                                                              enabledBorder:
                                                                  OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8.0),
                                                                borderSide:
                                                                    const BorderSide(
                                                                        color: Colors
                                                                            .grey,
                                                                        width:
                                                                            1.5),
                                                              ),
                                                              filled: true,
                                                              fillColor:
                                                                  Colors.white,
                                                            ),
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .grey
                                                                    .shade800),
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
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.5,
                                            child: ListView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemCount:
                                                  _optionControllers2.length,
                                              itemBuilder: (context, index) {
                                                var text2 =
                                                    _optionControllers2[index]
                                                        .text;
                                                var text3 =
                                                    _optionControllers3[index]
                                                        .text;
                                                return Padding(
                                                  key: ValueKey(text2),
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 8.0,
                                                      vertical: 4.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Expanded(
                                                        child: Padding(
                                                          padding: EdgeInsets.only(
                                                              left: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.01),
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              border: Border.all(
                                                                  color: Colors
                                                                      .grey
                                                                      .shade600,
                                                                  width: 2.0),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.0),
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: TextField(
                                                              // Changed from Text to TextField
                                                              controller:
                                                                  _optionControllers2[
                                                                      index], // Using the controller to allow input
                                                              decoration:
                                                                  InputDecoration(
                                                                hintText:
                                                                    'Kérlek, válaszolj!',
                                                                border:
                                                                    InputBorder
                                                                        .none,
                                                              ),
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .grey
                                                                      .shade800),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.1),
                                                      Expanded(
                                                        child: Padding(
                                                          padding: EdgeInsets.only(
                                                              right: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.01),
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              border: Border.all(
                                                                  color: Colors
                                                                      .grey
                                                                      .shade600,
                                                                  width: 2.0),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.0),
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: TextField(
                                                              // Changed from Text to TextField
                                                              controller:
                                                                  _optionControllers3[
                                                                      index], // Using the controller to allow input
                                                              decoration:
                                                                  InputDecoration(
                                                                hintText:
                                                                    'Kérlek, válaszolj!',
                                                                border:
                                                                    InputBorder
                                                                        .none,
                                                              ),
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .grey
                                                                      .shade800),
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
// Button to add new pairs of text fields

                                    ...currentQuestion.answers.map((answer) {
                                      if (answer.isFillable) {
                                        return Column(
                                          children: [
                                            SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.02),
                                            GradientButton(
                                              text: 'ÚJ MEGADÁSA',
                                              gradient: const LinearGradient(
                                                colors: [
                                                  AppColors.whitewhite,
                                                  Colors.yellow
                                                ],
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  _optionControllers2.add(
                                                      TextEditingController());
                                                  _optionControllers3.add(
                                                      TextEditingController());
                                                });
                                              },
                                              showIcon: false,
                                            ),
                                            SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.02),
                                          ],
                                        );
                                      } else {
                                        return Container();
                                      }
                                    }).toList(),
                                    if (is_hat_ketto)
                                      GradientButton(
                                        text: 'TOVÁBB',
                                        gradient: const LinearGradient(
                                          colors: [
                                            Colors.yellow,
                                            AppColors.yellow
                                          ],
                                        ),
                                        onPressed: () async {
                                          if (_optionControllers2.isEmpty) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                              content: Text(
                                                  'Írj legalább egy választ!'),
                                            ));

                                            return;
                                          }

                                          List<String> combinedAnswers = [];

                                          for (int i = 0;
                                              i < _optionControllers2.length;
                                              i++) {
                                            // Combining two columns into a single answer per row
                                            if (_optionControllers2[i]
                                                    .text
                                                    .isEmpty ||
                                                _optionControllers3[i]
                                                    .text
                                                    .isEmpty) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                content:
                                                    Text('Kérlek, válaszolj!'),
                                              ));
                                              return;
                                              // break;
                                            }
                                            String answerRow =
                                                '${_optionControllers2[i].text}:${_optionControllers3[i].text}';
                                            combinedAnswers.add(answerRow);
                                          }
                                          setState(() {
                                            is_hat_ketto = true;
                                          });
                                          // Format: 1-answers;2-answers
                                          String finalAnswer =
                                              combinedAnswers.join(',');
                                          currentQuestion.userResponse =
                                              combinedAnswers;
                                          saveAsnwere(currentQuestion);
                                          print(
                                              'here we got ans ${finalAnswer}   $combinedAnswers');
                                          _sendAnswer(
                                              currentQuestion.index,
                                              finalAnswer,
                                              currentQuestion.text);
                                          quizProvider.nextQuestion();
                                          _scrollToTop();
                                          if (quizProvider.isQuizFinished) {
                                            await quizProvider
                                                .saveUserResponse(answeerMap);
                                            Navigator.of(context)
                                                .pushReplacement(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            hipnom3_ModuleOpening_M3(
                                                                'Azonosito',0)));
                                          }
                                          _controller.clear();
                                        },
                                        showIcon: true,
                                      ),
                                  ],
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.width *
                                        0.02),
                              ],
                            ),
                          ] else
                            ...currentQuestion.answers.map((answer) {
                              if (answer.isScale) {
                                return Column(
                                  children: [
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.width *
                                                0.02),
                                    SliderTheme(
                                      data: SliderTheme.of(context).copyWith(
                                        trackHeight: 12.0,
                                        activeTrackColor: Colors.yellow,
                                        inactiveTrackColor:
                                            AppColors.whitewhite,
                                        thumbColor: Colors.grey.shade600,
                                        overlayColor: Colors.grey.shade600
                                            .withOpacity(0.2),
                                        valueIndicatorColor:
                                            Colors.grey.shade600,
                                        thumbShape: const RoundSliderThumbShape(
                                            enabledThumbRadius: 12.0),
                                        overlayShape:
                                            const RoundSliderOverlayShape(
                                                overlayRadius: 15.0),
                                      ),
                                      child: Slider(
                                        value: _sliderValue,
                                        min: 0.0,
                                        max: 10.0,
                                        divisions: 10,
                                        label: _sliderValue.round().toString(),
                                        onChanged: (double value) {
                                          setState(() {
                                            _sliderValue = value;
                                          });
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.width *
                                                0.02),
                                    GradientButton(
                                      text: 'TOVÁBB',
                                      gradient: const LinearGradient(
                                        colors: [
                                          Colors.yellow,
                                          AppColors.yellow
                                        ],
                                      ),
                                      onPressed: () async {
                                        print(
                                            '===============${quizProvider.isQuizFinished}');
                                        _sendAnswer(
                                            currentQuestion.index,
                                            _sliderValue.toString(),
                                            currentQuestion.text);
                                        currentQuestion.userResponse = [
                                          _sliderValue.toString()
                                        ];
                                        saveAsnwere(currentQuestion);
                                        quizProvider.answerQuestion(
                                            answer.nextQuestionIndex);
                                        // quizProvider1.nextQuestion();
                                        print(
                                            'finish ${quizProvider.isQuizFinished}');

                                        _scrollToTop();

                                        if (quizProvider.isQuizFinished) {
                                          await quizProvider
                                              .saveUserResponse(answeerMap);
                                          Navigator.of(context).pushReplacement(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      hipnom3_ModuleOpening_M3(
                                                          'Azonosito',0)));
                                        }
                                      },
                                      showIcon: true,
                                    ),
                                  ],
                                );
                              } else if (answer.isVideo) {
                                return Column(
                                  children: [
                                    Center(
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                          ),
                                          child: SizedBox(
                                            child: HtmlWidget(
                                              '<video controls controlsList="nodownload" style="border:none; margin:0; padding:0; width:100%; height:100%;" src="${answer.video}"></video>',
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.width *
                                                0.02),
                                    GradientButton(
                                      text: 'MEGNÉZTEM',
                                      gradient: const LinearGradient(
                                        colors: [
                                          Colors.yellow,
                                          AppColors.yellow
                                        ],
                                      ),
                                      onPressed: () async {
                                        _sendAnswer(
                                            currentQuestion.index,
                                            "Watched Video",
                                            currentQuestion.text);
                                        print(
                                            'Here is index ${answer.nextQuestionIndex}');
                                        quizProvider.nextQuestion();
                                        _scrollToTop();
                                        if (quizProvider.isQuizFinished) {
                                          await quizProvider
                                              .saveUserResponse(answeerMap);
                                          Navigator.of(context).pushReplacement(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      hipnom3_ModuleOpening_M3(
                                                          'Azonosito',0)));
                                        }
                                      },
                                      showIcon: true,
                                    ),
                                  ],
                                );
                              }
                              return Container();
                            }).toList(),
                          if (currentQuestion.requiresTable) ...[
                            Container(
                                width: MediaQuery.of(context).size.width * 0.85,
                                height:
                                    MediaQuery.of(context).size.width * 0.30,
                                //width: MediaQuery.of(context).size.width * 0.2,
                                // Make the cells narrower
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  // Background color for the container
                                  border: Border.all(
                                      color: Colors.grey.shade600, width: 1.0),
                                  // Border color and width
                                  borderRadius: BorderRadius.circular(
                                      8.0), // Border radius
                                ),
                                child:
                                    //ReorderableListView(
                                    ListView(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  children: [
                                    // Header row
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0, vertical: 4.0),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.7,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: Colors.grey.shade600,
                                              width: 1.0),
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.1,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(
                                                    color: Colors.grey.shade600,
                                                    width: 1.0),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              child: ListTile(
                                                title: Text(
                                                  "idősáv",
                                                  style: TextStyle(
                                                      color:
                                                          Colors.grey.shade800),
                                                ),
                                                tileColor: Colors.grey.shade100,
                                              ),
                                            ),
                                            for (int i = 1; i <= 7; i++)
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.05,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border.all(
                                                      color:
                                                          Colors.grey.shade600,
                                                      width: 1.0),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                                child: ListTile(
                                                  title: Text(
                                                    "$i.nap",
                                                    style: TextStyle(
                                                        color: Colors
                                                            .grey.shade800),
                                                  ),
                                                  tileColor:
                                                      Colors.grey.shade100,
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    // Original rows
                                    for (int index = 0;
                                        index < _rankableOptions_.length;
                                        index++)
                                      Padding(
                                        key: ValueKey(_rankableOptions_[index]),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0, vertical: 4.0),
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.7,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                                color: Colors.grey.shade600,
                                                width: 1.0),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.1,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border.all(
                                                      color:
                                                          Colors.grey.shade600,
                                                      width: 1.0),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                                child: ListTile(
                                                  title: Text(
                                                    felirat_most[
                                                        _Types[index]]!,
                                                    style: TextStyle(
                                                        color: Colors
                                                            .grey.shade800),
                                                  ),
                                                  tileColor:
                                                      Colors.grey.shade100,
                                                ),
                                              ),
                                              for (int i = 0; i < 7; i++)
                                                Builder(builder: (context) {
                                                  var myController =
                                                      matrix[index][i];
                                                  // print('hhhh  $index  $i');

                                                  return Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.05,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      border: Border.all(
                                                          color: Colors
                                                              .grey.shade600,
                                                          width: 1.0),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                    ),
                                                    child: ListTile(
                                                      title: TextField(
                                                        controller:
                                                            myController,
                                                        style: TextStyle(
                                                            color: Colors
                                                                .grey.shade800),
                                                      ),
                                                      tileColor:
                                                          Colors.grey.shade100,
                                                    ),
                                                  );
                                                }),
                                            ],
                                          ),
                                        ),
                                      ),
                                  ],
                                )),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.width * 0.02),
                            GradientButton(
                              text: 'TOVÁBB',
                              gradient: const LinearGradient(
                                colors: [Colors.yellow, AppColors.yellow],
                              ),
                              onPressed: () async {
                                bool hasValue = false;
                                List<String> enterValues = [];
                                for (int index = 0;
                                    index < _rankableOptions_.length;
                                    index++) {
                                  for (int i = 0; i < 7; i++) {
                                    enterValues.add(matrix[index][i].text);
                                    if (matrix[index][i].text.isNotEmpty) {
                                      hasValue = true;
                                      // break;
                                    }
                                  }
                                  // if (hasValue) break;
                                }
                                if (hasValue) {
                                  _sendAnswer(currentQuestion.index,
                                      _controller.text, currentQuestion.text);
                                  currentQuestion.userResponse = enterValues;
                                  print('${currentQuestion.userResponse}');
                                  saveAsnwere(currentQuestion);
                                  quizProvider.nextQuestion();
                                  _scrollToTop();
                                } else {
                                  print('Kérlek, válaszolj!');
                                }

                                if (quizProvider.isQuizFinished) {
                                  await quizProvider
                                      .saveUserResponse(answeerMap);
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              hipnom3_ModuleOpening_M3('Azonosito',0)));

                                  _controller.clear();
                                }
                                // else {
                                //   ScaffoldMessenger.of(context).showSnackBar(
                                //     const SnackBar(
                                //         content:
                                //             Text('Kérlek, írd be a válaszod!')),
                                //   );
                                // }
                                print(currentQuestion.index);
                              },
                              showIcon: true,
                            ),
                          ],

                          // ADAM tette be es kesobb kiveheto
                          if (currentQuestion.requiresTableBigger) ...[
                            Container(
                              width: MediaQuery.of(context).size.width *
                                  0.75, // Smaller width
                              height: MediaQuery.of(context).size.width *
                                  0.25, // Smaller height
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    color: Colors.grey.shade600, width: 1.0),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: ListView(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                children: [
                                  // Header row
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 6.0,
                                        vertical: 2.0), // Adjust padding
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.65, // Smaller width
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            color: Colors.grey.shade600,
                                            width: 1.0),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          // "idősáv" column
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.08, // Adjusted width
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                  color: Colors.grey.shade600,
                                                  width: 1.0),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            child: ListTile(
                                              title: Text(
                                                "idősáv",
                                                style: TextStyle(
                                                    color:
                                                        Colors.grey.shade800),
                                              ),
                                              tileColor: Colors.grey.shade100,
                                            ),
                                          ),
                                          if (currentQuestion.extra == true)
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.08, // Adjusted width
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(
                                                    color: Colors.grey.shade600,
                                                    width: 1.0),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              child: ListTile(
                                                title: Text(
                                                  "új mozgás vagy intenzitásnövelés?",
                                                  style: TextStyle(
                                                      color:
                                                          Colors.grey.shade800),
                                                ),
                                                tileColor: Colors.grey.shade100,
                                              ),
                                            ),
                                          for (int i = 1; i <= 7; i++)
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.04, // Adjusted width for smaller cells
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(
                                                    color: Colors.grey.shade600,
                                                    width: 1.0),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              child: ListTile(
                                                title: Text(
                                                  "$i.\n nap",
                                                  style: TextStyle(
                                                      color:
                                                          Colors.grey.shade800),
                                                ),
                                                tileColor: Colors.grey.shade100,
                                              ),
                                            ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.08, // Adjusted width
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                  color: Colors.grey.shade600,
                                                  width: 1.0),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            child: ListTile(
                                              title: Text(
                                                "Magabiztossági szint",
                                                style: TextStyle(
                                                    color:
                                                        Colors.grey.shade800),
                                              ),
                                              tileColor: Colors.grey.shade100,
                                            ),
                                          ),
                                          if (currentQuestion.check == true)
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.08, // Adjusted width
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(
                                                    color: Colors.grey.shade600,
                                                    width: 1.0),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              child: ListTile(
                                                title: Text(
                                                  "Segítők – hogyan?",
                                                  style: TextStyle(
                                                      color:
                                                          Colors.grey.shade800),
                                                ),
                                                tileColor: Colors.grey.shade100,
                                              ),
                                            )
                                          else
                                            const SizedBox.shrink()
                                        ],
                                      ),
                                    ),
                                  ),
                                  // Data rows
                                  for (int index = 0;
                                      index < felirat_most.length;
                                      index++)
                                    Padding(
                                      key: ValueKey(felirat_most[index]),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 6.0,
                                          vertical: 2.0), // Adjust padding
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.65, // Smaller width
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: Colors.grey.shade600,
                                              width: 1.0),
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        child: Builder(builder: (context) {
                                          // Determine the number of cells needed in each row
                                          int cellCount = (currentQuestion
                                                          .extra ==
                                                      true &&
                                                  currentQuestion.check == true)
                                              ? 10
                                              : (currentQuestion.check == true
                                                  ? 9
                                                  : 8);

                                          // If this is the last row, add one more cell
                                          if (index ==
                                              felirat_most.length - 1) {
                                            cellCount += 1;
                                          }

                                          return Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              // "idősáv" cell
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.08, // Adjusted width
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border.all(
                                                      color:
                                                          Colors.grey.shade600,
                                                      width: 1.0),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                                child: ListTile(
                                                  title: Text(
                                                    felirat_most[
                                                        _Types[index]]!,
                                                    style: TextStyle(
                                                        color: Colors
                                                            .grey.shade800),
                                                  ),
                                                  tileColor:
                                                      Colors.grey.shade100,
                                                ),
                                              ),
                                              // Extra column cell (if 'extra' is true)
                                              if (currentQuestion.extra == true)
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.08, // Adjusted width
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    border: Border.all(
                                                        color: Colors
                                                            .grey.shade600,
                                                        width: 1.0),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                  child: TextField(
                                                    controller: matrix[index]
                                                        [0],
                                                    readOnly: false,
                                                    style: TextStyle(
                                                        color: Colors
                                                            .grey.shade800),
                                                  ),
                                                ),
                                              // 1.nap to 7.nap and any other column cells
                                              for (int i = 1;
                                                  i < cellCount;
                                                  i++)
                                                if (matrix[index].length > i)
                                                  Container(
                                                    width: (i <= 7)
                                                        ? MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.04 // Adjusted width for smaller cells
                                                        : MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.08, // Adjusted width
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      border: Border.all(
                                                          color: Colors
                                                              .grey.shade600,
                                                          width: 1.0),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                    ),
                                                    child: TextField(
                                                      controller: matrix[index]
                                                          [i],
                                                      readOnly: false,
                                                      style: TextStyle(
                                                          color: Colors
                                                              .grey.shade800),
                                                    ),
                                                  ),
                                            ],
                                          );
                                        }),
                                      ),
                                    ),
                                ],
                              ),
                            ),

                            SizedBox(
                                height: MediaQuery.of(context).size.width *
                                    0.015), // Adjusted spacing
                            GradientButton(
                              text: 'TOVÁBB',
                              gradient: const LinearGradient(
                                colors: [Colors.yellow, AppColors.yellow],
                              ),
                              onPressed: () async {
                                int cellCount = (currentQuestion.extra ==
                                            true &&
                                        currentQuestion.check == true)
                                    ? 10
                                    : (currentQuestion.check == true ? 9 : 8);
                                List<String> enterValues = [];
                                for (int index = 0;
                                    index < _rankableOptions_.length;
                                    index++) {
                                  // If this is the last row, add one more cell
                                  int adjustedCellCount =
                                      (index == _rankableOptions_.length - 1)
                                          ? cellCount + 1
                                          : cellCount;

                                  for (int i = 0; i < adjustedCellCount; i++) {
                                    if (matrix[index].length > i) {
                                      enterValues.add(matrix[index][i].text);
                                    } else {
                                      enterValues.add(
                                          ""); // Fallback in case of out-of-bounds
                                    }
                                  }
                                }
                                print("============== ${enterValues}");
                                currentQuestion.userResponse = enterValues;
                                saveAsnwere(currentQuestion);
                                _sendAnswer(currentQuestion.index,
                                    _controller.text, currentQuestion.text);
                                quizProvider.nextQuestion();
                                _scrollToTop();
                                if (quizProvider.isQuizFinished) {
                                  await quizProvider
                                      .saveUserResponse(answeerMap);
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              hipnom3_ModuleOpening_M3('Azonosito',0)));
                                }
                              },
                              showIcon: true,
                            ),
                          ],
                          if (currentQuestion.choose == true) ...[
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: _optionControllers2.length,
                                itemBuilder: (context, index) {
                                  var text2 = _optionControllers2[index].text;
                                  var text3 = _optionControllers3[index].text;

                                  // Ensure color states are managed properly by initializing lists outside the builder
                                  if (colorStates1.length <
                                      _optionControllers2.length) {
                                    colorStates1.add(Colors.white);
                                    colorStates2.add(Colors.white);
                                  }

                                  return Padding(
                                    key: ValueKey(text2),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0, vertical: 4.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                left: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.01),
                                            child: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  _controller.text = text2;
                                                  // Toggle color on tap
                                                  colorStates1[index] =
                                                      colorStates1[index] ==
                                                              Colors.white
                                                          ? Colors.yellow
                                                          : Colors.white;
                                                });
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: colorStates1[
                                                      index], // Set background color based on tap
                                                  border: Border.all(
                                                      color:
                                                          Colors.grey.shade600,
                                                      width: 2.0),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  text2,
                                                  style: TextStyle(
                                                      color:
                                                          Colors.grey.shade800),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.1),
                                        Expanded(
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                right: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.01),
                                            child: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  _controller.text = text2;

                                                  // Toggle color on tap
                                                  colorStates2[index] =
                                                      colorStates2[index] ==
                                                              Colors.white
                                                          ? Colors.yellow
                                                          : Colors.white;
                                                });
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: colorStates2[
                                                      index], // Set background color based on tap
                                                  border: Border.all(
                                                      color:
                                                          Colors.grey.shade600,
                                                      width: 2.0),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  text3,
                                                  style: TextStyle(
                                                      color:
                                                          Colors.grey.shade800),
                                                ),
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
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.width * 0.02),
                            GradientButton(
                              text: 'TOVÁBB',
                              gradient: const LinearGradient(
                                colors: [Colors.yellow, AppColors.yellow],
                              ),
                              onPressed: () async {
                                if (_controller.text.isNotEmpty) {
                                  _sendAnswer(currentQuestion.index,
                                      _controller.text, currentQuestion.text);

                                  print(
                                      'Here we got current index ${currentQuestion.index}');
                                  currentQuestion.userResponse = [
                                    _controller.text
                                  ];
                                  saveAsnwere(currentQuestion);
                                  quizProvider.nextQuestion();

                                  _scrollToTop();
                                  if (quizProvider.isQuizFinished) {
                                    await quizProvider
                                        .saveUserResponse(answeerMap);
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                hipnom3_ModuleOpening_M3('Azonosito',0)));
                                  }
                                  _controller.clear();
                                }
                                print(currentQuestion.index);
                              },
                              showIcon: true,
                            ),
                          ],
                          if (currentQuestion.requiresTextInput) ...[
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24.0, vertical: 8.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: TextField(
                                  controller: _controller,
                                  decoration: InputDecoration(
                                    labelText: 'A válaszod...',
                                    labelStyle:
                                        TextStyle(color: Colors.grey.shade600),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade600,
                                          width: 1.5),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      borderSide: const BorderSide(
                                          color: Colors.yellow, width: 1.5),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      borderSide: const BorderSide(
                                          color: Colors.grey, width: 1.5),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                  style: TextStyle(color: Colors.grey.shade600),
                                  maxLines: null,
                                ),
                              ),
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.width * 0.02),
                            GradientButton(
                              text: 'TOVÁBB',
                              gradient: const LinearGradient(
                                colors: [Colors.yellow, AppColors.yellow],
                              ),
                              onPressed: () async {
                                if (_controller.text.isNotEmpty) {
                                  _sendAnswer(currentQuestion.index,
                                      _controller.text, currentQuestion.text);
                                  quizProvider.nextQuestion();
                                  print(
                                      'Here we got current index ${currentQuestion.index}');
                                  currentQuestion.userResponse = [
                                    _controller.text
                                  ];
                                  saveAsnwere(currentQuestion);
                                  _scrollToTop();
                                  if (quizProvider.isQuizFinished) {
                                    await quizProvider
                                        .saveUserResponse(answeerMap);
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                hipnom3_ModuleOpening_M3('Azonosito',0)));
                                  }
                                  _controller.clear();
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content:
                                            Text('Kérlek, írd be a válaszod!')),
                                  );
                                }
                                print(currentQuestion.index);
                              },
                              showIcon: true,
                            ),
                          ],
                        ],
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.width * 0.5,
                      color: AppColors.lightshade,
                    ),
                  ],
                ),
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
                                height:
                                    MediaQuery.of(context).size.width * 0.03,
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
                                leading:
                                    Image.asset('assets/images/2icon_m.png'),
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
                                height:
                                    MediaQuery.of(context).size.width * 0.02,
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
                                height:
                                    MediaQuery.of(context).size.width * 0.02,
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
                                leading:
                                    Image.asset('assets/images/5icon_m.png'),
                                title: Text(
                                  '1-2. hét',
                                  style: MyTextStyles.vastagbekezdes(context),
                                ),
                                subtitle: Text(
                                  'Zárolva',
                                  style: MyTextStyles.kicsibekezdes(context),
                                ),
                                onTap: () {},
                              ),
                            ),
                            Container(
                              color: AppColors.whitewhite,
                              child: Container(
                                height:
                                MediaQuery.of(context).size.width * 0.02,
                                decoration:const BoxDecoration(
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
                                    builder: (BuildContext context) =>
                                    const  QuizScreen2(),
                                  ),
                                );
                              },
                            ),
                            Container(
                              color: AppColors.whitewhite,
                              child: Container(
                                height:
                                MediaQuery.of(context).size.width * 0.02,
                                decoration:const  BoxDecoration(
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
                                'Jelenlegi',
                                style: MyTextStyles.kicsibekezdes(context),
                              ),
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                     hipnom3_M3_4het('Azonosito'),
                                  ),
                                );
                              },
                            ),
                            Container(
                              color: AppColors.whitewhite,
                              child: Container(
                                height:
                                MediaQuery.of(context).size.width * 0.02,
                                decoration:const  BoxDecoration(
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
                                    builder: (BuildContext context) =>
                                    const  QuizScreen4(),
                                  ),
                                );
                              },
                            ),
                            Container(
                              color: AppColors.whitewhite,
                              child: Container(
                                height:
                                MediaQuery.of(context).size.width * 0.02,
                                decoration:const  BoxDecoration(
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
                                    builder: (BuildContext context) =>
                                    const  QuizScreen5(),
                                  ),
                                );
                              },
                            ),
                            Container(
                              color: AppColors.whitewhite,
                              child: Container(
                                height:
                                MediaQuery.of(context).size.width * 0.02,
                                decoration:const  BoxDecoration(
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

                              },
                            ),
                            Container(
                              color: AppColors.whitewhite,
                              child: Container(
                                height:
                                MediaQuery.of(context).size.width * 0.02,
                                decoration:const  BoxDecoration(
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

                              },
                            ),
                            Container(
                              color: AppColors.lightshade,
                              child: Container(
                                height:
                                MediaQuery.of(context).size.width * 0.02,
                                decoration:const  BoxDecoration(
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

                              },
                            ),
                            Container(
                              color: AppColors.whitewhite,
                              child: Container(
                                height:
                                MediaQuery.of(context).size.width * 0.02,
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
    );
  }
}
