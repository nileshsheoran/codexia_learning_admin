class Course {
  String courseName;
  String imgUrl;
  String courseId;

  Course({
    required this.courseName,
    this.imgUrl = '',
    this.courseId = '',
  });

  static Course fromMap(Map<String, dynamic> map) {
    return Course(
      courseName: map['courseName'],
      imgUrl: map['imgUrl'],
      courseId: map['courseId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'courseName': courseName,
      'imgUrl': imgUrl,
      'courseId': courseId,
    };
  }
}
