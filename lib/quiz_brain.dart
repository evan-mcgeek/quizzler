import 'question.dart';

class QuizBrain {
  int _questionNumber = 0;

  List<Question> _questionBank = [
    Question('Some cats are actually allergic to humans', true),
    Question('You can lead a cow down stairs but not up stairs', false),
    Question('Approximately one quarter of human bones are in the feet', true),
    Question(
        'Flying in an aeroplane is statistically safer than driving in a car',
        true),
    Question('The Great Wall of China is visible from space', false),
    Question('It is illegal to pee in the Ocean in Portugal.', true),
    Question(
        'Charlie Chaplin came first in a Charlie Chaplin look-alike contest',
        false),
    Question('If you’re born between May 1st and 20th, then you’re a Gemini.',
        false),
    Question(
        'The loudest sound produced by any animal is 188 decibels. That animal is the African Elephant.',
        false),
    Question(
        'Brazil is the only country in the Americas to have the official language of Portuguese',
        true),
    Question('Google was originally called \"Backrub\".', true),
    Question(
        'Chocolate affects a dog\'s heart and nervous system; a few ounces are enough to kill a small dog.',
        true),
    Question(
        'Stephen Hawking once declined a knighthood from the Queen.', true),
  ];

  void nextQuestion() {
    if (_questionNumber < _questionBank.length - 1) {
      _questionNumber++;
    }
  }

  String getQuestionText() {
    return _questionBank[_questionNumber].questionText;
  }

  bool getCorrectAnswer() {
    return _questionBank[_questionNumber].questionAnswer;
  }

  int getQuestionNumber() {
    return _questionNumber;
  }

  int getQuestionBankLength() {
    return _questionBank.length;
  }

  bool isFinished() {
    return _questionNumber == _questionBank.length - 1;
  }

  void reset() {
    if (isFinished()) {
      _questionNumber = 0;
    }
  }
}
