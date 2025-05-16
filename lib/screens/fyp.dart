import 'package:flutter/material.dart';

class ForYouPage extends StatelessWidget {
  const ForYouPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8FB),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'For You 🩺',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: const [
          SectionTitle(title: '✅ Diabetes Prevention Tips'),
          TipCard(
            image: 'assets/balanced_diet.jpeg',
            title: 'Eat a Balanced Diet',
            description:
                'Reduce sugar and saturated fats. Focus on vegetables, fruits, and fiber.',
          ),
          TipCard(
            image: 'assets/stay_active.jpeg',
            title: 'Stay Physically Active',
            description:
                '30 minutes of daily activity improves insulin sensitivity.',
          ),
          TipCard(
            image: 'assets/healthy_weight.jpeg',
            title: 'Maintain a Healthy Weight',
            description:
                'Weight management is key to preventing type 2 diabetes.',
          ),
          SectionTitle(title: '🩺 Managing Diabetes'),
          TipCard(
            image: 'assets/glucose_monitor.jpeg',
            title: 'Monitor Your Blood Glucose',
            description:
                'Track your glucose levels daily using a glucose meter.',
          ),
          TipCard(
            image: 'assets/medication.jpeg',
            title: 'Follow Medication & Insulin Plans',
            description: 'Stick to your prescribed treatment and dosage.',
          ),
          TipCard(
            image: 'assets/checkup.jpeg',
            title: 'Routine Health Checkups',
            description:
                'Regular visits to check eyes, kidneys, feet, and blood pressure.',
          ),
          SectionTitle(title: '🏋️‍♂️ Recommended Exercises'),
          TipCard(
            image: 'assets/brisk_walk.jpeg',
            title: 'Brisk Walking',
            description:
                'Helps reduce blood glucose levels and improve fitness.',
          ),
          TipCard(
            image: 'assets/yoga.jpeg',
            title: 'Yoga or Stretching',
            description: 'Lowers stress and supports glucose control.',
          ),
          TipCard(
            image: 'assets/cycling.jpeg',
            title: 'Cycling or Swimming',
            description: 'Great for joints and improves circulation.',
          ),
        ],
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.purple,
        ),
      ),
    );
  }
}

class TipCard extends StatelessWidget {
  final String title;
  final String description;
  final String image;

  const TipCard({
    super.key,
    required this.title,
    required this.description,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.asset(
              image,
              height: 160,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 6),
                Text(description,
                    style:
                        const TextStyle(fontSize: 14, color: Colors.black87)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
