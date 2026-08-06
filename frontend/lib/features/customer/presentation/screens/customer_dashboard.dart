import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/widgets/dashboard_card.dart';

class CustomerDashboard extends StatelessWidget {
  const CustomerDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FB),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          "TruckLink AI",
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
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Welcome 👋",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 5),

            const Text(
              "Book trucks faster with AI",
              style: TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 30),

            const DashboardCard(
              icon: Icons.search,
              title: "Search Truck",
              subtitle: "Find nearby trucks",
              route: "/search-truck",
            ),

            const SizedBox(height: 15),

            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: ListTile(
                leading: const CircleAvatar(
                  child: Icon(Icons.local_shipping),
                ),
                title: const Text(
                  "My Bookings",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: const Text(
                  "Track all your bookings",
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  size: 18,
                ),
                onTap: () {
                  context.push("/my-bookings");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}