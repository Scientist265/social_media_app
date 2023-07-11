import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/components/constants/colors.dart';
import 'package:social_media_app/components/constants/sizing.dart';
import 'package:social_media_app/components/text_box.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
            style: TextStyle(color: AppColors.textFieldBorder),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        children: [
          //profile picture
          Container(
            padding: const EdgeInsets.all(10),
            decoration:
                const BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
            child: const Icon(
              Icons.person,
              size: 64,
            ),
          ),
          AppSizing.h20,
          // User email
          Text(
            "${currUser.email}",
            style: const TextStyle(fontSize: 18, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          MyTextBox(
            text: 'devScientist',
            sectionName: 'Hammed ibraheem Omowumi',
            onTap: () {
              editField('edit field');
            },
          ),
          AppSizing.h30,
          MyTextBox(
            text: 'empty bio',
            sectionName: 'bio',
            onTap: () {
              editField('edit field');
            },
          )
        ],
      ),
    );
  }
}
