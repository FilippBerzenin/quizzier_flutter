import 'package:flutter/material.dart';
import 'package:quizzier_flutter/QuestionsData.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int questionNumber = 0;
  int correctAnswer = 0;
  int wrongAnswer = 0;
  List<Widget> scoreKipper = [
    Icon(
      Icons.low_priority_sharp,
      color: Colors.white,
    )
  ];
  List listOf0Questions = QuestionsData.questionBank;

  Icon checkingCorrectAnswer(bool answer) {
    if (listOf0Questions.elementAt(questionNumber).answer != answer) {
      wrongAnswer++;
      return Icon(
        Icons.close,
        color: Colors.red,
      );
    } else {
      correctAnswer++;
      return Icon(
        Icons.check,
        color: Colors.green,
      );
    }
  }

  Text returnQuastion() {
    return Text(
      listOf0Questions.elementAt(questionNumber).text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 25.0,
        color: Colors.white,
      ),
    );
  }

  Widget returnRestartButton() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        FlatButton(
          child: Text('Restart'),
          textColor: Colors.white,
          color: Colors.green,
          onPressed: () {
            wrongAnswer = 0;
            correctAnswer = 0;
            questionNumber = 0;
            scoreKipper.clear();
            setState(() {
              returnQuastion();
              scoreKipper;
            });
          },
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'You have a $correctAnswer correct answer',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 25.0,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget checkLastQueastion() {
    if (checkTheEnd()) {
      return returnRestartButton();
    } else {
      return returnQuastion();
    }
  }

  bool checkTheEnd() => questionNumber == (listOf0Questions.length - 1);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(child: checkLastQueastion()),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.green,
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                setState(() {
                  if (!checkTheEnd()) {
                    scoreKipper.add(checkingCorrectAnswer(true));
                    questionNumber++;
                  } else
                    null;
                });
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.red,
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                setState(() {
                  if (!checkTheEnd()) {
                    scoreKipper.add(checkingCorrectAnswer(false));
                    questionNumber++;
                  } else
                    null;
                });
              },
            ),
          ),
        ),
        Row(children: scoreKipper),
      ],
    );
  }
}
