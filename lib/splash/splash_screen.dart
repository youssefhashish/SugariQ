import 'package:flutter/material.dart';
import '../widgets/app_theme.dart';
import '../widgets/progress_indicator.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? gender;
  String? age;
  String? diabetesType;

  void _selectOption(
      String title, List<String> options, ValueChanged<String> onSelected) {
    showModalBottomSheet(
      context: context,
      builder: (context) => ListView(
        children: options.map((option) {
          return ListTile(
            title: Text(option),
            onTap: () {
              Navigator.pop(context);
              onSelected(option);
            },
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.fromLTRB(24, 80, 24, 32),
        constraints: const BoxConstraints(maxWidth: 480),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Progress Bar
            Positioned(
              top: 60,
              left: 68,
              child: SizedBox(
                width: 350,
                height: 6,
                child: CustomPaint(
                  painter: ProgressBarPainter(progress: 0.25), // 25% progress
                ),
              ),
            ),
            const SizedBox(height: 40),
            const Text(
              'Tell us about yourself',
              style: AppTheme.titleStyle,
            ),
            const SizedBox(height: 6),
            const Text(
              'Your individual parametres are important for SugariQ for indepth personalization.',
              style: AppTheme.subtitleStyle,
            ),
            const SizedBox(height: 46),
            _buildTile(
              icon: Icons.person_outline,
              iconBgColor: Colors.blue.shade50,
              title: 'Gender',
              value: gender ?? 'Select',
              onTap: () => _selectOption('Gender', ['Male', 'Female'], (val) {
                setState(() => gender = val);
              }),
            ),
            Divider(height: 40, thickness: 2, color: Colors.grey[300]),
            _buildTile(
              icon: Icons.calendar_today_outlined,
              iconBgColor: Colors.purple.shade50,
              title: 'Age',
              value: age ?? 'Select',
              onTap: () => _selectOption(
                  'Age', List.generate(100, (i) => '${i + 1}'), (val) {
                setState(() => age = val);
              }),
            ),
            Divider(height: 40, thickness: 2, color: Colors.grey[300]),
            _buildTile(
              icon: Icons.bloodtype_outlined,
              iconBgColor: Colors.red.shade50,
              title: 'Diabetes type',
              value: diabetesType ?? 'Select',
              onTap: () => _selectOption(
                  'Diabetes type', ['Type 1', 'Type 2', 'Gestational'], (val) {
                setState(() => diabetesType = val);
              }),
            ),
            const SizedBox(height: 180),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: const LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Color(0xFF6FBE5A), Color(0xFF85C26F)],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 44,
                ),
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/diabetesType');
                  },
                  child: const Text(
                    'Next',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'Convergence',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/prediction');
                },
                child: Text(
                  'You want to make sure if you have Diabetes or not?',
                  style: TextStyle(color: Color(0xFF1978B4)),
                )),
          ],
        ),
      ),
    );
  }
}

Widget _buildTile({
  required IconData icon,
  required Color iconBgColor,
  required String title,
  required String value,
  required VoidCallback onTap,
}) {
  return ListTile(
    leading: Container(
      decoration: BoxDecoration(
          color: iconBgColor,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10)),
      padding: const EdgeInsets.all(8.0),
      height: 55,
      width: 55,
      child: Icon(icon, color: Colors.black54),
    ),
    title: Text(title),
    trailing: TextButton(
      onPressed: onTap,
      child: Text(
        value,
        style: TextStyle(
          color: value == 'Select' ? Colors.blue : Colors.black,
        ),
      ),
    ),
  );
}
