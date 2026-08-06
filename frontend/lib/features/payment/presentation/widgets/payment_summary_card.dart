import 'package:flutter/material.dart';

class PaymentSummaryCard extends StatelessWidget {
  final double amount;

  const PaymentSummaryCard({
    super.key,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Row(
              children: [
                Icon(Icons.receipt_long),
                SizedBox(width: 10),
                Text(
                  "Payment Summary",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                )
              ],
            ),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Truck Charges"),
                Text("₹${amount.toStringAsFixed(0)}"),
              ],
            ),

            const SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Platform Fee"),
                Text("₹50"),
              ],
            ),

            const Divider(height: 30),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Total",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Text(
                  "₹${(amount + 50).toStringAsFixed(0)}",
                  style: const TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

