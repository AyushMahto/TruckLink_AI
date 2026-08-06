import 'package:flutter/material.dart';
import '../../../../services/booking_service.dart';

class DriverDashboard extends StatefulWidget {
  const DriverDashboard({super.key});

  @override
  State<DriverDashboard> createState() => _DriverDashboardState();
}

class _DriverDashboardState extends State<DriverDashboard> {
  final BookingService bookingService = BookingService();

  List bookings = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadBookings();
  }

  Future<void> loadBookings() async {
    try {
      final data = await bookingService.getPendingBookings();

      setState(() {
        bookings = data;
        loading = false;
      });

      print("=================================");
      print("Pending Bookings Loaded");
      print(bookings);
      print("=================================");
    } catch (e) {
      setState(() {
        loading = false;
      });

      print(e);
    }
  }

  Future<void> updateStatus(String bookingId, String status) async {
    final success = await bookingService.updateBookingStatus(
      bookingId,
      status,
    );

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Booking $status")),
      );

      loadBookings();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Something went wrong"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FB),

      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          "Driver Dashboard",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 15),
            child: CircleAvatar(
              child: Icon(Icons.person),
            ),
          )
        ],
      ),

      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Welcome Driver 👋",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 25),

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Pending Trips",
                          style: TextStyle(
                            color: Colors.white70,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          bookings.length.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),

                  if (bookings.isEmpty)
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 60),
                        child: Text(
                          "No Pending Bookings",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                  ...bookings.map((booking) {
                    return Card(
                      margin: const EdgeInsets.only(bottom: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(18),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              booking["customer"]["fullName"],
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 12),

                            Text(
                              "Truck : ${booking["truck"]["truckName"]}",
                            ),

                            Text(
                              "Pickup : ${booking["pickup"]}",
                            ),

                            Text(
                              "Destination : ${booking["destination"]}",
                            ),

                            Text(
                              "Goods : ${booking["goodsType"]}",
                            ),

                            Text(
                              "Weight : ${booking["weight"]} kg",
                            ),

                            Text(
                              "Price : ₹${booking["totalPrice"]}",
                            ),

                            const SizedBox(height: 20),

                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green,
                                    ),
                                    onPressed: () {
                                      updateStatus(
                                        booking["_id"],
                                        "Accepted",
                                      );
                                    },
                                    child: const Text(
                                      "Accept",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),

                                const SizedBox(width: 10),

                                Expanded(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                    ),
                                    onPressed: () {
                                      updateStatus(
                                        booking["_id"],
                                        "Rejected",
                                      );
                                    },
                                    child: const Text(
                                      "Reject",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
    );
  }
}