import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/components/constants/colors.dart';
import 'package:social_media_app/components/constants/sizing.dart';

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
            style: TextStyle(color: AppColors.fillColor),
          ),
        ),
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 60,
          ),
          const Icon(
            Icons.person,
            size: 100,
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
