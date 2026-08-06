import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../services/booking_service.dart';

class MyBookingsScreen extends StatefulWidget {
  const MyBookingsScreen({super.key});

  @override
  State<MyBookingsScreen> createState() => _MyBookingsScreenState();
}

class _MyBookingsScreenState extends State<MyBookingsScreen> {
  final BookingService bookingService = BookingService();

  List bookings = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadBookings();
  }

  Future<void> loadBookings() async {
    final prefs = await SharedPreferences.getInstance();
    final customerId = prefs.getString("userId");

    if (customerId == null) {
      setState(() {
        loading = false;
      });
      return;
    }

    final data = await bookingService.getCustomerBookings(customerId);

    setState(() {
      bookings = data;
      loading = false;
    });
  }

  Color statusColor(String status) {
    switch (status) {
      case "Accepted":
        return Colors.green;
      case "Rejected":
        return Colors.red;
      default:
        return Colors.orange;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Bookings"),
      ),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : bookings.isEmpty
              ? const Center(
                  child: Text(
                    "No bookings found",
                    style: TextStyle(fontSize: 18),
                  ),
                )
              : RefreshIndicator(
                  onRefresh: loadBookings,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(15),
                    itemCount: bookings.length,
                    itemBuilder: (context, index) {
                      final booking = bookings[index];
                      final truck = booking["truck"];

                      return Card(
                        margin: const EdgeInsets.only(bottom: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                truck["truckName"],
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 8),

                              Text("Truck Type : ${truck["truckType"]}"),

                              Text(
                                  "Driver : ${truck["driverName"]}"),

                              Text(
                                  "Pickup : ${booking["pickup"]}"),

                              Text(
                                  "Destination : ${booking["destination"]}"),

                              Text(
                                  "Goods : ${booking["goodsType"]}"),

                              Text(
                                  "Weight : ${booking["weight"]} Kg"),

                              Text(
                                  "Price : ₹${booking["totalPrice"]}"),

                              const SizedBox(height: 10),

                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 15,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: statusColor(
                                    booking["status"],
                                  ),
                                  borderRadius:
                                      BorderRadius.circular(20),
                                ),
                                child: Text(
                                  booking["status"],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
    );
  }
}