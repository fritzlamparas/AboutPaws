import 'package:flutter/material.dart';
import 'package:aboutpaws/nav_pages/aboutUs.dart';
import 'package:aboutpaws/nav_pages/camera.dart';

class mainPage extends StatefulWidget {
  const mainPage({super.key});

  @override
  State<mainPage> createState() => _mainPageState();
}

class _mainPageState extends State<mainPage> {
  final List<Widget> pages = [
    const cameraPage(),
    const AboutUsPage(),
  ];
  int currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'AboutPaws requires an internet connection to get the latest updates.',
              style: TextStyle(
                color: Color.fromRGBO(248, 248, 248, 1.0),
                fontWeight: FontWeight.bold,
                fontSize: 15,
              )),
          backgroundColor: Color.fromRGBO(59, 59, 59, 1.0),
          duration: Duration(seconds: 5),
        ),
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void onTap(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text(
          "AboutPaws",
          style: TextStyle(
              color: Color.fromRGBO(248, 248, 248, 1.0),
              fontFamily: "NunitoBold"),
        ),
        backgroundColor: const Color.fromRGBO(198, 142, 77, 1.0),
        shadowColor: const Color.fromRGBO(248, 248, 248, 1.0),
      ),
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTap,
        backgroundColor: const Color.fromRGBO(198, 142, 77, 1.0),
        currentIndex: currentIndex,
        selectedItemColor: const Color.fromRGBO(248, 248, 248, 1.0),
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
              Icons.person,
            ),
            label: 'About Us',
          ),
        ],
      ),
    );
  }
}
