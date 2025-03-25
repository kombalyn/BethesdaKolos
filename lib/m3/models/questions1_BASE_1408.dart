class Question {
  final String text;
  final int index;
  final bool requiresTextInput;
  final bool requiresRanking;
  final bool requiresVideo;
  final String video; // Add this property

  final List<Answer> answers;
  List<String> rankableOptions;

  Question({
    required this.text,
    required this.index,
    this.requiresTextInput = false,
    this.requiresRanking = false,
    this.requiresVideo = false,
    required this.answers,
    this.rankableOptions = const [],
    this.video = '', // Initialize with an empty string
  });
}

class Answer {
  final String text;
  final int nextQuestionIndex;
  final bool isNumeric;
  final bool isScale;
  final bool isRankable;
  final bool isVideo;
  final String video; // Add this property

  Answer({
    this.text = '',
    required this.nextQuestionIndex,
    this.isNumeric = false,
    this.isScale = false,
    this.isRankable = false,
    this.isVideo=false,
    this.video = '', // Initialize with an empty string
  });
}
