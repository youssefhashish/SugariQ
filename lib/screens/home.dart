/*import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/medicine_card.dart';
import '../../widgets/info_card.dart';
import '../components/mdecine_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final meds = Provider.of<MedicationProvider>(context).medications;

    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Reminder'),
              onTap: () {
                Navigator.pushNamed(context, '/reminder');
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('My Report'),
              onTap: () {
                Navigator.pushNamed(context, '/progress');
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
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
                      const InfoCard(),
                      const SizedBox(height: 30),
                      const Text(
                        'Medicines 💊',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Convergence',
                        ),
                      ),
                      const SizedBox(height: 23),
                      ...meds.map(
                        (med) => Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: MedicineCard(
                            image: '',
                            title: med.name,
                            subtitle: med.times
                                .map((t) => t.format(context))
                                .join(', '),
                            frequency: '${med.timesPerDay} times',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sugar_iq/screens/saved_meals.dart';
import 'package:sugar_iq/widgets/chatbot_FAB.dart';
import '../../widgets/medicine_card.dart';
import '../../widgets/info_card.dart';
import '../components/mdecine_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _infoCardRefreshKey = 0;

  void _refreshInfoCard() {
    setState(() {
      _infoCardRefreshKey++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final meds = Provider.of<MedicationProvider>(context).medications;

    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Menu',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.black54),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
            _buildDrawerItem(Icons.bar_chart, 'MY REPORT', () {
              Navigator.pushNamed(context, '/progress');
            }),
            _buildDrawerItem(Icons.notifications_none_outlined, 'REMINDERS',
                () {
              Navigator.pushNamed(context, '/reminder');
            }),
            _buildDrawerItem(Icons.bookmark_border, 'SAVED MEAL', () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => SavedMealsPage(
                    onMealsUpdated: _refreshInfoCard,
                  ),
                ),
              );
            }),
            const Divider(),
            _buildDrawerItem(Icons.settings_outlined, 'SETTINGS', () {
              Navigator.pushNamed(context, '/settings');
            }),
            _buildDrawerItem(Icons.headset_mic_outlined, 'HELP & CENTER', () {
              // TODO: Navigate to Help & Center screen
            }),
            _buildDrawerItem(Icons.info_outline, 'ABOUT', () {
              // TODO: Navigate to About screen
            }),
          ],
        ),
      ),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.person),
                              const SizedBox(width: 22),
                              Text(
                                'Hi, Youssef',
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
                      InfoCard(key: ValueKey(_infoCardRefreshKey)),
                      const SizedBox(height: 30),
                      const Text(
                        'Medicines 💊',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Convergence',
                        ),
                      ),
                      const SizedBox(height: 23),
                      ...meds.map(
                        (med) => Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: MedicineCard(
                            image: '',
                            title: med.name,
                            subtitle: med.times
                                .map((t) => t.format(context))
                                .join(', '),
                            frequency: '${med.timesPerDay} times',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: ChatBotButton(),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.black54),
      title: Text(title,
          style: const TextStyle(color: Colors.black87, fontSize: 16)),
      onTap: onTap,
    );
  }
}
