import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/components/constants/colors.dart';
import 'package:social_media_app/config/loader.dart';
import 'package:social_media_app/views/pages/auth_page.dart';

import '../../components/constants/sizing.dart';
import '../../components/constants/styling.dart';
import '../../components/widgets/custom_button.dart';
import '../../components/widgets/custom_text_fielld.dart';

// ignore: must_be_immutable

class SignUpTab extends StatefulWidget {
  const SignUpTab({
    super.key,
  });

  @override
  State<SignUpTab> createState() => _SignUpTabState();
}

class _SignUpTabState extends State<SignUpTab> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _addressController = TextEditingController();
  bool isLoading = true;
  final GlobalKey<FormState> _key = GlobalKey<FormState>(); // for validation
  final _auth = Auth();

  String errorMessage = '';
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _confirmPasswordController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: SizedBox(
        height: 200,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppSizing.h25,
              Text(
                'Sign Up ',
                style:
                    Styles.headLine.copyWith(color: Colors.white, fontSize: 30),
              ),
              AppSizing.h15,
              const Text(
                'First Name',
                style: TextStyle(color: Colors.white),
              ),
              AppSizing.h10,
              CustomTextField(
                hintText: 'Enter your First Name',
                controller: _firstNameController,
              ),
              AppSizing.h20,
              const Text(
                'Last Name',
                style: TextStyle(color: Colors.white),
              ),
              AppSizing.h10,
              CustomTextField(
                hintText: 'Enter your Last Name',
                controller: _lastNameController,
              ),
              AppSizing.h30,
              const Text(
                'Email',
                style: TextStyle(color: Colors.white),
              ),
              AppSizing.h10,
              CustomTextField(
                hintText: 'Enter your Email',
                controller: _emailController,
                validate: validateEmail,
              ),
              AppSizing.h30,
              const Text(
                'Password',
                style: TextStyle(color: Colors.white),
              ),
              AppSizing.h10,
              CustomTextField(
                hintText: 'Enter your Password',
                controller: _passwordController,
                validate: validatePassword,
                suffixIcon: Visibility(
                    child: Icon(
                  Icons.visibility_off,
                  color: AppColors.buttonColor,
                )),
              ),
              AppSizing.h30,
              const Text(
                'Confirm Password',
                style: TextStyle(color: Colors.white),
              ),
              AppSizing.h10,
              CustomTextField(
                hintText: ' confirm your password',
                controller: _confirmPasswordController,
              ),
              AppSizing.h30,
              const Text(
                'Address',
                style: TextStyle(color: Colors.white),
              ),
              AppSizing.h10,
              CustomTextField(
                hintText: 'Enter your address',
                controller: _addressController,
              ),
              Text(
                errorMessage,
                style: Styles.primaryTextStyle,
              ),
              AppSizing.h30,
              CustomButton(
                buttonText: ' Register',
                onTap: () async {
                  loader(context);
                  if (_key.currentState!.validate()) {
                    try {
                      _auth.signUserUp(
                          context,
                          _emailController.text,
                          _firstNameController.text,
                          _lastNameController.text,
                          _passwordController.text,
                          _confirmPasswordController.text,
                          _addressController.text,
                          _emailController.text.split('@')[0]);
                      errorMessage = '';
                    } on FirebaseAuthException catch (error) {
                      errorMessage = error.message!;
                   
                    }
                  }
                },
              ),
              AppSizing.h10,
              const Center(
                  child: Text(
                'or Sign Up with',
                style: TextStyle(color: Colors.grey),
              )),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    subButton('lib/assets/logo/fb.png', 'Facebook'),
                    const SizedBox(
                      width: 20,
                    ),
                    subButton('lib/assets/logo/google.jpeg', 'Google'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String? validateEmail(String? formEmail) {
  if (formEmail == null || formEmail.isEmpty) {
    return 'Email is required';
  }
  String pattern = r'\w+@\w+\.\w+';
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(formEmail)) return 'Invalid Email Address format';
  return null;
}

String? validatePassword(String? formPassword) {
  if (formPassword == null || formPassword.isEmpty) {
    return 'Password is required';
  }
  String pattern =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(formPassword)) {
    return '''
Invalid Password format
include an uppercase letter, number and symbol.
  ''';
  }
  return null;
}
