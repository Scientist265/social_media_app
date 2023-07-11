import 'package:flutter/material.dart';
import 'package:social_media_app/components/constants/colors.dart';
import 'package:social_media_app/components/widgets/custom_button.dart';
import 'package:social_media_app/views/routes/routes.dart';

import '../../components/constants/styling.dart';

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
