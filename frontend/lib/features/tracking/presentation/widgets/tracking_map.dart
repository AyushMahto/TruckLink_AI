import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../services/booking_service.dart';

class TrackingMap extends StatefulWidget {
  final Map<String, dynamic> booking;

  const TrackingMap({
    super.key,
    required this.booking,
  });

  @override
  State<TrackingMap> createState() => _TrackingMapState();
}

class _TrackingMapState extends State<TrackingMap> {
  GoogleMapController? mapController;

  final BookingService bookingService = BookingService();

  Timer? locationTimer;

  late double latitude;
  late double longitude;

  String currentLocation = "Loading...";
  String status = "Pending";

  bool loading = true;

  @override
  void initState() {
    super.initState();

    _initializeLocation();
  }

  // =========================
  // INITIAL LOCATION
  // =========================
  void _initializeLocation() {
    final booking = widget.booking;

    latitude = _toDouble(
      booking["currentLatitude"],
      18.5204,
    );

    longitude = _toDouble(
      booking["currentLongitude"],
      73.8567,
    );

    status = booking["status"]?.toString() ?? "Pending";

    final truck = booking["truck"];

    if (truck is Map) {
      currentLocation =
          truck["currentLocation"]?.toString() ?? "Unknown";
    } else {
      currentLocation = "Unknown";
    }

    loading = false;

    if (_isTrackingActive()) {
      _startPolling();
    }
  }

  // =========================
  // START POLLING
  // =========================
  void _startPolling() {
    locationTimer?.cancel();

    locationTimer = Timer.periodic(
      const Duration(seconds: 5),
      (_) {
        _fetchLiveLocation();
      },
    );
  }

  // =========================
  // FETCH LIVE LOCATION
  // =========================
  Future<void> _fetchLiveLocation() async {
    try {
      final bookingId =
          widget.booking["_id"]?.toString();

      if (bookingId == null || bookingId.isEmpty) {
        return;
      }

      final data =
          await bookingService.getLiveLocation(
        bookingId,
      );

      if (!mounted) return;

      final newLatitude = _toDouble(
        data["latitude"],
        latitude,
      );

      final newLongitude = _toDouble(
        data["longitude"],
        longitude,
      );

      final newStatus =
          data["status"]?.toString() ?? status;

      setState(() {
        latitude = newLatitude;
        longitude = newLongitude;
        status = newStatus;
      });

      // Move camera to latest truck position.
      if (mapController != null) {
        await mapController!.animateCamera(
          CameraUpdate.newLatLng(
            LatLng(
              newLatitude,
              newLongitude,
            ),
          ),
        );
      }

      // Stop polling when trip ends.
      if (!_isTrackingActive()) {
        locationTimer?.cancel();
      }
    } catch (error) {
      debugPrint(
        "Live tracking error: $error",
      );
    }
  }

  // =========================
  // CHECK TRACKING STATUS
  // =========================
  bool _isTrackingActive() {
    return status == "Accepted" ||
        status == "Picked" ||
        status == "In Transit";
  }

  // =========================
  // SAFE DOUBLE CONVERSION
  // =========================
  double _toDouble(
    dynamic value,
    double fallback,
  ) {
    if (value is num) {
      return value.toDouble();
    }

    return double.tryParse(
          value?.toString() ?? "",
        ) ??
        fallback;
  }

  @override
  void dispose() {
    locationTimer?.cancel();

    mapController?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final truck = widget.booking["truck"];

    final truckName = truck is Map
        ? truck["truckName"]?.toString() ?? "Truck"
        : "Truck";

    if (loading) {
      return Container(
        height: 300,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius:
              BorderRadius.circular(20),
        ),
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final truckPosition = LatLng(
      latitude,
      longitude,
    );

    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(
              Icons.local_shipping,
              color: Colors.blue,
            ),

            const SizedBox(width: 8),

            const Text(
              "Truck Location",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const Spacer(),

            if (_isTrackingActive())
              Container(
                padding:
                    const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.green
                      .withOpacity(0.1),
                  borderRadius:
                      BorderRadius.circular(20),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.circle,
                      size: 8,
                      color: Colors.green,
                    ),
                    SizedBox(width: 5),
                    Text(
                      "LIVE",
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight:
                            FontWeight.bold,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),

        const SizedBox(height: 10),

        // =========================
        // GOOGLE MAP
        // =========================
        ClipRRect(
          borderRadius:
              BorderRadius.circular(20),

          child: SizedBox(
            height: 300,
            width: double.infinity,

            child: GoogleMap(
              initialCameraPosition:
                  CameraPosition(
                target: truckPosition,
                zoom: 14,
              ),

              markers: {
                Marker(
                  markerId:
                      const MarkerId("truck"),

                  position: truckPosition,

                  icon:
                      BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueBlue,
                  ),

                  infoWindow: InfoWindow(
                    title: truckName,
                    snippet:
                        "Status: $status",
                  ),
                ),
              },

              myLocationButtonEnabled: false,

              zoomControlsEnabled: true,

              compassEnabled: true,

              mapToolbarEnabled: true,

              onMapCreated: (controller) {
                mapController = controller;
              },
            ),
          ),
        ),

        const SizedBox(height: 10),

        // =========================
        // CURRENT LOCATION
        // =========================
        Container(
          width: double.infinity,

          padding:
              const EdgeInsets.all(12),

          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius:
                BorderRadius.circular(12),
          ),

          child: Row(
            children: [
              const Icon(
                Icons.location_on,
                color: Colors.blue,
                size: 20,
              ),

              const SizedBox(width: 8),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      currentLocation,
                      style:
                          const TextStyle(
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 3),

                    Text(
                      "${latitude.toStringAsFixed(5)}, "
                      "${longitude.toStringAsFixed(5)}",
                      style:
                          const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 8),

        if (_isTrackingActive())
          const Text(
            "Location updates automatically every 5 seconds",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 11,
            ),
          )
        else
          Text(
            status == "Delivered"
                ? "Trip completed"
                : "Live tracking is not active",
            style: TextStyle(
              color: status == "Delivered"
                  ? Colors.green
                  : Colors.grey,
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
      ],
    );
  }
}