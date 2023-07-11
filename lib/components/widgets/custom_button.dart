import 'package:flutter/material.dart';
import 'package:social_media_app/components/constants/colors.dart';

class CustomButton extends StatelessWidget {
  CustomButton(
      {super.key, required this.buttonText, this.color, this.isColor = true, required this.onTap});
  final String buttonText;
  final VoidCallback onTap;
  Color? color = AppColors.darkColor;
  bool isColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
            color: color ?? AppColors.darkColor,
            borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: Text(
            buttonText,
            style: TextStyle(
                color: isColor ? Colors.white : Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
