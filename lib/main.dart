import 'package:edux/Login&signup/login.dart';
import 'package:edux/Login&signup/profile.dart';
import 'package:edux/courses/mycourses.dart';
import 'package:edux/pages/course_deatail_page.dart';
import 'package:edux/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MainTabBarPage(),
      routes: {
        CourseDetailPage.routeName: (ctx) => const CourseDetailPage(),
      },
    ),
  );
}

class MainTabBarPage extends StatefulWidget {
  const MainTabBarPage({super.key});

  @override
  State<MainTabBarPage> createState() => _MainTabBarPageState();
}

class _MainTabBarPageState extends State<MainTabBarPage> {
  int selectedIndex = 2;
  static List<Widget> tabBarPages = [
    const HomePage(),
    const HomePage(),
    const HomePage(),
    ProfileScreen(),
  ];

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
      // إضافة شرط لتوجيه المستخدم إلى صفحة تسجيل الدخول عند الضغط على Profile
      if (index == 2) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabBarPages[selectedIndex],
      bottomNavigationBar: bottomNavigationBar(context),
    );
  }

  BottomNavigationBar bottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.black,
      unselectedItemColor: Colors.grey,
      selectedItemColor: Colors.white,
      currentIndex: selectedIndex,
      onTap: onItemTapped,
      items: [
        BottomNavigationBarItem(icon: Icon(IconlyBold.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(IconlyBold.bookmark), label: "My Courses"),
        BottomNavigationBarItem(icon: Icon(IconlyBold.profile), label: "Profile"),
      ],
    );
  }
}
