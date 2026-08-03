// import 'package:flutter/material.dart';

// class BookingSummaryScreen extends StatelessWidget {
//   const BookingSummaryScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Booking Summary"),
//       ),
//       body: const Center(
//         child: Text(
//           "Booking Summary Screen",
//           style: TextStyle(
//             fontSize: 24,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BookingSummaryScreen extends StatelessWidget {
  const BookingSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const double truckFare = 1450;
    const double gst = 261;
    const double platformFee = 49;
    const double total = truckFare + gst + platformFee;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Booking Summary"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              child: const ListTile(
                leading: Icon(Icons.location_on, color: Colors.green),
                title: Text("Pickup"),
                subtitle: Text("Pune Railway Station"),
              ),
            ),

            const SizedBox(height: 15),

            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              child: const ListTile(
                leading: Icon(Icons.flag, color: Colors.red),
                title: Text("Destination"),
                subtitle: Text("Mumbai Port"),
              ),
            ),

            const SizedBox(height: 20),

            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              child: const ListTile(
                leading: Icon(Icons.local_shipping),
                title: Text("Mini Truck"),
                subtitle: Text("800 KG • ETA 2 Hours"),
                trailing: Text(
                  "₹1450",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Price Details",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 15),

            _priceRow("Truck Fare", truckFare),
            _priceRow("GST", gst),
            _priceRow("Platform Fee", platformFee),

            const Divider(height: 35),

            _priceRow(
              "Total",
              total,
              bold: true,
            ),

            const SizedBox(height: 40),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  context.go('/payment');
                },
                child: const Text(
                  "Proceed to Payment",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _priceRow(
    String title,
    double amount, {
    bool bold = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontWeight:
                    bold ? FontWeight.bold : FontWeight.normal,
                fontSize: bold ? 18 : 16,
              ),
            ),
          ),
          Text(
            "₹${amount.toStringAsFixed(0)}",
            style: TextStyle(
              fontWeight:
                  bold ? FontWeight.bold : FontWeight.normal,
              fontSize: bold ? 18 : 16,
            ),
          ),
        ],
      ),
    );
  }
}