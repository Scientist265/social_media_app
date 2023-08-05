import 'package:flutter/material.dart';

import '../../services/account_auth/sign_in.dart';
import '../../services/account_auth/sign_up.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/sizing.dart';

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
            automaticallyImplyLeading: false,
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
                  child: TabBarView(children: [
                    SignInTab(),
                    SignUpTab(),
                  ]),
                )
              ],
            ),
          ),
        ));
  }
}
