// TODO Implement this library.
import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 37, vertical: 25),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0x33D7D7D7),
            blurRadius: 30,
            offset: Offset(0, -20),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(
                colors: [Color(0xFF6FBE5A), Color(0xFF85C26F)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                stops: [0.0, 1.0],
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.home_outlined),
                const SizedBox(width: 10),
                const Text(
                  'Home',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Airbnb Cereal App',
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 44),
          Icon(Icons.fastfood_outlined),
          const SizedBox(width: 44),
          Container(
            width: 24,
            height: 24,
            color: Colors.transparent,
          ),
          const SizedBox(width: 44),
          Container(
            width: 24,
            height: 24,
            color: Colors.transparent,
          ),
        ],
      ),
    );
  }
}
