import 'package:codexia_learning_admin/chapter/model/chapter_model.dart';
import 'package:firebase_database/firebase_database.dart';

class ChapterService {
  Future addChapter(Chapter chapter) async {
    final ref = FirebaseDatabase.instance.ref();
    final dbRef = ref.child('chapter').child(chapter.courseId).push();
    chapter.id = dbRef.key;
    await dbRef.set(chapter.toMap());
  }

  Future updateChapter(Chapter chapter) async {
    final ref = FirebaseDatabase.instance.ref();
    final dbRef =
        ref.child('chapter').child(chapter.courseId).child(chapter.id!);
    await dbRef.update(chapter.toMap());
  }

  Future deleteChapter(Chapter chapter) async {
    final ref = FirebaseDatabase.instance.ref();
    final dbRef =
        ref.child('chapter').child(chapter.courseId).child(chapter.id!);
    await dbRef.remove();
  }

  Stream<DatabaseEvent> getChapterStream(String courseId) {
    return FirebaseDatabase.instance.ref('chapter').child(courseId).onValue;
  }
}
