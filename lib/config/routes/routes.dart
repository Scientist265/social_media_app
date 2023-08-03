import 'package:flutter/material.dart';

import '../../views/pages/auth_page.dart';
import '../../views/pages/home_page.dart';
import '../../views/pages/login_page.dart';
import '../../views/pages/signup_page.dart';
import '../../views/pages/welcome_page.dart';

Map<String, Widget Function(dynamic context)> routes = {
  signUpRoute: (context) => const LoginOrSignUp(),
  welcomepageRoute: (context) => const WelcomePage(),
  authRoute: (context) => const AuthPage(),
  loginRoute: (context) => const LoginOrSignUp(),
  homeRoute: (context) => const HomePage(),
  authPagesTabRoute: (context) => const LoginOrSignUp()
};
String splashRoute = '/splash_route';
String loginRoute = '/login_page';
String signUpRoute = '/sign_up';
String welcomepageRoute = '/welcome_page';
String authRoute = '/auth_page';
String homeRoute = 'home_page';
String authPagesTabRoute = 'login_or_sign';
