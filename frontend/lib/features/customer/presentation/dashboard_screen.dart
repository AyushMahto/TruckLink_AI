// import 'package:flutter/material.dart';

// class DashboardScreen extends StatelessWidget {
//   const DashboardScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: Center(
//         child: Text(
//           "Customer Dashboard",
//           style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

import '../widgets/home_appbar.dart';
import '../widgets/location_card.dart';
import '../widgets/search_button.dart';
import '../widgets/truck_category.dart';
import '../widgets/ai_recommendation_card.dart';
import '../widgets/recent_shipments.dart';
import '../widgets/stats_card.dart';
import '../widgets/bottom_navbar.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  bottomNavigationBar: const BottomNavbar(),
      backgroundColor: const Color(0xffF5F7FB),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              HomeAppBar(),

              SizedBox(height: 30),

              LocationCard(),

              SizedBox(height: 25),

              SearchButton(),

              SizedBox(height: 30),

              TruckCategory(),

              SizedBox(height: 30),

              AIRecommendationCard(),
              const SizedBox(height: 30),

              Row(
              children: const [
              StatsCard(
              title: "Trips",
              value: "128",
              icon: Icons.route,
              color: Colors.blue,
              ),
              
              StatsCard(
              title: "Saved",
              value: "₹18K",
              icon: Icons.savings,
              color: Colors.green,
              ),
              ],
              ),

              const SizedBox(height: 30),

              SizedBox(height: 30),

              RecentShipments(),
            ],
          ),
        ),
      ),
    );
  }
}
