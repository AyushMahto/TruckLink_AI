import 'package:flutter/material.dart';

class TripStatusCard extends StatelessWidget {
  const TripStatusCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: const Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [

            ListTile(
              leading: Icon(Icons.check_circle, color: Colors.green),
              title: Text("Driver Assigned"),
            ),

            ListTile(
              leading: Icon(Icons.radio_button_checked,
                  color: Colors.orange),
              title: Text("Truck On The Way"),
            ),

            ListTile(
              leading: Icon(Icons.radio_button_unchecked),
              title: Text("Goods Picked Up"),
            ),

            ListTile(
              leading: Icon(Icons.radio_button_unchecked),
              title: Text("Delivered"),
            ),
          ],
        ),
      ),
    );
  }
}