import 'package:flutter/material.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _image;
  String? profileImageUrl;

  @override
  void initState() {
    super.initState();
    fetchProfileImage();
  }

  Future<void> fetchProfileImage() async {
    // هنا هنفترض أنه يتم جلب صورة البروفايل عبر API
    final user = 'user_id_here';  // تحديد معرف المستخدم
    try {
      final response = await http.get(
        Uri.parse('http://apis.mohamedelenany.com/public/api/profile/$user'),
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          profileImageUrl = data['profile_image'];  // تعديل بناءً على البنية الحقيقية للـ API
        });
      } else {
        print('❌ فشل تحميل صورة البروفايل');
      }
    } catch (e) {
      print('❌ فشل تحميل صورة البروفايل: $e');
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return;
    File imageFile = File(pickedFile.path);

    // هنا بنرفع الصورة عبر الـ API
    final String userId = 'user_id_here'; // تحديد معرف المستخدم
    final String url = 'http://apis.mohamedelenany.com/public/api/update-profile-image';

    try {
      final request = http.MultipartRequest('POST', Uri.parse(url))
        ..fields['user_id'] = userId
        ..files.add(await http.MultipartFile.fromPath('image', imageFile.path));

      final response = await request.send();

      if (response.statusCode == 200) {
        // إذا كانت الصورة قد تم رفعها بنجاح
        final responseBody = await http.Response.fromStream(response);
        final data = json.decode(responseBody.body);
        setState(() {
          profileImageUrl = data['profile_image']; // تعديل بناءً على الـ API
          _image = imageFile;
        });
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('✅ تم حفظ الصورة بنجاح!')));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('❌ فشل في رفع الصورة: ${response.statusCode}')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('❌ فشل في رفع الصورة: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    List<Color> backgroundColors = isDarkMode
        ? [const Color(0xff975b03), const Color(0xFF6a1b9a), Colors.black, Colors.black]
        : [const Color(0xff4673a1), const Color(0xff73a3d6), const Color(0xff73acea), const Color(0xff1e548e)];

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: backgroundColors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: backgroundColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: _image != null
                      ? FileImage(_image!)
                      : profileImageUrl != null
                      ? NetworkImage(profileImageUrl!) as ImageProvider
                      : const AssetImage("assets/images/profile.jpg"),
                ),
              ),
              const SizedBox(height: 20),
              // استبدال بالكود الذي يجلب معلومات المستخدم من الـ API
              Text(
                "User Email", // استبدال بـ البريد الإلكتروني الخاص بالمستخدم
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              ListTile(
                leading: const Icon(Icons.settings, color: Colors.blueAccent),
                title: const Text("Settings"),

              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.red),
                title: const Text("Logout"),
                onTap: () {
                  // تسجيل الخروج من الـ API
                  // سيتم تنفيذ التسجيل باستخدام الـ API هنا
                  Navigator.pushReplacementNamed(context, '/login');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
