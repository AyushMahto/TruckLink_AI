import 'package:flutter/material.dart';

class RecentShipments extends StatelessWidget {
  const RecentShipments({super.key});

  @override
  Widget build(BuildContext context) {
    final shipments = ["Pune → Mumbai", "Delhi → Jaipur", "Nagpur → Nashik"];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Recent Shipments",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 15),

        ...shipments.map(
          (trip) => Card(
            child: ListTile(
              leading: const Icon(Icons.local_shipping),
              title: Text(trip),
              trailing: const Icon(Icons.arrow_forward_ios),
            ),
          ),
        ),
      ],
    );
  }
}
