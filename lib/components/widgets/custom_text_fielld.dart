import 'package:flutter/material.dart';
import 'package:social_media_app/components/constants/colors.dart';

TextFormField customTextField(
    TextEditingController? controller, String? hintText) {
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(
      hintText: hintText,
      fillColor: AppColors.textFieldBorder,
    ),
  );
}
