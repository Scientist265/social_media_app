import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/utils/constants/colors.dart';
import 'package:social_media_app/utils/constants/sizing.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Changing User Profile Picture
  File? _image;
  Future getImagePicker() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final imgTemp = File(image.path);
    setState(() {
      _image = imgTemp;
    });
  }

  final currUser = FirebaseAuth.instance.currentUser!;
// edit field
  Future<void> editField(String field) async {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: AppColors.scaffoldBgColor,
        title: Center(
          child: Text(
            'Profile Page',
            style: TextStyle(color: AppColors.fillColor),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        children: [
          const SizedBox(
            height: 60,
          ),
          InkWell(
            onDoubleTap: () {
              getImagePicker();
            },
            child: CircleAvatar(
                radius: 70,
                child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: (_image != null)
                              ? FileImage(_image!) as ImageProvider
                              : const AssetImage(
                                  'lib/assets/images/person.png'),
                          fit: BoxFit.fill)),
                )),
          ),
          AppSizing.h05,
          Text(
            '${currUser.email}',
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.grey),
          ),
          Column(
            children: [
              const Text('My Details'),
              Container(
                child: const Row(
                  children: [
                    Column(
                      children: [Text('Username')],
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
