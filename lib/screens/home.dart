// ------------------------- Home Screen -------------------------
/*import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome to Diabetes Prediction App'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/progress'),
              child: Text('View Glucose Progress'),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: Text('Home'),
              onTap: () => Navigator.pushNamed(context, '/home'),
            ),
            ListTile(
              title: Text('Settings'),
              onTap: () => Navigator.pushNamed(context, '/settings'),
            ),
            ListTile(
              title: Text('Reminders'),
              onTap: () => Navigator.pushNamed(context, '/reminder'),
            ),
            ListTile(
              title: Text('Calendar'),
              onTap: () => Navigator.pushNamed(context, '/calendar'),
            ),
          ],
        ),
      ),
    );
  }
}*/

import 'package:flutter/material.dart';
import '../../widgets/medicine_card.dart';
import '../../widgets/info_card.dart';
import '../../widgets/bottom_nav_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8FB),
      body: SafeArea(
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
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                          Drawer(
                            child: IconButton(
                              icon: const Icon(Icons.menu),
                              onPressed: () {
                                Scaffold.of(context).openDrawer();
                              },
                            ),
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
                        image:
                            'https://th.bing.com/th/id/OIP.7wUZVSQeeRVJslI96gcTCAHaHa?w=217&h=216&c=7&r=0&o=5&pid=1.7',
                        title: 'Pills',
                        subtitle: 'Gestational',
                        frequency: '3 times',
                      ),
                      const SizedBox(height: 20),
                      const MedicineCard(
                        image:
                            'https://th.bing.com/th/id/OIP.7wUZVSQeeRVJslI96gcTCAHaHa?w=217&h=216&c=7&r=0&o=5&pid=1.7',
                        title: 'Glucose',
                        subtitle: 'Glucose Injection 5%',
                        frequency: '2 times',
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const BottomNavBar(),
          ],
        ),
      ),
    );
  }
}
