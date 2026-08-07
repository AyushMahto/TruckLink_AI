import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:go_router/go_router.dart';
import '../../../../services/booking_service.dart';

class MyBookingsScreen extends StatefulWidget {
  const MyBookingsScreen({super.key});

  @override
  State<MyBookingsScreen> createState() => _MyBookingsScreenState();
}

class _MyBookingsScreenState extends State<MyBookingsScreen> {
  final BookingService bookingService = BookingService();

  List<dynamic> bookings = [];

  bool loading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    loadBookings();
  }

  // =========================
  // Load Customer ID
  // =========================
  Future<String?> getCustomerId() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString("userId");
  }

  // =========================
  // Load Bookings
  // =========================
  Future<void> loadBookings() async {
    try {
      setState(() {
        loading = true;
        error = null;
      });

      final customerId = await getCustomerId();

      if (customerId == null || customerId.isEmpty) {
        throw Exception("Customer ID not found. Please login again.");
      }

      final data =
          await bookingService.getCustomerBookings(customerId);

      if (!mounted) return;

      setState(() {
        bookings = data;
        loading = false;
      });

      print("=================================");
      print("CUSTOMER BOOKINGS");
      print(bookings);
      print("=================================");
    } catch (e) {
      if (!mounted) return;

      setState(() {
        loading = false;
        error = e.toString();
      });

      print("My Bookings Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FB),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,

        title: const Text(
          "My Bookings",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),

        iconTheme: const IconThemeData(
          color: Colors.black,
        ),

        actions: [
          IconButton(
            onPressed: loadBookings,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),

      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (error != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                size: 60,
                color: Colors.red,
              ),

              const SizedBox(height: 15),

              Text(
                error!,
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: loadBookings,
                child: const Text("Retry"),
              ),
            ],
          ),
        ),
      );
    }

    if (bookings.isEmpty) {
      return RefreshIndicator(
        onRefresh: loadBookings,
        child: ListView(
          children: const [
            SizedBox(height: 180),

            Icon(
              Icons.local_shipping_outlined,
              size: 80,
              color: Colors.grey,
            ),

            SizedBox(height: 20),

            Center(
              child: Text(
                "No bookings yet",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            SizedBox(height: 8),

            Center(
              child: Text(
                "Your truck bookings will appear here.",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: loadBookings,

      child: ListView.builder(
        padding: const EdgeInsets.all(18),

        itemCount: bookings.length,

        itemBuilder: (context, index) {
          final booking = bookings[index];

          return _bookingCard(booking);
        },
      ),
    );
  }

  Widget _bookingCard(Map<String, dynamic> booking) {
    final String status =
        booking["status"]?.toString() ?? "Pending";

    final String pickup =
        booking["pickup"]?.toString() ?? "Unknown";

    final String destination =
        booking["destination"]?.toString() ?? "Unknown";

    final String goods =
        booking["goodsType"]?.toString() ?? "Unknown";

    final dynamic weight = booking["weight"];

    final dynamic totalPrice = booking["totalPrice"];

    final String bookingId =
        booking["_id"]?.toString() ?? "";

    final truck = booking["truck"];

    final String truckName =
        truck is Map
            ? truck["truckName"]?.toString() ?? "Truck"
            : "Truck";

    return Card(
      margin: const EdgeInsets.only(bottom: 18),

      elevation: 2,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),

      child: InkWell(
        borderRadius: BorderRadius.circular(18),

        onTap: () {
          _showBookingDetails(booking);
        },

        child: Padding(
          padding: const EdgeInsets.all(18),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),

                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),

                    child: const Icon(
                      Icons.local_shipping,
                      color: Colors.blue,
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,

                      children: [
                        Text(
                          truckName,
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 4),

                        Text(
                          "Booking #${bookingId.length > 6 ? bookingId.substring(bookingId.length - 6) : bookingId}",
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),

                  _statusBadge(status),
                ],
              ),

              const SizedBox(height: 20),

              Row(
                children: [
                  const Icon(
                    Icons.location_on,
                    color: Colors.green,
                    size: 20,
                  ),

                  const SizedBox(width: 8),

                  Expanded(
                    child: Text(
                      pickup,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.only(
                  left: 9,
                ),
                child: Container(
                  height: 20,
                  width: 2,
                  color: Colors.grey.shade300,
                ),
              ),

              Row(
                children: [
                  const Icon(
                    Icons.location_on,
                    color: Colors.red,
                    size: 20,
                  ),

                  const SizedBox(width: 8),

                  Expanded(
                    child: Text(
                      destination,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 18),

              const Divider(),

              const SizedBox(height: 10),

              Row(
                children: [
                  Expanded(
                    child: _infoItem(
                      Icons.inventory_2_outlined,
                      "Goods",
                      goods,
                    ),
                  ),

                  Expanded(
                    child: _infoItem(
                      Icons.scale_outlined,
                      "Weight",
                      "${weight ?? 0} kg",
                    ),
                  ),

                  Expanded(
                    child: _infoItem(
                      Icons.currency_rupee,
                      "Price",
                      "₹${totalPrice ?? 0}",
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 15),

              if (status == "Accepted" ||
                  status == "Picked" ||
                  status == "In Transit")
                SizedBox(
                  width: double.infinity,

                  child: ElevatedButton.icon(
                    onPressed: () {
                      _showTracking(booking);
                    },

                    icon: const Icon(
                      Icons.location_on,
                    ),

                    label: const Text(
                      "Track Booking",
                    ),

                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        vertical: 13,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoItem(
    IconData icon,
    String title,
    String value,
  ) {
    return Column(
      children: [
        Icon(
          icon,
          size: 20,
          color: Colors.blue,
        ),

        const SizedBox(height: 5),

        Text(
          title,
          style: const TextStyle(
            fontSize: 11,
            color: Colors.grey,
          ),
        ),

        const SizedBox(height: 3),

        Text(
          value,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ],
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

  // =========================
  // Booking Details
  // =========================
  void _showBookingDetails(
    Map<String, dynamic> booking,
  ) {
    final status =
        booking["status"]?.toString() ?? "Pending";

    showModalBottomSheet(
      context: context,

      isScrollControlled: true,

      backgroundColor: Colors.white,

      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),

      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(25),

          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [
                Center(
                  child: Container(
                    width: 45,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius:
                          BorderRadius.circular(10),
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                const Text(
                  "Booking Details",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 25),

                _detailRow(
                  "Pickup",
                  booking["pickup"]?.toString() ?? "-",
                  Icons.location_on,
                ),

                _detailRow(
                  "Destination",
                  booking["destination"]?.toString() ?? "-",
                  Icons.flag,
                ),

                _detailRow(
                  "Goods",
                  booking["goodsType"]?.toString() ?? "-",
                  Icons.inventory_2,
                ),

                _detailRow(
                  "Weight",
                  "${booking["weight"] ?? 0} kg",
                  Icons.scale,
                ),

                _detailRow(
                  "Total Price",
                  "₹${booking["totalPrice"] ?? 0}",
                  Icons.currency_rupee,
                ),

                const SizedBox(height: 25),

                const Text(
                  "Booking Status",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 15),

                _statusTimeline(status),

                const SizedBox(height: 20),

                if (status == "Accepted" ||
                    status == "Picked" ||
                    status == "In Transit")
                  SizedBox(
                    width: double.infinity,

                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                        _showTracking(booking);
                      },

                      icon: const Icon(
                        Icons.location_on,
                      ),

                      label: const Text(
                        "Track Truck",
                      ),

                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        padding:
                            const EdgeInsets.symmetric(
                          vertical: 15,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _detailRow(
    String title,
    String value,
    IconData icon,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),

      child: Row(
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
      ),
    );
  }

  Widget _statusTimeline(String currentStatus) {
    final statuses = [
      "Pending",
      "Accepted",
      "Picked",
      "In Transit",
      "Delivered",
    ];

    int currentIndex =
        statuses.indexOf(currentStatus);

    if (currentStatus == "Rejected" ||
        currentStatus == "Cancelled") {
      return Column(
        children: [
          _timelineItem(
            "Pending",
            true,
            false,
          ),

          _timelineItem(
            currentStatus,
            true,
            true,
            color: Colors.red,
          ),
        ],
      );
    }

    return Column(
      children: List.generate(
        statuses.length,
        (index) {
          final completed =
              currentIndex >= index;

          return _timelineItem(
            statuses[index],
            completed,
            index == statuses.length - 1,
            color: Colors.blue,
          );
        },
      ),
    );
  }

  Widget _timelineItem(
    String title,
    bool completed,
    bool last, {
    Color color = Colors.blue,
  }) {
    return Row(
      crossAxisAlignment:
          CrossAxisAlignment.start,

      children: [
        Column(
          children: [
            CircleAvatar(
              radius: 10,

              backgroundColor: completed
                  ? color
                  : Colors.grey.shade300,

              child: completed
                  ? const Icon(
                      Icons.check,
                      size: 13,
                      color: Colors.white,
                    )
                  : null,
            ),

            if (!last)
              Container(
                width: 2,
                height: 35,
                color: completed
                    ? color
                    : Colors.grey.shade300,
              ),
          ],
        ),

        const SizedBox(width: 12),

        Padding(
          padding: const EdgeInsets.only(
            top: 2,
          ),

          child: Text(
            title,
            style: TextStyle(
              fontWeight: completed
                  ? FontWeight.bold
                  : FontWeight.normal,
              color: completed
                  ? Colors.black
                  : Colors.grey,
            ),
          ),
        ),
      ],
    );
  }

  // =========================
  // Tracking
  // =========================
// =========================
// Live Tracking
// =========================
void _showTracking(
  Map<String, dynamic> booking,
) {
  final pickup =
      booking["pickup"]?.toString() ?? "Pickup";

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

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(25),
      ),
    ),
    builder: (context) {
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.85,

        child: Padding(
          padding: const EdgeInsets.all(20),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              // =========================
              // Header
              // =========================
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.local_shipping,
                      color: Colors.blue,
                    ),
                  ),

                  const SizedBox(width: 12),

                  const Expanded(
                    child: Text(
                      "Live Tracking",
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),

              const SizedBox(height: 15),

              // =========================
              // Status
              // =========================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),

                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(14),
                ),

                child: Row(
                  children: [
                    const Icon(
                      Icons.info_outline,
                      color: Colors.blue,
                    ),

                    const SizedBox(width: 10),

                    const Text(
                      "Current Status",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),

                    const Spacer(),

                    Text(
                      status,
                      style: const TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              // =========================
              // Map
              // =========================
              Expanded(
                child: Container(
                  width: double.infinity,

                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(20),
                  ),

                  child: Stack(
                    children: [

                      const Center(
                        child: Icon(
                          Icons.map,
                          size: 90,
                          color: Colors.blue,
                        ),
                      ),

                      // Pickup marker
                      Positioned(
                        left: 25,
                        bottom: 45,
                        child: _mapMarker(
                          Icons.location_on,
                          Colors.green,
                        ),
                      ),

                      // Truck marker
                      const Positioned(
                        left: 0,
                        right: 0,
                        top: 0,
                        bottom: 0,
                        child: Center(
                          child: CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.blue,
                            child: Icon(
                              Icons.local_shipping,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),

                      // Destination marker
                      Positioned(
                        right: 25,
                        top: 45,
                        child: _mapMarker(
                          Icons.location_on,
                          Colors.red,
                        ),
                      ),

                      // Map label
                      const Positioned(
                        bottom: 15,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: Text(
                            "Live GPS Map",
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 18),

              // =========================
              // Driver Card
              // =========================
              Container(
                padding: const EdgeInsets.all(14),

                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(15),
                ),

                child: Row(
                  children: [

                    const CircleAvatar(
                      radius: 25,
                      child: Icon(Icons.person),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,

                        children: [
                          Text(
                            driverName,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),

                          const SizedBox(height: 3),

                          Text(
                            truckName,
                            style: const TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),

                    if (driverPhone.isNotEmpty)
                      IconButton(
                        onPressed: () {
                          // Phone functionality can be added later.
                        },
                        icon: const Icon(
                          Icons.phone,
                          color: Colors.green,
                        ),
                      ),
                  ],
                ),
              ),

              const SizedBox(height: 15),

              // =========================
              // Locations
              // =========================
              Row(
                children: [
                  Expanded(
                    child: _locationBox(
                      "Pickup",
                      pickup,
                      Colors.green,
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: _locationBox(
                      "Destination",
                      destination,
                      Colors.red,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

// =========================
// Map Marker
// =========================
Widget _mapMarker(
  IconData icon,
  Color color,
) {
  return Container(
    padding: const EdgeInsets.all(8),

    decoration: BoxDecoration(
      color: Colors.white,
      shape: BoxShape.circle,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.15),
          blurRadius: 8,
        ),
      ],
    ),

    child: Icon(
      icon,
      color: color,
      size: 28,
    ),
  );
}

// =========================
// Location Box
// =========================
Widget _locationBox(
  String title,
  String location,
  Color color,
) {
  return Container(
    padding: const EdgeInsets.all(14),

    decoration: BoxDecoration(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(14),
    ),

    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [

        Row(
          children: [
            Icon(
              Icons.location_on,
              color: color,
              size: 18,
            ),

            const SizedBox(width: 5),

            Text(
              title,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
          ],
        ),

        const SizedBox(height: 7),

        Text(
          location,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,

          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
      ],
    ),
  );
}
}