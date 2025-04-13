import 'package:flutter/material.dart';
import '../../widgets/medicine_card.dart';
import '../../widgets/info_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),
                    // Header Section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.person),
                            const SizedBox(width: 22),
                            Text(
                              'Hi, Sophia',
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'Convergence',
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    // Info Card
                    const InfoCard(),
                    const SizedBox(height: 30),
                    // Medicines Section
                    const Text(
                      'Medicines 💊',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Convergence',
                      ),
                    ),
                    const SizedBox(height: 23),
                    const MedicineCard(
                      image: '',
                      title: 'Pills',
                      subtitle: 'Gestational',
                      frequency: '3 times',
                    ),
                    const SizedBox(height: 20),
                    const MedicineCard(
                      image: '',
                      title: 'Glucose',
                      subtitle: 'Glucose Injection 5%',
                      frequency: '2 times',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
