class Question {
  final String text;
  final int index;
  final bool requiresTextInput;
  final bool requiresRanking;
  final bool oldanswers;
  final bool requiresVideo;
  final String video;
  final bool twoColumn;
  final bool requiresRadioOptions;
  final bool requiresCheckOptions;
  final List<RadioOption> radioOptions;
  final List<RadioOption> checkOptions;
  final List<Answer> answers;
  List<String> rankableOptions;
  List<String> notFillableOptions;
  int notFillableIndex = 0;
  final bool hasInfoButton;
  final String infoButtonText;
  final bool allowsComment;
  final String commentText;
  final List<TwoColumnEntry> twoColumnEntries;
  final String prosText;
  final String consText;
  final List<TwoColumnEntry> readonlyTwoColumnEntries;
  final List<String> columnHeaders; // Headers for columns
  final List<bool> isColumnFillable; // To indicate which columns are fillable
  final bool requiresTable;
  final bool requiresTableBigger;
  final int steptoquestion;
  bool? check = false;
  bool? extra = false;
  bool? choose = false;
  bool? nooption = false;


  List<String>? userResponse;

  Question(
      {required this.text,
      required this.index,
      this.requiresTextInput = false,
      this.requiresRanking = false,
      this.requiresVideo = false,
        this.oldanswers = false,
        required this.answers,
      this.rankableOptions = const [],
      this.notFillableOptions = const [],
      this.video = '',
      required this.twoColumn,
      this.requiresRadioOptions = false,
        this.requiresCheckOptions = false,

        this.radioOptions = const [],
        this.checkOptions = const [],

        this.hasInfoButton = false,
      this.infoButtonText = '',
      this.allowsComment = false,
        this.nooption = false,
        this.commentText = '',
      this.twoColumnEntries = const [],
      this.prosText = 'Előnyök',
      this.consText = 'Hátrányok',
      this.readonlyTwoColumnEntries = const [],
      this.columnHeaders = const [],
      this.isColumnFillable = const [],
      this.requiresTable = false,
      this.steptoquestion = -1,
      this.requiresTableBigger = false,
        this.choose =false,
        this.check =false,
        this.extra =false,
        this.userResponse});
}

class RadioOption {
  final String text;
  final int nextQuestionIndex;

  RadioOption({
    required this.text,
    required this.nextQuestionIndex,
  });
}

class CheckOption {
  final String text;
  final int nextQuestionIndex;

  CheckOption({
    required this.text,
    required this.nextQuestionIndex,
  });
}

class Answer {
  final String text;
  final int nextQuestionIndex;
  final bool isNumeric;
  final bool isScale;
  final bool isRankable;
  final bool isHat;
  final bool isVideo;
  final String video;
  final bool isFillable;

  Answer({
    this.text = '',
    required this.nextQuestionIndex,
    this.isNumeric = false,
    this.isScale = false,
    this.isRankable = false,
    this.isHat = false,
    this.isVideo = false,
    this.video = '',
    this.isFillable = true,
  });
}

class TwoColumnEntry {
  final String pros;
  final String cons;
  final bool isFillable;
  final int? previousQuestionIndex;

  TwoColumnEntry({
    required this.pros,
    required this.cons,
    this.isFillable = true,
    this.previousQuestionIndex,
  });
}
