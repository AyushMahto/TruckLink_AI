import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../data/models/truck_model.dart';
import 'ai_badge.dart';

class TruckCard extends StatelessWidget {
  final TruckModel truck;

  const TruckCard({
    super.key,
    required this.truck,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 18),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (truck.recommended) const AIBadge(),

            if (truck.recommended) const SizedBox(height: 12),

            Row(
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Icon(
                    Icons.local_shipping,
                    size: 40,
                    color: Colors.blue,
                  ),
                ),

                const SizedBox(width: 18),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        truck.name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text("Capacity : ${truck.capacity}"),

                      Text("ETA : ${truck.eta}"),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 18),

            Text(
              "₹ ${truck.price.toStringAsFixed(0)}",
              style: const TextStyle(
                fontSize: 24,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 18),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  context.go('/booking-summary');
                },
                child: const Text("Book Now"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}