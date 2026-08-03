import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SearchTruckScreen extends StatefulWidget {
  const SearchTruckScreen({super.key});

  @override
  State<SearchTruckScreen> createState() => _SearchTruckScreenState();
}

class _SearchTruckScreenState extends State<SearchTruckScreen> {
  final pickupController = TextEditingController();
  final destinationController = TextEditingController();
  final weightController = TextEditingController();

  String selectedGoods = "Electronics";

  final goods = [
    "Electronics",
    "Furniture",
    "Food",
    "Construction",
    "Medicines",
    "Others",
  ];

  @override
  void dispose() {
    pickupController.dispose();
    destinationController.dispose();
    weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Truck"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: pickupController,
              decoration: const InputDecoration(
                labelText: "Pickup Location",
                prefixIcon: Icon(Icons.location_on),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: destinationController,
              decoration: const InputDecoration(
                labelText: "Destination",
                prefixIcon: Icon(Icons.flag),
              ),
            ),

            const SizedBox(height: 20),

            DropdownButtonFormField<String>(
              value: selectedGoods,
              decoration: const InputDecoration(
                labelText: "Goods Type",
              ),
              items: goods
                  .map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: Text(e),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedGoods = value!;
                });
              },
            ),

            const SizedBox(height: 20),

            TextField(
              controller: weightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Weight (kg)",
                prefixIcon: Icon(Icons.scale),
              ),
            ),

            const SizedBox(height: 35),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  context.go('/truck-list');
                },
                child: const Text("Find Trucks"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}