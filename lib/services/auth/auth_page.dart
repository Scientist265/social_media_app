import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as user;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media_app/components/navbar/navbar.dart';
import 'package:social_media_app/config/loader.dart';
import 'package:social_media_app/config/routes/routes.dart';

import '../../views/pages/login_signUp.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<user.User?>(
          stream: user.FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return const LoginOrSignUp();
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error}'),
                );
              }
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return const LoginOrSignUp();
          }),
    );
  }
}

class Auth {
  // Sign User In
  Future signUserIn(context, String email, String password) async {
    try {
      loader(context);
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const NavBar()));
    } catch (err) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text(err.toString()),
              ));
      Navigator.pop(context);
    }
  }

  // display error message for wrong login details
  void wrongPassword_email(context, String errorMessage) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(errorMessage),
            ));
    Navigator.pop(context);
  }

  // display error message for wrong login details

  Future signUserUp(
      context,
      String email,
      String firstName,
      String lastName,
      String password,
      String confirmPassword,
      String address,
      String userName) async {
    final navigator = Navigator.pop(context);

    if (passwordConfirmed(
      context,
      password,
      confirmPassword,
    )) {
      loader(context);
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        navigator;

        // adding user details
        addUserDatails(
          firstName,
          lastName,
          email,
          address,
          userName,
        );

        Navigator.pushNamedAndRemoveUntil(context, homeRoute, (route) => false);
      } catch (err) {
        err.toString();
      }
      navigator;
    } else {
      showDialog(
          context: context,
          builder: (_) => const AlertDialog(
                content: Text('Password not match'),
              ));
      navigator;
    }
  }

// register user to the backend
  Future addUserDatails(String firstName, String lastName, String email,
      String address, String emailFirstCharacter) async {
    await FirebaseFirestore.instance.collection('users').add({
      'username': emailFirstCharacter,
      'first name': firstName,
      'last name': lastName,
      'email': email,
      'address': address,
      'bio': 'Emtpy bio..'
    });
  }

  // password confirmatiion for match up

  bool passwordConfirmed(context, String password, String confirmpassword) {
    if (password == confirmpassword) {
      return true;
    } else {
      return false;
    }
  }
}
