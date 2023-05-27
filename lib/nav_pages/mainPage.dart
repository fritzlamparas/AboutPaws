import 'package:flutter/material.dart';
import 'package:aboutpaws/nav_pages/aboutUs.dart';
import 'package:aboutpaws/nav_pages/camera.dart';

class mainPage extends StatefulWidget {
  const mainPage({super.key});

  @override
  State<mainPage> createState() => _mainPageState();
}

class _mainPageState extends State<mainPage> {
  List pages = [
    const cameraPage(),
    const AboutUsPage(),
  ];
  int currentIndex = 0;
  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTap,
        currentIndex: currentIndex,
        selectedItemColor: const Color.fromRGBO(1, 3, 41, 1.0),
        unselectedItemColor: const Color.fromRGBO(59, 59, 59, 1.0),
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_filled,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_4_outlined,
            ),
            label: 'About Us',
          ),
        ],
      ),
    );
  }
}
