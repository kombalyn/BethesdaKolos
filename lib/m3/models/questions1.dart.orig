class Question {
  final String text;
  final int index;
  final bool requiresTextInput;
  final bool requiresRanking;
  final bool requiresVideo;
<<<<<<< HEAD
  final String video;
  final bool two_column;
  final bool requiresRadioOptions;
  final List<RadioOption> radioOptions; // Change this property to a list of RadioOption objects
=======
  final String video; // Add this property
  final bool two_column;
>>>>>>> e160abca6aecc22a95a25aadc5e406b72d100989

  final List<Answer> answers;
  List<String> rankableOptions;

  final bool hasInfoButton; // Indicates if the question has an info button
  final String infoButtonText; // Text for the info button

  Question({
    required this.text,
    required this.index,
    this.requiresTextInput = false,
    this.requiresRanking = false,
    this.requiresVideo = false,
    required this.answers,
    this.rankableOptions = const [],
    this.video = '',
<<<<<<< HEAD
    required this.two_column,
    this.requiresRadioOptions = false,
    this.radioOptions = const [], // Initialize with an empty list
    this.hasInfoButton = false, // Default to false if not provided
    this.infoButtonText = '', // Default to empty string if not provided
  });
}

class RadioOption {
  final String text;
  final int nextQuestionIndex;

  RadioOption({
    required this.text,
    required this.nextQuestionIndex,
=======
    required this.two_column, // Initialize with an empty string
>>>>>>> e160abca6aecc22a95a25aadc5e406b72d100989
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
