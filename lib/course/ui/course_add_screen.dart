import 'package:codexia_learning_admin/course/model/course_model.dart';
import 'package:codexia_learning_admin/course/service/course_service.dart';
import 'package:codexia_learning_admin/course/shared/app_const.dart';
import 'package:codexia_learning_admin/shared/colour_const.dart';
import 'package:flutter/material.dart';

class AddCourseScreen extends StatelessWidget {
  AddCourseScreen({super.key, required this.courseService});

  final CourseService courseService;

  final TextEditingController courseNameController = TextEditingController();
  final TextEditingController imgUrlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            AppConst.course,
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
              controller: courseNameController,
              decoration: const InputDecoration(labelText: AppConst.courseName),
            ),
            TextField(
              controller: imgUrlController,
              decoration: const InputDecoration(labelText: AppConst.imgUrl),
            ),
            const SizedBox(
              height: 26,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                onPressed: () {
                  Course course = Course(
                    courseName: courseNameController.text,
                    imgUrl: imgUrlController.text,
                  );
                  courseService.addCourse(course);
                  Navigator.pop(context);
                },
                child: const Text(
                  AppConst.add,
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
