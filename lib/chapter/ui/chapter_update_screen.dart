import 'package:codexia_learning_admin/chapter/model/chapter_model.dart';
import 'package:codexia_learning_admin/chapter/service/chapter_service.dart';
import 'package:codexia_learning_admin/chapter/shared/string_const.dart';
import 'package:codexia_learning_admin/shared/colour_const.dart';
import 'package:flutter/material.dart';

class ChapterUpdateScreen extends StatefulWidget {
  final String courseId;
  final ChapterService chapterService;
  final Chapter chapter;

  const ChapterUpdateScreen(
      {required this.chapter,
      required this.courseId,
      required this.chapterService,
      super.key});

  @override
  State<ChapterUpdateScreen> createState() => _ChapterUpdateScreenState();
}

class _ChapterUpdateScreenState extends State<ChapterUpdateScreen> {
  TextEditingController chapterNameController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  @override
  void initState() {
    Chapter chapters = widget.chapter;
    chapterNameController =
        TextEditingController(text: chapters.chapterName.toString());
    contentController =
        TextEditingController(text: chapters.chapterContent.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            StringConst.updateChapter,
            style: TextStyle(),
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
        backgroundColor: ColourConst.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: chapterNameController,
              decoration: const InputDecoration(
                labelText: StringConst.chapterName,
              ),
            ),
            TextField(
              controller: contentController,
              decoration: const InputDecoration(
                labelText: StringConst.chapterContent,
              ),
            ),
            const SizedBox(
              height: 26,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                onPressed: () async {
                  Chapter chapter = Chapter(
                    courseId: widget.courseId,
                    chapterContent: contentController.text,
                    chapterName: chapterNameController.text,
                    id: widget.chapter.id,
                  );
                  await widget.chapterService.updateChapter(chapter);
                  if (mounted) {
                    Navigator.pop(context);
                  }
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      StringConst.update,
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
