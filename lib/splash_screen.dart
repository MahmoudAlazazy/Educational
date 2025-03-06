import 'dart:async';
import 'package:flutter/material.dart';
import 'package:edux/pages/home_page.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = "routeName";

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // التنقل إلى الشاشة الرئيسية بعد فترة تأخير
    Timer(Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage( ) ), // استخدم MaterialPageRoute هنا
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 300, // تعديل الحجم ليناسب الشاشة
              width: double.infinity,
              child: Image.asset(
                'assets/images/splash.png', // المسار الصحيح للصورة
                fit: BoxFit.cover, // لتغطية المساحة بالكامل
              ),
            ),
          ],
        ),
      ),
    );
  }
}
