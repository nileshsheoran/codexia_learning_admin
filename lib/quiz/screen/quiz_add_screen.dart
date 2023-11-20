import 'package:codexia_learning_admin/quiz/model/quiz_model.dart';
import 'package:codexia_learning_admin/quiz/service/quiz_service.dart';
import 'package:flutter/material.dart';

class QuizAddScreen extends StatefulWidget {
  final String chapterId;
  final QuizService quizService;

  const QuizAddScreen(
      {required this.quizService, required this.chapterId, super.key});

  @override
  State<QuizAddScreen> createState() => _QuizAddScreenState();
}

class _QuizAddScreenState extends State<QuizAddScreen> {
  TextEditingController questionController = TextEditingController();
  TextEditingController option1Controller = TextEditingController();
  TextEditingController option2Controller = TextEditingController();
  TextEditingController option3Controller = TextEditingController();
  TextEditingController option4Controller = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String selectedOption = '';
  bool isAnswerCorrect = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add Quiz'),
          backgroundColor: Colors.green,
        ),
        body: Form(
          key: formKey,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextFormField(
                      controller: questionController,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Question required';
                        }
                      },
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), labelText: 'Question'),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    TextFormField(
                      controller: option1Controller,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Option1 required';
                        }
                      },
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), labelText: 'Option1'),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    TextFormField(
                      controller: option2Controller,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Option2 required';
                        }
                      },
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), labelText: 'Option2'),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    TextFormField(
                      controller: option3Controller,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Option3 required';
                        }
                      },
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), labelText: 'Option3'),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    TextFormField(
                      controller: option4Controller,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Option4 required';
                        }
                      },
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), labelText: 'Option4'),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState?.validate() ?? false) {
                          Quiz quiz = Quiz(
                              chapterId: widget.chapterId,
                              question: questionController.text,
                              option1: option1Controller.text,
                              option2: option2Controller.text,
                              option3: option3Controller.text,
                              option4: option4Controller.text,
                              correctOption: selectedOption);
                          widget.quizService.addQuiz(quiz);
                          Navigator.pop(context);
                        }
                      },
                      child: const Text('Add'),
                    ),
                    Row(
                      children: [
                        Row(
                          children: [
                            Radio<String>(
                              value: 'A',
                              groupValue: selectedOption,
                              onChanged: (value) {
                                setState(() {
                                  selectedOption = value!;
                                });
                              },
                            ),
                            const Text('Option A'),
                            Radio<String>(
                              value: 'B',
                              groupValue: selectedOption,
                              onChanged: (value) {
                                setState(() {
                                  selectedOption = value!;
                                });
                              },
                            ),
                            const Text('Option B'),
                            Radio<String>(
                              value: 'C',
                              groupValue: selectedOption,
                              onChanged: (value) {
                                setState(() {
                                  selectedOption = value!;
                                });
                              },
                            ),
                            const Text('Option C'),
                            Radio<String>(
                              value: 'D',
                              groupValue: selectedOption,
                              onChanged: (value) {
                                setState(() {
                                  selectedOption = value!;
                                });
                              },
                            ),
                            const Text('Option D'),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
