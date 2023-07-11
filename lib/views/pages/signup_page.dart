import 'package:flutter/material.dart';
import 'package:social_media_app/views/pages/auth_page.dart';

import '../../components/constants/colors.dart';
import '../../components/constants/sizing.dart';
import '../../components/constants/styling.dart';
import '../../components/widgets/custom_button.dart';
import '../../components/widgets/custom_text_fielld.dart';

// ignore: must_be_immutable
class SignUp extends StatefulWidget {
  SignUp({super.key, required this.showLoginPage});
  VoidCallback showLoginPage;

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _addressController = TextEditingController();
  final _auth = Auth();

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
    return Scaffold(
      backgroundColor: AppColors.scaffoldBgColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15.0,
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  Icon(
                    Icons.lock,
                    size: 100,
                    color: AppColors.textFieldBorder,
                  ),
                  AppSizing.h40,
                  Text('Welcome Back ',
                      style: Styles.headLine
                          .copyWith(color: AppColors.scaffoldColor)),
                  const SizedBox(
                    height: 100,
                  ),
                  customTextField(
                      _firstNameController, 'enter your first name'),
                  AppSizing.h20,
                  customTextField(_lastNameController, 'enter your last name'),
                  AppSizing.h20,
                  customTextField(_emailController, 'enter your email'),
                  AppSizing.h20,
                  customTextField(_passwordController, 'enter your password'),
                  AppSizing.h20,
                  customTextField(
                      _confirmPasswordController, 'confirm your password'),
                  AppSizing.h20,
                  customTextField(_addressController, 'enter your address'),
                  AppSizing.h25,
                  CustomButton(
                      buttonText: 'Register',
                      color: AppColors.buttonColor,
                      onTap: () async{
                        _auth.signUserUp(
                          context,
                          _emailController.text,
                          _firstNameController.text,
                          _lastNameController.text,
                          _passwordController.text,
                          _confirmPasswordController.text,
                          _addressController.text,
                        ); // Navigator.push(context,
                        //     MaterialPageRoute(builder: (_) => const HomePage()));
                      })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
