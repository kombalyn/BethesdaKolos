class Question {
  final String text;
  final int index;
  final bool requiresTextInput;
  final bool requiresRanking;
  final bool requiresVideo;
  final String video; // Add this property
  final bool two_column;

  final List<Answer> answers;
  List<String> rankableOptions;

  final bool hasInfoButton =
      false; // Indicates if the question has an info button
  final String infoButtonText; // Text for the info button

  Question(
    this.infoButtonText, {
    required this.text,
    required this.index,
    this.requiresTextInput = false,
    this.requiresRanking = false,
    this.requiresVideo = false,
    required this.answers,
    this.rankableOptions = const [],
    this.video = '',
    required this.two_column, // Initialize with an empty string
  });
}

class Answer {
  final String text;
  final int nextQuestionIndex;
  final bool isNumeric;
  final bool isScale;
  final bool isRankable;
  final bool isVideo;
  final String video;

  Answer({
    this.text = '',
    required this.nextQuestionIndex,
    this.isNumeric = false,
    this.isScale = false,
    this.isRankable = false,
    this.isVideo = false,
    this.video = '',
  });
}
