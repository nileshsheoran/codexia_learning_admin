import 'package:codexia_learning_admin/chapter/model/chapter_model.dart';
import 'package:codexia_learning_admin/quiz/screen/quiz_show_screen.dart';
import 'package:codexia_learning_admin/quiz/service/quiz_service.dart';
import 'package:codexia_learning_admin/shared/colour_const.dart';
import 'package:flutter/material.dart';

class ChapterDetailScreen extends StatefulWidget {
  final Chapter chapter;

  const ChapterDetailScreen({required this.chapter, super.key});

  @override
  State<ChapterDetailScreen> createState() => _ChapterDetailScreenState();
}

class _ChapterDetailScreenState extends State<ChapterDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColourConst.deepPurple,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return QuizShowScreen(
                    quizService: QuizService(),
                    chapterId: widget.chapter.id!,
                  );
                }));
              },
              icon: const Icon(Icons.radio_button_on_rounded),
            ),
          ],
        ),
        body: Center(
          child: Column(
            children: [
              Text(
                widget.chapter.chapterName,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(
                height: 18,
              ),
              Text(
                widget.chapter.chapterContent,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}