import 'package:flutter/material.dart';

class AIRecommendationCard extends StatelessWidget {
  const AIRecommendationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xff2563EB), Color(0xff1D4ED8)],
        ),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text("🤖 AI Recommendation", style: TextStyle(color: Colors.white70)),
          SizedBox(height: 15),
          Text(
            "Mini Truck",
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            "Estimated Fare: ₹1,450\nETA: 2h 30m",
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
