import 'dart:convert';
import 'package:http/http.dart' as http;

import 'api_service.dart';

class TruckService {
  // =========================
  // Get Available Trucks
  // =========================
  Future<List> getAvailableTrucks() async {
    final response = await http.get(
      Uri.parse(
        "${ApiService.baseUrl}/trucks/available",
      ),
      headers: {
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to load available trucks");
    }

    final data = jsonDecode(response.body);

    if (data["success"] != true) {
      throw Exception(
        data["message"] ?? "Failed to load available trucks",
      );
    }

    return data["trucks"] ?? [];
  }

  // =========================
  // Get Truck Location
  // =========================
  Future<Map<String, dynamic>> getTruckLocation(
    String truckId,
  ) async {
    final response = await http.get(
      Uri.parse(
        "${ApiService.baseUrl}/trucks/location/$truckId",
      ),
      headers: {
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to load truck location");
    }

    final data = jsonDecode(response.body);

    if (data["success"] != true) {
      throw Exception(
        data["message"] ?? "Failed to load truck location",
      );
    }

    return {
      "latitude": (data["latitude"] as num).toDouble(),
      "longitude": (data["longitude"] as num).toDouble(),
    };
  }

  // =========================
  // Update Truck Location
  // =========================
  Future<Map<String, dynamic>> updateTruckLocation({
    required String truckId,
    required double latitude,
    required double longitude,
  }) async {
    final response = await http.put(
      Uri.parse(
        "${ApiService.baseUrl}/trucks/location/$truckId",
      ),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "latitude": latitude,
        "longitude": longitude,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to update truck location");
    }

    return jsonDecode(response.body);
  }
}