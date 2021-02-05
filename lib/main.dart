import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'quiz_brain.dart';
import 'package:flare_flutter/flare_actor.dart';

QuizBrain quizBrain = QuizBrain();

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

String animation = 'idle';

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper = [];
  Icon iconCorrect = Icon(Icons.check, color: Colors.green);
  Icon iconWrong = Icon(Icons.close, color: Colors.red);

  void checkAnswer(bool userPickedAnswer) {
    bool correctAnswer = quizBrain.getCorrectAnswer();

    setState(() {
      if (userPickedAnswer == correctAnswer) {
        scoreKeeper.add(iconCorrect);
        animation = 'success';
      } else {
        scoreKeeper.add(iconWrong);
        animation = 'fail';
      }
      quizBrain.nextQuestion();
    });

    if (quizBrain.isFinished()) {
      int result = scoreKeeper.where((e) => e == iconCorrect).length;
      Alert(
        context: context,
        type: AlertType.success,
        title: "WELL DONE",
        desc: 'Your result is $result points',
        buttons: [
          DialogButton(
            child: Text(
              'Start again!',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
            width: 120,
          )
        ],
      ).show();
      quizBrain.reset();
      scoreKeeper = [];
      animation = 'idle';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        CircleAvatar(
          radius: 200,
          backgroundColor: Colors.white,
          child: ClipOval(
            child: FlareActor(
              'assets/teddy_test.flr',
              alignment: Alignment.center,
              fit: BoxFit.fitWidth,
              animation: animation,
            ),
          ),
        ),
        Text(
          'Question ${(quizBrain.getQuestionNumber() + 1).toString()}/${(quizBrain.getQuestionBankLength() - 1).toString()}',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Container(
          margin: const EdgeInsets.all(5.0),
          padding: const EdgeInsets.all(10.0),
          height: 170,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              quizBrain.getQuestionText(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25.0,
                color: Colors.black,
              ),
            ),
          ),
        ),
        FlatButton(
          height: 50,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
              side: BorderSide(color: Colors.white)),
          textColor: Colors.white,
          color: Colors.green,
          child: Text(
            'True',
            style: TextStyle(
              color: Colors.white,
              fontSize: 30.0,
            ),
          ),
          onPressed: () {
            //The user picked true.
            checkAnswer(true);
          },
        ),
        FlatButton(
          height: 50,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
              side: BorderSide(color: Colors.white)),
          color: Colors.red,
          child: Text(
            'False',
            style: TextStyle(
              fontSize: 30.0,
              color: Colors.white,
            ),
          ),
          onPressed: () {
            //The user picked false.
            checkAnswer(false);
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: scoreKeeper,
        ),
      ],
    );
  }
}

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/
