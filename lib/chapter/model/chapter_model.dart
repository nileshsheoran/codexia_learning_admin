class Chapter {
  final String chapterName;
  final String chapterContent;
  final String courseId;
  String? id;

  Chapter(
      {required this.chapterName,
      required this.chapterContent,
      required this.courseId,
      this.id});

  static Chapter fromMap(Map<String, dynamic> map) {
    return Chapter(
      chapterName: map['chapterName'],
      chapterContent: map['chapterContent'],
      courseId: map['courseId'],
      id: map['id'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'chapterName': chapterName,
      'chapterContent': chapterContent,
      'courseId': courseId,
      'id': id,
    };
  }
}
