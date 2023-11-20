import 'package:codexia_learning_admin/quiz/model/quiz_model.dart';
import 'package:firebase_database/firebase_database.dart';

class QuizService {
  Future addQuiz(Quiz quiz) async {
    final ref = FirebaseDatabase.instance.ref();
    final dbRef = ref.child('quiz').child(quiz.chapterId).push();
    quiz.questionId = dbRef.key;
    await dbRef.set(quiz.toMap());
  }

  Future updateQuiz(Quiz quiz) async {
    final ref = FirebaseDatabase.instance.ref();
    final dbRef =
        ref.child('quiz').child(quiz.chapterId).child(quiz.questionId!);
    await dbRef.update(quiz.toMap());
  }

  Future deleteQuiz(Quiz quiz) async {
    final ref = FirebaseDatabase.instance.ref();
    final dbRef =
        ref.child('quiz').child(quiz.chapterId).child(quiz.questionId!);
    await dbRef.remove();
  }

  Stream<DatabaseEvent> getChapterStream(String chapterId) {
    return FirebaseDatabase.instance.ref('quiz').child(chapterId).onValue;
  }
}
