import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as user;
import 'package:social_media_app/views/pages/home_page.dart';
import 'package:social_media_app/views/pages/login_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
                return LoginPage(showRegisterPage: () {});
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
            return LoginPage(showRegisterPage: () {});
          }),
    );
  }
}

class Auth {
  Future signUserIn(context, String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      const Center(
        child: CircularProgressIndicator(),
      );
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
    } on FirebaseException catch (e) {
      Navigator.pop(context);
      wrongPassword_email(context, e.code);
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

  Future signUserUp(context, String email, String firstName, String lastName,
      String password, String confirmPassword, String address) async {
    if (passwordConfirmed(context, password, confirmPassword)) {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        // adding user details
        addUserDatails(firstName, lastName, email, address);
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
  Future addUserDatails(
      String firstName, String lastName, String email, String address) async {
    await FirebaseFirestore.instance.collection('users').add({
      'first name': firstName,
      'last name': lastName,
      'email': email,
      'address': address,
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
