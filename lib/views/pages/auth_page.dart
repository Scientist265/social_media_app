import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as user;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media_app/config/loader.dart';
import 'package:social_media_app/views/pages/home_page.dart';
import 'package:social_media_app/views/pages/welcome_page.dart';

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
  Future signUserIn(context, String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
    } on FirebaseAuthException {
      wrongPassword_email(context, 'invalid email');
    }
  }

  // display error message for wrong login details
  wrongPassword_email(context, String errorMessage) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
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
        // adding user details
        addUserDatails(
          firstName,
          lastName,
          email,
          address,
          userName,
        );
        Navigator.push(context,
            MaterialPageRoute(builder: ((context) => const HomePage())));
      } catch (err) {
        err.toString();
      }
    } else {
      showDialog(
          context: context,
          builder: (_) => const AlertDialog(
                content: Text('Password not match'),
              ));
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
