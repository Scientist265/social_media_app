import 'package:flutter/material.dart';
import 'package:social_media_app/utils/constants/colors.dart';

import '../constants/styling.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.controller,
    required this.hintText,
    this.suffixIcon,
    this.validator,
  });
  final TextEditingController? controller;
  final String hintText;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 14, horizontal: 15),
        suffixIcon: suffixIcon,
        hintText: hintText,
        hintStyle: Styles.hintTextStyle,
        fillColor: AppColors.fillColor,
      ),
    );
  }
}
