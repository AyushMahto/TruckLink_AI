// import 'package:flutter/material.dart';

// class TruckListScreen extends StatelessWidget {
//   const TruckListScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Available Trucks"),
//       ),
//       body: const Center(
//         child: Text(
//           "Truck List Coming Next 🚚",
//           style: TextStyle(
//             fontSize: 22,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import '../../../../services/truck_service.dart';
import '../widgets/truck_card.dart';

class TruckListScreen extends StatefulWidget {
  const TruckListScreen({super.key});

  @override
  State<TruckListScreen> createState() => _TruckListScreenState();
}

class _TruckListScreenState extends State<TruckListScreen> {
  final TruckService truckService = TruckService();

  List<dynamic> trucks = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadTrucks();
  }

  Future<void> loadTrucks() async {
    final data = await truckService.getAvailableTrucks();

    setState(() {
      trucks = data;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Available Trucks"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: "Search Truck",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey.shade100,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.filter_alt),
                    label: const Text("Filter"),
                  ),
                ),

                const SizedBox(width: 15),

                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.sort),
                    label: const Text("Sort"),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Expanded(
              child: isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : trucks.isEmpty
                      ? const Center(
                          child: Text(
                            "No Trucks Available",
                            style: TextStyle(fontSize: 18),
                          ),
                        )
                      : ListView.builder(
                          itemCount: trucks.length,
                          itemBuilder: (context, index) {
                            return TruckCard(
                              truck: trucks[index],
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}