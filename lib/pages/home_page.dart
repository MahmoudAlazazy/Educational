import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import '../data/category_data.dart';
import '../widget/category_icon.dart';
import '../widget/course_slider.dart';
import '../widget/header_text_field.dart';
import '../widget/tag.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: appBar(),
      body: ListView(
        children: [
          Column(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      // تم حذف searchBox هنا
                      HeaderTextField(title: "Categories"),
                      const SizedBox(height: 10),
                      categorySlider(),
                      HeaderTextField(
                        title: "Courses For You",
                        child: Tag(title: "Your Topics"),
                      ),
                      const CourseSlider(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container categorySlider() {
    return Container(
      height: 100,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: categoryData.length,
        itemBuilder: (BuildContext context, int index) {
          return CategoryIcon(category: categoryData[index]);
        },
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      backgroundColor: Colors.black,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: SizedBox(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hello ,AzaZy,",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 22,
                      ),
                    ),
                    Text(
                      "Learn something new everyday",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(7),
                      margin: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            spreadRadius: 2,
                            blurStyle: BlurStyle.outer,
                          )
                        ],
                      ),
                      child: const Icon(
                        IconlyLight.notification,
                        size: 26,
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 8,
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
