import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BookingSummaryScreen extends StatelessWidget {
  final Map<String, dynamic> truck;

  const BookingSummaryScreen({
    super.key,
    required this.truck,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Booking Summary"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      truck["truckName"],
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text("Driver : ${truck["driverName"]}"),
                    Text("Phone : ${truck["driverPhone"]}"),
                    Text("Type : ${truck["truckType"]}"),
                    Text("Capacity : ${truck["capacity"]} kg"),
                    Text("Location : ${truck["currentLocation"]}"),

                    const SizedBox(height: 15),

                    Text(
                      "₹ ${truck["pricePerKm"]} / km",
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  context.push("/payment");
                },
                child: const Text("Continue to Payment"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}