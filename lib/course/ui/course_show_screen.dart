import 'package:codexia_learning_admin/chapter/service/chapter_service.dart';
import 'package:codexia_learning_admin/chapter/ui/chapter_show_screen.dart';
import 'package:codexia_learning_admin/course/model/course_model.dart';
import 'package:codexia_learning_admin/course/service/course_service.dart';
import 'package:codexia_learning_admin/course/shared/app_const.dart';
import 'package:codexia_learning_admin/course/ui/course_add_screen.dart';
import 'package:codexia_learning_admin/course/ui/course_update_screen.dart';
import 'package:codexia_learning_admin/shared/colour_const.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ShowCourseScreen extends StatefulWidget {
  final CourseService courseService;

  const ShowCourseScreen({required this.courseService, super.key});

  @override
  ShowCourseScreenState createState() => ShowCourseScreenState();
}

class ShowCourseScreenState extends State<ShowCourseScreen> {
  final TextEditingController itemController = TextEditingController();

  bool isSearch = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddCourseScreen(
                courseService: widget.courseService,
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text(
          AppConst.course,
          style: TextStyle(
            fontSize: 26,
          ),
        ),
        backgroundColor: ColourConst.blue,
      ),
      body: StreamBuilder(
        stream: widget.courseService.getCourseStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<Course> courseList = [];
            DataSnapshot dataSnapshot = snapshot.data!.snapshot;
            final map = dataSnapshot.value as Map<dynamic, dynamic>;

            forEach(map, courseList);
            return Padding(
              padding: const EdgeInsets.all(16),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                  mainAxisExtent: 200,
                ),
                itemCount: courseList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ShowChapterScreen(
                            chapterService: ChapterService(),
                            courseId: courseList[index].courseId!,
                          ),
                        ),
                      );
                    },
                    child: Card(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return CourseUpdateScreen(
                                        course: courseList[index],
                                        courseService: widget.courseService);
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
                                          content: const Text(
                                              'Are you sure you delete it'),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text('Cancel'),
                                            ),
                                            TextButton(
                                              onPressed: () async {
                                                await widget.courseService
                                                    .deleteCourse(
                                                        courseList[index]);
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
                    ],
                  ),
                              if (courseList[index].imgUrl.isNotEmpty)
                                Image.network(
                                  courseList[index].imgUrl,
                                  height: 110,
                                  width: 140,
                                  fit: BoxFit.cover,
                                ),
                              Text(
                                courseList[index].courseName,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }

  void forEach(Map<dynamic, dynamic> map, List<Course> courseList) {
    map.forEach((key, value) {
      var course = Course(
        courseId: key,
        courseName: value['courseName'] ?? '',
        imgUrl: value['imgUrl'] ?? '',
      );
      courseList.add(course);
    });
  }
}
