import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/utils/constants/colors.dart';
import 'package:social_media_app/config/loader.dart';
import 'package:social_media_app/services/auth/auth_page.dart';

import '../../config/validation/validation.dart';
import '../../utils/constants/sizing.dart';
import '../../utils/constants/styling.dart';
import '../../utils/widgets/custom_button.dart';
import '../../utils/widgets/custom_text_fielld.dart';


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
                validator: validateText,
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
                validator: validateText,
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
                validator: validateEmail,
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
                validator: validatePassword,
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
                validator: validateText,
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
                  setState(() {
                    errorMessage = '';
                  });
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
