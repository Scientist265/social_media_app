import 'package:flutter/material.dart';

loader(context) {
  return showDialog(
    context: context,
    builder: (context) => const Center(
      child: CircularProgressIndicator(
        color: Colors.white,
      ),
    ),
  );
}
