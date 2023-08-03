import 'package:flutter/material.dart';
import 'package:social_media_app/components/constants/colors.dart';

class CustomButton extends StatelessWidget {
  CustomButton(
      {super.key,
      required this.buttonText,
      this.color,
      this.isColor = true,
    
      required this.onTap});
  final String buttonText;
  final VoidCallback onTap;

  Color? color = AppColors.buttonColor;
  bool isColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
              color: AppColors.buttonColor,
              borderRadius: BorderRadius.circular(10)),
          child: Center(
                  child: Text(
                    buttonText,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                )
             ),
    );
  }
}

Widget subButton(String logoPath, String name) {
  return Expanded(
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      margin: const EdgeInsets.symmetric(vertical: 10),
      height: 50,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.asset(logoPath),
          ),
          Text(
            name,
            style: const TextStyle(fontSize: 18),
          )
        ],
      ),
    ),
  );
}
