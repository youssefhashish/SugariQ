import 'package:flutter/material.dart';
import '../widgets/app_theme.dart';
import '../splash/prediction_page.dart';

class HealthInfo extends StatefulWidget {
  const HealthInfo({super.key});

  @override
  State<HealthInfo> createState() => _HealthInfoState();
}

class _HealthInfoState extends State<HealthInfo> {
  String? gender;
  String? age;
  String? diabetesType;

  @override
  void initState() {
    super.initState();

    gender = PredictionScreen.lastGender;
    age = PredictionScreen.lastAge;
    diabetesType = PredictionScreen.lastDiabetesType;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Health Info',
          style: TextStyle(
            color: AppTheme.primary,
            fontSize: 22,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        constraints: const BoxConstraints(maxWidth: 480),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Your individual parameters are important for SugariQ for in-depth personalization.',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 30),
            Card(
              color: Colors.white,
              elevation: 2,
              child: ListTile(
                leading: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(8.0),
                  height: 55,
                  width: 55,
                  child:
                      const Icon(Icons.person_outline, color: Colors.black54),
                ),
                title: const Text('Gender'),
                trailing: Text(gender ?? 'Not set'),
                enabled: false,
              ),
            ),
            const SizedBox(height: 20),
            Card(
              color: Colors.white,
              elevation: 2,
              child: ListTile(
                leading: Container(
                  decoration: BoxDecoration(
                    color: Colors.purple.shade50,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(8.0),
                  height: 55,
                  width: 55,
                  child: const Icon(Icons.calendar_today_outlined,
                      color: Colors.black54),
                ),
                title: const Text('Age'),
                trailing: Text(age ?? 'Not set'),
                enabled: false,
              ),
            ),
            const SizedBox(height: 20),
            Card(
              color: Colors.white,
              elevation: 2,
              child: ListTile(
                leading: Container(
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(8.0),
                  height: 55,
                  width: 55,
                  child: const Icon(Icons.bloodtype_outlined,
                      color: Colors.black54),
                ),
                title: const Text('Diabetes type'),
                trailing: Text(diabetesType ?? 'Not set'),
                enabled: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
