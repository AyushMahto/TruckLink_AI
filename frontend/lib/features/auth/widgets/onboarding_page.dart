import 'package:flutter/material.dart';

import '../models/onboarding_model.dart';

class OnboardingPage extends StatelessWidget {
  final OnboardingModel model;

  const OnboardingPage({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(35),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),

          Container(
            height: 220,
            width: 220,
            decoration: BoxDecoration(
              color: const Color(0xff2563EB),
              borderRadius: BorderRadius.circular(35),
            ),
            child: const Icon(
              Icons.local_shipping_rounded,
              color: Colors.white,
              size: 120,
            ),
          ),

          const SizedBox(height: 60),

          Text(
            model.title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 20),

          Text(
            model.description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 17,
              color: Colors.grey,
              height: 1.5,
            ),
          ),

          const Spacer(),
        ],
      ),
    );
  }
}
