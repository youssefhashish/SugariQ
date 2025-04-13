// TODO Implement this library.
import 'package:flutter/material.dart';

class MedicineCard extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;
  final String frequency;

  const MedicineCard({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
    required this.frequency,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE7F1FF)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFE7F1FF),
            blurRadius: 40,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              'assets/logo.jpg',
              width: 94,
              height: 94,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'Convergence',
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontFamily: 'Airbnb Cereal App',
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 25),
                Text(
                  frequency,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontFamily: 'Airbnb Cereal App',
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
