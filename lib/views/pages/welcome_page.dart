import 'package:flutter/material.dart';
import 'package:social_media_app/components/constants/colors.dart';
import 'package:social_media_app/components/widgets/custom_button.dart';
import 'package:social_media_app/views/pages/signup_page.dart';
import 'package:social_media_app/config/routes/routes.dart';

import '../../components/constants/sizing.dart';
import '../../components/constants/styling.dart';
import 'login_page.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.scaffoldColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'Explore the DevWorld to stay updated in Tech Threads',
              textAlign: TextAlign.center,
              style: Styles.headLine,
            ),
            const SizedBox(
              height: 100,
            ),
            Container(
              height: MediaQuery.of(context).size.height * .5,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.secondaryColor,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40)),
              ),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 50.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomButton(
                      buttonText: 'login',
                      onTap: () {
                        Navigator.pushNamed(context, loginRoute);
                      },
                    ),
                    CustomButton(
                      buttonText: 'Register',
                      color: Colors.white,
                      isColor: false,
                      onTap: () {
                        Navigator.pushNamed(context, signUpRoute);
                      },
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
class LoginOrSignUp extends StatelessWidget {
  const LoginOrSignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: AppColors.darkColor,
          appBar: AppBar(
            elevation: 0,
            leading: const Icon(Icons.close),
            backgroundColor: AppColors.darkColor,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              children: [
                AppSizing.h35,
                Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                      color: AppColors.fillColor,
                      borderRadius: BorderRadius.circular(15)),
                  child: TabBar(
                      indicator: BoxDecoration(
                          color: AppColors.buttonColor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                      indicatorColor: AppColors.fillColor,
                      tabs: const [
                        Tab(
                          text: 'Sign In',
                        ),
                        Tab(
                          text: 'Sign Up',
                        )
                      ]),
                ),
                AppSizing.h15,
                const Expanded(
                  child: TabBarView(children: [SignInTab(), SignUpTab()]),
                )
              ],
            ),
          ),
        ));
  }
}

