import 'package:flutter/material.dart';
import 'package:social_media_app/utils/constants/colors.dart';
import 'package:social_media_app/utils/constants/sizing.dart';

class MyTextBox extends StatelessWidget {
  const MyTextBox(
      {super.key,
      required this.text,
      required this.sectionName,
      required this.onTap});
  final String text;
  final String sectionName;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      decoration: BoxDecoration(
        color: AppColors.fillColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(text),
              AppSizing.h10,
              Text(sectionName),
            ],
          ),
          IconButton(onPressed: onTap, icon: const Icon(Icons.edit))
        ],
      ),
    );
  }
}
