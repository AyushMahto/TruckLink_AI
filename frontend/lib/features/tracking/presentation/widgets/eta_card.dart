import 'package:flutter/material.dart';

class EtaCard extends StatelessWidget {
  const EtaCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue.shade50,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: const Padding(
        padding: EdgeInsets.all(18),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [

            Column(
              children: [
                Icon(Icons.access_time),
                SizedBox(height: 6),
                Text("ETA"),
                Text(
                  "2 hrs",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),

            Column(
              children: [
                Icon(Icons.route),
                SizedBox(height: 6),
                Text("Distance"),
                Text(
                  "48 km",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}