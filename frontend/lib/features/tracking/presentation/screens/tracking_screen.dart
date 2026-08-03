// import 'package:flutter/material.dart';

// class TrackingScreen extends StatelessWidget {
//   const TrackingScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Live Tracking"),
//       ),
//       body: const Center(
//         child: Text(
//           "Google Maps Coming Next 📍",
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

import '../widgets/bottom_action_bar.dart';
import '../widgets/driver_card.dart';
import '../widgets/eta_card.dart';
import '../widgets/tracking_map.dart';
import '../widgets/trip_status_card.dart';

class TrackingScreen extends StatelessWidget {
  const TrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Live Tracking"),
        centerTitle: true,
      ),

      bottomNavigationBar: const BottomActionBar(),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: const Column(
          children: [

            TrackingMap(),

            SizedBox(height: 20),

            DriverCard(),

            SizedBox(height: 20),

            EtaCard(),

            SizedBox(height: 20),

            TripStatusCard(),

          ],
        ),
      ),
    );
  }
}