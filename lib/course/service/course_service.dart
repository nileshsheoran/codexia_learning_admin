import 'package:codexia_learning_admin/course/model/course_model.dart';
import 'package:firebase_database/firebase_database.dart';

class CourseService {
  final databaseRef = FirebaseDatabase.instance.ref().child('courses');

  Future<void> addCourse(Course course) async {
    final dbRef = databaseRef.push();
    String? id = dbRef.key;
    await dbRef.set({
      'courseName': course.courseName,
      'imgUrl': course.imgUrl,
      'id': id,
    });
  }

  Future<void> updateCourse(Course course) async {
    final dbRef = databaseRef.child(course.courseId);
    await dbRef.update({
      'courseName': course.courseName,
      'imgUrl': course.imgUrl,
    });
  }
  Future<void> deleteCourse(Course course) async {
    final dbRef = databaseRef.child(course.courseId);
    await dbRef.remove();
  }

  Stream<DatabaseEvent> getCourseStream() {
    return databaseRef.onValue;
  }
}
