import 'package:flutter/material.dart';
import 'package:social_media_app/components/constants/colors.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

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
