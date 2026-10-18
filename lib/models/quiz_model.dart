class Question {
  final int id;
  final String questionText;
  final String imagePath;
  final List<String> options;
  final int correctAnswerIndex;

  Question({
    required this.id,
    required this.questionText,
    required this.imagePath,
    required this.options,
    required this.correctAnswerIndex,
  });
}