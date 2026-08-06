import 'package:flutter/material.dart';

class PaymentMethodTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const PaymentMethodTile({
    super.key,
    required this.title,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(18),
        margin: const EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
          color: selected ? Colors.blue.shade50 : Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: selected ? Colors.blue : Colors.grey.shade300,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 32,
              color: selected ? Colors.blue : Colors.grey,
            ),

            const SizedBox(width: 15),

            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            Icon(
              selected
                  ? Icons.radio_button_checked
                  : Icons.radio_button_off,
              color: Colors.blue,
            )
          ],
        ),
      ),
    );
  }
}