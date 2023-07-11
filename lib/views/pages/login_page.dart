import 'package:flutter/material.dart';
import 'package:social_media_app/components/constants/colors.dart';
import 'package:social_media_app/components/constants/sizing.dart';
import 'package:social_media_app/components/widgets/custom_button.dart';
import 'package:social_media_app/components/widgets/custom_text_fielld.dart';
import 'package:social_media_app/views/pages/auth_page.dart';
import 'package:social_media_app/views/routes/routes.dart';

import '../../components/constants/styling.dart';

// ignore: must_be_immutable
class LoginPage extends StatefulWidget {
  LoginPage({super.key, required this.showRegisterPage});
  VoidCallback showRegisterPage;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final auth = Auth();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBgColor,
      resizeToAvoidBottomInset: false,
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
                  customTextField(_emailController, 'enter your email'),
                  AppSizing.h20,
                  customTextField(_passwordController, 'enter your password'),
                  AppSizing.h25,
                  CustomButton(
                      buttonText: 'Login',
                      color: AppColors.buttonColor,
                      onTap: () {
                        auth.signUserIn(
                            context,
                            _emailController.text,
                            _passwordController
                                .text); // Navigator.push(context,
                        //     MaterialPageRoute(builder: (_) => const HomePage()));
                      }),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an account',
                        style: TextStyle(color: AppColors.textFieldBorder),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, signUpRoute);
                          },
                          child: Text(
                            'Register',
                            style: TextStyle(color: AppColors.buttonColor),
                          ))
                    ],
                  ),
                  AppSizing.h20,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
