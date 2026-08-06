import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../services/auth_service.dart';
import '../../../../services/booking_service.dart';

class BookingSummaryScreen extends StatefulWidget {
  final Map<String, dynamic> truck;

  const BookingSummaryScreen({super.key, required this.truck});

  @override
  State<BookingSummaryScreen> createState() => _BookingSummaryScreenState();
}

class _BookingSummaryScreenState extends State<BookingSummaryScreen> {
  final BookingService bookingService = BookingService();
  final AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Booking Summary")),
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
                      widget.truck["truckName"],
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text("Driver : ${widget.truck["driverName"]}"),
                    Text("Phone : ${widget.truck["driverPhone"]}"),
                    Text("Type : ${widget.truck["truckType"]}"),
                    Text("Capacity : ${widget.truck["capacity"]} kg"),
                    Text("Location : ${widget.truck["currentLocation"]}"),

                    const SizedBox(height: 15),

                    Text(
                      "₹ ${widget.truck["pricePerKm"]} / km",
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
                onPressed: () async {
                  // Get logged-in customer ID
                  final customerId = await authService.getUserId();

                  print("=================================");
                  print("Customer ID: $customerId");
                  print("Truck ID: ${widget.truck["_id"]}");
                  print("Truck Data: ${widget.truck}");
                  print("=================================");

                  if (customerId == null || customerId.isEmpty) {
                    if (!mounted) return;

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Please login again.")),
                    );
                    return;
                  }

                  final result = await bookingService.createBooking(
                    customerId: customerId,
                    truckId: widget.truck["_id"].toString(),
                    pickup: "Pune",
                    destination: "Mumbai",
                    goodsType: "Electronics",
                    weight: 100,
                    totalPrice: (widget.truck["pricePerKm"] as num).toDouble(),
                  );

                  print("Booking Response: $result");

                  if (!mounted) return;

                  if (result["success"] == true) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text("Booking Created Successfully"),
    ),
  );

  context.push(
    "/payment",
    extra: (widget.truck["pricePerKm"] as num).toDouble(),
  );
} else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(result["message"] ?? "Booking Failed"),
                      ),
                    );
                  }
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
