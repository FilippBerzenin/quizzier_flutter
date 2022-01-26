import 'package:flutter/material.dart';

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
  List<Widget> scoreKipper = [];
  List<Questions> questions = [
    new Questions('You can lead a cow down stairs but not up stairs.', false),
    new Questions(
        'Approximately one quarter of human bones are in the feet.', true),
    new Questions('A slug\'s blood is green.', true),
    Questions('End you have a ', true)
  ];

  Icon checkingCorrectAnswer(bool answer) {
    if (questions.elementAt(questionNumber).answer != answer) {
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
      questions.elementAt(questionNumber).text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 25.0,
        color: Colors.white,
      ),
    );
  }

  FlatButton returnRestartButton() {
    return FlatButton(
      child: Text('Restart'),
      textColor: Colors.white,
      color: Colors.green,
      onPressed: () {},
    );
  }

  bool checkTheEnd() => questionNumber == (questions.length - 1);

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
            child: Center(child: returnRestartButton()),
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

class Questions {
  String text = "";
  bool answer = false;

  Questions(String text, bool answer) {
    this.text = text;
    this.answer = answer;
  }
}
/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/
