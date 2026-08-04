import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TruckCard extends StatelessWidget {
  final Map<String, dynamic> truck;

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
                        truck["truckName"] ?? "",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text("Type : ${truck["truckType"]}"),

                      Text("Capacity : ${truck["capacity"]} kg"),

                      Text("Location : ${truck["currentLocation"]}"),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 18),

            Text(
              "₹ ${truck["pricePerKm"]} / km",
              style: const TextStyle(
                fontSize: 22,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text("Driver : ${truck["driverName"]}"),

            Text("Phone : ${truck["driverPhone"]}"),

            const SizedBox(height: 18),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
               onPressed: () {
  context.push(
    "/booking-summary",
    extra: truck,
  );
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