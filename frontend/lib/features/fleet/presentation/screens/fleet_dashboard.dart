import 'package:flutter/material.dart';

class FleetDashboard extends StatelessWidget {
  const FleetDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FB),

      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          "Fleet Dashboard",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 15),
            child: CircleAvatar(
              child: Icon(Icons.business),
            ),
          )
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              "Welcome Fleet Owner 👋",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 25),

            Row(
              children: [

                Expanded(
                  child: _statCard(
                    "Total Trucks",
                    "18",
                    Icons.local_shipping,
                  ),
                ),

                const SizedBox(width: 15),

                Expanded(
                  child: _statCard(
                    "Drivers",
                    "26",
                    Icons.people,
                  ),
                ),

              ],
            ),

            const SizedBox(height: 20),

            Row(
              children: [

                Expanded(
                  child: _statCard(
                    "Active Trips",
                    "11",
                    Icons.route,
                  ),
                ),

                const SizedBox(width: 15),

                Expanded(
                  child: _statCard(
                    "Revenue",
                    "₹2.8L",
                    Icons.currency_rupee,
                  ),
                ),

              ],
            ),

            const SizedBox(height: 30),

            _menuCard(
              Icons.local_shipping,
              "Manage Trucks",
              "Add or remove trucks",
            ),

            _menuCard(
              Icons.people,
              "Manage Drivers",
              "View all drivers",
            ),

            _menuCard(
              Icons.analytics,
              "Analytics",
              "Business reports",
            ),

            _menuCard(
              Icons.assignment,
              "Bookings",
              "Monitor deliveries",
            ),

            _menuCard(
              Icons.settings,
              "Company Settings",
              "Profile & preferences",
            ),
          ],
        ),
      ),
    );
  }

  Widget _statCard(String title, String value, IconData icon) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            Icon(icon, size: 35),
            const SizedBox(height: 10),
            Text(
              value,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(title),
          ],
        ),
      ),
    );
  }

  Widget _menuCard(
    IconData icon,
    String title,
    String subtitle,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 18),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: ListTile(
        leading: CircleAvatar(
          child: Icon(icon),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}