import 'package:flutter/material.dart';
import 'package:social_media_app/components/barcode_related/barcode_sacn_page.dart';

import '../../services/auth/auth_page.dart';
import '../../views/pages/home_page.dart';
import '../../views/pages/login_signUp.dart';
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

//Route Generator

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const WelcomePage());
      case '/second':
        //validation of correct data
        if (args is String) {
          return MaterialPageRoute(builder: (_) => const BarCodeScan());
        }
        return _errorRoute();
      default:
        return _errorRoute();
    }
  }
}

_errorRoute() {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Error'),
    ),
    body: const Center(
      child: Text('Error'),
    ),
  );
}
