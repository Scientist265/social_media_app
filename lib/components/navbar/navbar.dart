import 'package:flutter/material.dart';

import 'package:social_media_app/views/add_page/home.dart';
import 'package:social_media_app/views/pages/home_page.dart';
import 'package:social_media_app/views/pages/profile_page.dart';

import '../../utils/constants/colors.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int selectedItem = 0;

  List<Widget> myWidgets = const [
    HomePage(),
    Home(),
    ProfilePage(),
  ];
  void onTapped(int index) {
    setState(() {
      selectedItem = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: myWidgets[selectedItem],
      bottomNavigationBar: BottomNavigationBar(
          onTap: onTapped,
          currentIndex: selectedItem,
          elevation: 2,
          selectedItemColor: AppColors.buttonColor,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          unselectedItemColor: const Color(0xff7443e3),
          selectedIconTheme: const IconThemeData(color: Colors.black),
          unselectedLabelStyle: const TextStyle(color: Colors.black),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'profile'),
          ]),
    );
  }
}
