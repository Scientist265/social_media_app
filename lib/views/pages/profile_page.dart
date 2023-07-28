import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/components/constants/colors.dart';

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
    );
  }
}
