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
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          Image.network(
                            'https://www.bing.com/images/search?view=detailV2&ccid=sevp6lF4&id=EE25D4F47B067F64A4E9994F3283CE3F84B526AE&thid=OIP.sevp6lF4eIOWPnedYgeBogHaHa&mediaurl=https%3A%2F%2Fyoumatter.world%2Fapp%2Fuploads%2F2024%2F02%2F10-2.png&cdnurl=https%3A%2F%2Fth.bing.com%2Fth%2Fid%2FR.b1ebe9ea51787883963e779d620781a2%3Frik%3Dria1hD%252fOgzJPmQ%26pid%3DImgRaw%26r%3D0&exph=1080&expw=1080&q=ui+person+&simid=607986792549676268&form=IRPRST&ck=4A0C64353418FE67DBBB526269679807&selectedindex=25&itb=0&cw=1222&ch=585&ajaxhist=0&ajaxserp=0&cit=ccid_7WA6mH7o*cp_970B7152B8A94C3E26C84C5CDC4A9FBE*mid_EC3767893801A01DF477D2A947F5ED0A3E788E56*simid_608004337446959394*thid_OIP.7WA6mH7oqsGTo!_duc43GqwHaHa&vt=2',
                            width: 54,
                            height: 54,
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
