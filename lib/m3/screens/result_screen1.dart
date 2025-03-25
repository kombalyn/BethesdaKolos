import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider1.dart';

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
