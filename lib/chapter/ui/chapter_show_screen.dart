import 'package:codexia_learning_admin/chapter/model/chapter_model.dart';
import 'package:codexia_learning_admin/chapter/service/chapter_service.dart';
import 'package:codexia_learning_admin/chapter/shared/string_const.dart';
import 'package:codexia_learning_admin/chapter/ui/chapter_add_screen.dart';
import 'package:codexia_learning_admin/chapter/ui/chapter_update_screen.dart';
import 'package:codexia_learning_admin/chapter/ui/chapter_detail_screen.dart';
import 'package:codexia_learning_admin/shared/colour_const.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ShowChapterScreen extends StatefulWidget {
  final ChapterService chapterService;
  final String courseId;

  const ShowChapterScreen({
    required this.chapterService,
    required this.courseId,
    super.key,
  });

  @override
  ShowChapterScreenState createState() => ShowChapterScreenState();
}

class ShowChapterScreenState extends State<ShowChapterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddChapterScreen(
                        courseId: widget.courseId,
                        chapterService: widget.chapterService,
                      )));
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text(
          StringConst.chapters,
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
        backgroundColor: ColourConst.blue,
      ),
      body: StreamBuilder(
        stream: widget.chapterService.getChapterStream(widget.courseId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<Chapter> chapterList = [];
            DataSnapshot dataSnapshot = snapshot.data!.snapshot;
            if (dataSnapshot.exists) {
              final map = dataSnapshot.value as Map<dynamic, dynamic>;

              map.forEach((key, value) {
                var chapter = Chapter(
                  id: value['id'] ?? '',
                  courseId: value['courseId'] ?? '',
                  chapterName: value['chapterName'] ?? '',
                  chapterContent: value['chapterContent'] ?? '',
                );
                chapterList.add(chapter);
              });
            }

            return ListView.builder(
              itemCount: chapterList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                    right: 20,
                    left: 20,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return ChapterDetailScreen(chapter: chapterList[index]);
                      }));
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return ChapterUpdateScreen(
                                      chapter: chapterList[index],
                                      courseId: widget.courseId,
                                      chapterService: widget.chapterService);
                                }));
                              },
                              icon: const Icon(Icons.edit),
                            ),
                            IconButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text('Delete '),
                                        content:
                                        const Text('Are you sure you delete it'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text('Cancel'),
                                          ),
                                          TextButton(
                                            onPressed: () async {
                                             await widget.chapterService.deleteChapter(chapterList[index]);
                                              if (mounted) {
                                                Navigator.pop(context);
                                              }
                                            },
                                            child: const Text('Delete'),
                                          ),
                                        ],
                                      );
                                    });

                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            ),
                            Text(
                              chapterList[index].chapterName,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 2,
                            ),
                          ],
                        ),
                        const Divider(),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
