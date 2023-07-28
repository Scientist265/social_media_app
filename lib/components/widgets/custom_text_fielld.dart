import 'package:flutter/material.dart';
import 'package:social_media_app/components/constants/colors.dart';

TextFormField customTextField(
    TextEditingController? controller, String? hintText) {
  return TextFormField(
    controller: controller,
    maxLines: 8,
    minLines: 1,
    decoration: InputDecoration(
      hintText: hintText,
      fillColor: AppColors.textFieldBorder,
    ),
  );
}
