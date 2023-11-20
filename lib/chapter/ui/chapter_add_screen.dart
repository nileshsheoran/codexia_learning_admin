import 'package:codexia_learning_admin/chapter/model/chapter_model.dart';
import 'package:codexia_learning_admin/chapter/service/chapter_service.dart';
import 'package:codexia_learning_admin/chapter/shared/string_const.dart';
import 'package:codexia_learning_admin/shared/colour_const.dart';
import 'package:flutter/material.dart';

class AddChapterScreen extends StatelessWidget {
  final String courseId;
  final TextEditingController chapterNameController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final ChapterService chapterService;

  AddChapterScreen({
    required this.courseId,
    required this.chapterService,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            StringConst.addChapter,
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
        backgroundColor: ColourConst.blue
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
                onPressed: () {
                  Chapter chapter = Chapter(
                    courseId: courseId,
                    chapterContent: contentController.text,
                    chapterName: chapterNameController.text,
                  );
                  chapterService.addChapter(chapter);
                  Navigator.pop(context);
                },
                child: const Text(
                  StringConst.add,
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),

    );
  }
}
