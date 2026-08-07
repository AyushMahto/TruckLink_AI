import 'package:flutter/material.dart';

import '../widgets/bottom_action_bar.dart';
import '../widgets/driver_card.dart';
import '../widgets/eta_card.dart';
import '../widgets/tracking_map.dart';
import '../widgets/trip_status_card.dart';

class TrackingScreen extends StatelessWidget {
  final Map<String, dynamic> booking;

  const TrackingScreen({
    super.key,
    required this.booking,
  });

  @override
  Widget build(BuildContext context) {
    final pickup = booking["pickup"]?.toString() ?? "Pickup";

    final destination =
        booking["destination"]?.toString() ?? "Destination";

    final status =
        booking["status"]?.toString() ?? "Pending";

    final truck = booking["truck"];

    final truckName = truck is Map
        ? truck["truckName"]?.toString() ?? "Truck"
        : "Truck";

    final driverName = truck is Map
        ? truck["driverName"]?.toString() ?? "Driver"
        : "Driver";

    final driverPhone = truck is Map
        ? truck["driverPhone"]?.toString() ?? ""
        : "";

    return Scaffold(
      backgroundColor: const Color(0xffF5F7FB),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,

        title: const Text(
          "Live Tracking",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),

        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),

      bottomNavigationBar: const BottomActionBar(),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            // =========================
            // Route Header
            // =========================
            Row(
              children: [
                Expanded(
                  child: _location(
                    "Pickup",
                    pickup,
                    Colors.green,
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8,
                  ),
                  child: Icon(
                    Icons.arrow_forward,
                    color: Colors.blue,
                  ),
                ),

                Expanded(
                  child: _location(
                    "Destination",
                    destination,
                    Colors.red,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // =========================
            // Google Map
            // =========================
            TrackingMap(
              booking: booking,
            ),

            const SizedBox(height: 20),

            // =========================
            // Current Status
            // =========================
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),

              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor:
                        Colors.blue.withOpacity(0.1),

                    child: const Icon(
                      Icons.local_shipping,
                      color: Colors.blue,
                    ),
                  ),

                  const SizedBox(width: 14),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,

                      children: [
                        const Text(
                          "Booking Status",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),

                        const SizedBox(height: 4),

                        Text(
                          status,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  _statusBadge(status),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // =========================
            // Driver
            // =========================
            DriverCard(),

            const SizedBox(height: 20),

            // =========================
            // ETA
            // =========================
            EtaCard(),

            const SizedBox(height: 20),

            // =========================
            // Trip Status
            // =========================
            TripStatusCard(),

            const SizedBox(height: 20),

            // =========================
            // Truck Details
            // =========================
            Container(
              width: double.infinity,

              padding: const EdgeInsets.all(18),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [
                  const Text(
                    "Truck & Driver",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 15),

                  _detailRow(
                    Icons.local_shipping,
                    "Truck",
                    truckName,
                  ),

                  const SizedBox(height: 12),

                  _detailRow(
                    Icons.person,
                    "Driver",
                    driverName,
                  ),

                  if (driverPhone.isNotEmpty) ...[
                    const SizedBox(height: 12),

                    _detailRow(
                      Icons.phone,
                      "Phone",
                      driverPhone,
                    ),
                  ],
                ],
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _location(
    String title,
    String value,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [
          Row(
            children: [
              Icon(
                Icons.location_on,
                size: 18,
                color: color,
              ),

              const SizedBox(width: 5),

              Text(
                title,
                style: const TextStyle(
                  fontSize: 11,
                  color: Colors.grey,
                ),
              ),
            ],
          ),

          const SizedBox(height: 5),

          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,

            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _statusBadge(String status) {
    Color color;

    switch (status) {
      case "Accepted":
        color = Colors.green;
        break;

      case "Picked":
        color = Colors.orange;
        break;

      case "In Transit":
        color = Colors.blue;
        break;

      case "Delivered":
        color = Colors.teal;
        break;

      case "Cancelled":
      case "Rejected":
        color = Colors.red;
        break;

      default:
        color = Colors.amber.shade800;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
      ),

      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),

      child: Text(
        status,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _detailRow(
    IconData icon,
    String title,
    String value,
  ) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor:
              Colors.blue.withOpacity(0.1),

          child: Icon(
            icon,
            color: Colors.blue,
            size: 20,
          ),
        ),

        const SizedBox(width: 12),

        Expanded(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),

              const SizedBox(height: 3),

              Text(
                value,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}