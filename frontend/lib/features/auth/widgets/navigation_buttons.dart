import 'package:flutter/material.dart';

class NavigationButtons extends StatelessWidget {
  final bool lastPage;
  final VoidCallback onNext;
  final VoidCallback onSkip;
  final VoidCallback onFinish;

  const NavigationButtons({
    super.key,
    required this.lastPage,
    required this.onNext,
    required this.onSkip,
    required this.onFinish,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: onSkip,
          child: const Text("Skip", style: TextStyle(fontSize: 16)),
        ),

        ElevatedButton(
          onPressed: lastPage ? onFinish : onNext,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xff2563EB),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          child: Text(
            lastPage ? "Get Started" : "Next",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
