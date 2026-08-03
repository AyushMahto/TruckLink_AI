import 'package:flutter/material.dart';

class TruckCategory extends StatelessWidget {
  const TruckCategory({super.key});

  final List<Map<String, dynamic>> trucks = const [
    {"icon": Icons.fire_truck, "title": "Mini"},
    {"icon": Icons.local_shipping, "title": "Pickup"},
    {"icon": Icons.airport_shuttle, "title": "LCV"},
    {"icon": Icons.rv_hookup, "title": "HCV"},
    {"icon": Icons.local_shipping_outlined, "title": "Trailer"},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Truck Categories",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 15),

        SizedBox(
          height: 110,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: trucks.length,
            itemBuilder: (context, index) {
              final truck = trucks[index];

              return Container(
                width: 95,
                margin: const EdgeInsets.only(right: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: .05),
                      blurRadius: 15,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(truck["icon"], size: 34, color: Colors.blue),
                    const SizedBox(height: 10),
                    Text(
                      truck["title"],
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
