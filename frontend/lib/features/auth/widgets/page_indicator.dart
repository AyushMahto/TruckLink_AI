import 'package:flutter/material.dart';

class PageIndicator extends StatelessWidget {
  final bool active;

  const PageIndicator({super.key, required this.active});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 8,
      width: active ? 30 : 8,
      decoration: BoxDecoration(
        color: active ? const Color(0xff2563EB) : Colors.grey.shade300,
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}
