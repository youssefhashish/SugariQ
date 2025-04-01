import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:sugar_iq/profile%20page/profile.dart';
import 'package:sugar_iq/screens/home.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          child: CurvedNavigationBar(
            index: 0,
            buttonBackgroundColor: Color(0xFF85C26F),
            height: 60,
            backgroundColor: Colors.transparent,
            items: [
              CurvedNavigationBarItem(
                child: Icon(Icons.home),
                label: 'Home',
              ),
              CurvedNavigationBarItem(
                child: Icon(Icons.food_bank),
                label: 'Meals',
              ),
              CurvedNavigationBarItem(
                child: Icon(Icons.medical_information),
                label: 'For You',
              ),
              CurvedNavigationBarItem(
                child: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
            onTap: (index) {
              if (index == 0) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              } /*else if (index == 1) {
                 Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => /*meal page()*/),
                );
              } */
              /*else if (index == 2) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => /*For you page()*/),
                );
              } */
              else if (index == 3) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfilePage()));
              }
            },
          ),
        ),
      ],
    );
  }
}
