class Quiz {
  String chapterId;
  String? questionId;
  String question;
  String option1;
  String option2;
  String option3;
  String option4;
  String correctOption;

  Quiz({
    required this.chapterId,
    this.questionId,
    required this.question,
    required this.option1,
    required this.option2,
    required this.option3,
    required this.option4,
    required this.correctOption,
  });

  static Quiz fromMap(Map<String, dynamic> map) {
    return Quiz(
      chapterId: map['chapterId'],
      questionId: map['questionId'],
      question: map['question'],
      option1: map['option1'],
      option2: map['option2'],
      option3: map['option3'],
      option4: map['option4'],
      correctOption: map['correctOption'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'chapterId': chapterId,
      'questionId': questionId,
      'question': question,
      'option1': option1,
      'option2': option2,
      'option3': option3,
      'option4': option4,
      'correctOption': correctOption,
    };
  }
}
