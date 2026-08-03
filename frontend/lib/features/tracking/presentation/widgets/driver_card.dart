import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../provider/tracking_provider.dart';

class DriverCard extends ConsumerWidget {
  const DriverCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final driver = ref.watch(driverProvider);

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [

            const CircleAvatar(
              radius: 30,
              child: Icon(Icons.person, size: 35),
            ),

            const SizedBox(width: 15),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    driver.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),

                  Text(driver.truckNumber),

                  Row(
                    children: [
                      const Icon(Icons.star,
                          color: Colors.orange, size: 18),
                      const SizedBox(width: 4),
                      Text(driver.rating.toString()),
                    ],
                  ),
                ],
              ),
            ),

            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.call),
            ),

            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.chat),
            ),
          ],
        ),
      ),
    );
  }
}