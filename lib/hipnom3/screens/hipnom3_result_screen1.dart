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

class ResultScreen1 extends StatelessWidget {
  static const routeName = '/result1'; // Add this line

  @override
  Widget build(BuildContext context) {
    final quizProvider1 = Provider.of<QuizProvider1>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz Result'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Quiz Finished!',
              style: TextStyle(fontSize: 28.0),
            ),
            SizedBox(height: 20.0),
            Text(
              'Your score is: ${quizProvider1.score}',
              style: TextStyle(fontSize: 24.0),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                quizProvider1.resetQuiz();
                Navigator.of(context).pushReplacementNamed('/');
              },
              child: Text('Restart Quiz'),
            ),
          ],
        ),
      ),
    );
  }
}
