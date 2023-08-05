import 'package:flutter/material.dart';
import 'package:social_media_app/utils/constants/colors.dart';
import 'package:social_media_app/utils/constants/sizing.dart';
import 'package:social_media_app/utils/widgets/custom_button.dart';
import 'package:social_media_app/utils/widgets/custom_text_fielld.dart';
import 'package:social_media_app/services/auth/auth_page.dart';

import '../../config/validation/validation.dart';
import '../../utils/constants/styling.dart';

class SignInTab extends StatefulWidget {
  const SignInTab({
    super.key,
  });

  @override
  State<SignInTab> createState() => _SignInTabState();
}

class _SignInTabState extends State<SignInTab> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final auth = Auth();
  bool isRemember = false;
  bool isHidden = false;
  void isPassHidden() {
    setState(() {
      isHidden = !isHidden;
    });
  }

  String errorMessage = '';
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
                'Sign in ',
                style:
                    Styles.headLine.copyWith(color: Colors.white, fontSize: 30),
              ),
              AppSizing.h15,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Email',
                    style: TextStyle(color: Colors.white),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text('Sign in with mobile',
                        style: Styles.primaryTextStyle
                            .copyWith(color: AppColors.buttonColor)),
                  ),
                ],
              ),
              CustomTextField(
                hintText: 'Enter your email',
                controller: _emailController,
                validator: validateEmail,
              ),
              AppSizing.h40,
              const Text(
                'Password',
                style: TextStyle(color: Colors.white),
              ),
              AppSizing.h10,
              CustomTextField(
                  obscure: isHidden,
                  hintText: 'Enter your password',
                  validator: validatePassword,
                  controller: _passwordController,
                  suffixIcon: IconButton(
                      onPressed: isPassHidden,
                      icon: isHidden
                          ? Icon(
                              Icons.visibility,
                              color: AppColors.buttonColor,
                            )
                          : Icon(
                              Icons.visibility_off,
                              color: AppColors.buttonColor,
                            ))),
              AppSizing.h10,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: () {},
                      child: Text('Forgot Password',
                          style: Styles.primaryTextStyle
                              .copyWith(color: AppColors.buttonColor))),
                  Switch(
                      inactiveTrackColor: Colors.teal,
                      activeTrackColor: AppColors.buttonColor,
                      value: isRemember,
                      onChanged: (val) {
                        setState(() {
                          isRemember = !isRemember;
                        });
                      })
                ],
              ),
              AppSizing.h45,
              AppSizing.h10,
              CustomButton(
                buttonText: 'Sign in',
                onTap: () {
                  // loader(context);

                  if (_key.currentState!.validate()) {
                    auth.signUserIn(context, _emailController.text,
                        _passwordController.text);
                  }
                },
              ),
              AppSizing.h15,
              Text(
                errorMessage,
                style: const TextStyle(color: Colors.white),
              ),
              const Center(
                  child: Text(
                'or login with',
                style: TextStyle(color: Colors.grey),
              )),
              AppSizing.h15,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  subButton('lib/assets/logo/fb.png', 'Facebook'),
                  const SizedBox(
                    width: 20,
                  ),
                  subButton('lib/assets/logo/google.jpeg', 'Google'),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
