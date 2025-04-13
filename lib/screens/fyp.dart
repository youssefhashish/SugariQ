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
            imageUrl:
                'https://images.unsplash.com/photo-1549576490-b0b4831ef60a',
            title: 'Eat a Balanced Diet',
            description:
                'Reduce sugar and saturated fats. Focus on vegetables, fruits, and fiber.',
          ),
          TipCard(
            imageUrl:
                'https://images.unsplash.com/photo-1598970434795-0c54fe7c0642',
            title: 'Stay Physically Active',
            description:
                '30 minutes of daily activity improves insulin sensitivity.',
          ),
          TipCard(
            imageUrl:
                'https://images.unsplash.com/photo-1588776814546-ec7b9b7f1755',
            title: 'Maintain a Healthy Weight',
            description:
                'Weight management is key to preventing type 2 diabetes.',
          ),
          SectionTitle(title: '🩺 Managing Diabetes'),
          TipCard(
            imageUrl:
                'https://images.unsplash.com/photo-1606811842433-09cdddf7e470',
            title: 'Monitor Your Blood Glucose',
            description:
                'Track your glucose levels daily using a glucose meter.',
          ),
          TipCard(
            imageUrl:
                'https://images.unsplash.com/photo-1611078489935-0cb9644f28bd',
            title: 'Follow Medication & Insulin Plans',
            description: 'Stick to your prescribed treatment and dosage.',
          ),
          TipCard(
            imageUrl:
                'https://images.unsplash.com/photo-1526256262350-7da7584cf5eb',
            title: 'Routine Health Checkups',
            description:
                'Regular visits to check eyes, kidneys, feet, and blood pressure.',
          ),
          SectionTitle(title: '🏋️‍♂️ Recommended Exercises'),
          TipCard(
            imageUrl:
                'https://images.unsplash.com/photo-1571019613578-2b53d505b0f2',
            title: 'Brisk Walking',
            description:
                'Helps reduce blood glucose levels and improve fitness.',
          ),
          TipCard(
            imageUrl:
                'https://images.unsplash.com/photo-1584467735871-86b1cdb2d1f5',
            title: 'Yoga or Stretching',
            description: 'Lowers stress and supports glucose control.',
          ),
          TipCard(
            imageUrl:
                'https://images.unsplash.com/photo-1605296867304-46d5465a13f1',
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
  final String imageUrl;

  const TipCard({
    super.key,
    required this.title,
    required this.description,
    required this.imageUrl,
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
            child: Image.network(
              imageUrl,
              height: 160,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                height: 160,
                color: Colors.grey[300],
                child: const Icon(Icons.broken_image),
              ),
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
