import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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

  @override
  Widget build(BuildContext context) {
    final truck = widget.booking["truck"];

    final currentLocation = truck is Map
        ? truck["currentLocation"]?.toString() ?? "Pune"
        : "Pune";

    // Temporary Pune coordinates.
    // Later we'll get these from the backend.
    const LatLng truckPosition = LatLng(
      18.5204,
      73.8567,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        const Text(
          "Truck Location",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 10),

        ClipRRect(
          borderRadius: BorderRadius.circular(20),

          child: SizedBox(
            height: 300,
            width: double.infinity,

            child: GoogleMap(
              initialCameraPosition:
                  const CameraPosition(
                target: truckPosition,
                zoom: 13,
              ),

              markers: {
                Marker(
                  markerId:
                      const MarkerId("truck"),

                  position: truckPosition,

                  infoWindow: InfoWindow(
                    title: "Truck",
                    snippet: currentLocation,
                  ),
                ),
              },

              myLocationButtonEnabled: false,
              zoomControlsEnabled: true,

              onMapCreated: (controller) {
                mapController = controller;
              },
            ),
          ),
        ),

        const SizedBox(height: 10),

        Row(
          children: [
            const Icon(
              Icons.location_on,
              color: Colors.blue,
              size: 18,
            ),

            const SizedBox(width: 6),

            Text(
              "Current location: $currentLocation",
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ],
    );
  }
}