import 'package:flutter/material.dart';

import '../pages/auth_page.dart';
import '../pages/home_page.dart';
import '../pages/login_page.dart';
import '../pages/signup_page.dart';
import '../pages/welcome_page.dart';

Map<String, Widget Function(dynamic context)> routes = {
  signUpRoute: (context) => SignUp(showLoginPage: () {}),
  welcomepageRoute: (context) => const WelcomePage(),
  authRoute: (context) => const AuthPage(),
  loginRoute: (context) => LoginPage(showRegisterPage: () {}),
  homeRoute :(context) => const HomePage()
};
String splashRoute = '/splash_route';
String loginRoute = '/login_page';
String signUpRoute = '/sign_up';
String welcomepageRoute = '/welcome_page';
String authRoute = '/auth_page';
String homeRoute = 'home_page';
