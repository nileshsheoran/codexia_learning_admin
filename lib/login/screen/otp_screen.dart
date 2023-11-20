
import 'package:codexia_learning_admin/course/service/course_service.dart';
import 'package:codexia_learning_admin/course/ui/course_show_screen.dart';
import 'package:codexia_learning_admin/login/screen/phone_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    var code = '';
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.deepPurple,),
      body: Container(
        margin: const EdgeInsets.only(left: 25, right: 25),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/image/girl.jpg',
                height: 300,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Phone Verification',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'We need to register your phone before getting started',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 35,
              ),
              Pinput(
                onChanged: (value) {
                  code = value;
                },
                length: 6,
                showCursor: true,
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 45,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    try {
                      PhoneAuthCredential credential =
                          PhoneAuthProvider.credential(
                              verificationId: PhoneScreen.verify,
                              smsCode: code);
                      await auth.signInWithCredential(credential);
                     if(mounted){ Navigator.push(context,
                         MaterialPageRoute(builder: (context) {
                           return   ShowCourseScreen(courseService: CourseService(),);
                         }));
                     }
                    } catch (e) {
                      if (kDebugMode) {
                        print('wrong otp');
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Colors.green.shade600,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  child: const Text('Verify phone number'),
                ),
              ),
              Row(
                children: [
                  TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Edit phone number?',
                        style: TextStyle(color: Colors.black),
                      ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
