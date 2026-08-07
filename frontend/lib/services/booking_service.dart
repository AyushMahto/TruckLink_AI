import 'dart:convert';
import 'package:http/http.dart' as http;

import 'api_service.dart';

class BookingService {
  // =========================
  // CREATE BOOKING
  // =========================
  Future<Map<String, dynamic>> createBooking({
    required String customerId,
    required String truckId,
    required String pickup,
    required String destination,
    required String goodsType,
    required double weight,
    required double totalPrice,
  }) async {
    final response = await http.post(
      Uri.parse("${ApiService.baseUrl}/bookings"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "customer": customerId,
        "truck": truckId,
        "pickup": pickup,
        "destination": destination,
        "goodsType": goodsType,
        "weight": weight,
        "totalPrice": totalPrice,
      }),
    );

    if (response.statusCode != 201) {
      throw Exception(
        "Failed to create booking: ${response.body}",
      );
    }

    return jsonDecode(response.body);
  }

  // =========================
  // GET CUSTOMER BOOKINGS
  // =========================
  Future<List<dynamic>> getCustomerBookings(
    String customerId,
  ) async {
    final response = await http.get(
      Uri.parse(
        "${ApiService.baseUrl}/bookings/customer/$customerId",
      ),
      headers: {
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode != 200) {
      throw Exception(
        "Failed to load customer bookings: ${response.body}",
      );
    }

    final data = jsonDecode(response.body);

    return data["bookings"] ?? [];
  }

  // =========================
  // GET PENDING BOOKINGS
  // =========================
  Future<List<dynamic>> getPendingBookings() async {
    final response = await http.get(
      Uri.parse(
        "${ApiService.baseUrl}/bookings/pending",
      ),
      headers: {
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode != 200) {
      throw Exception(
        "Failed to load pending bookings: ${response.body}",
      );
    }

    final data = jsonDecode(response.body);

    return data["bookings"] ?? [];
  }

  // =========================
  // UPDATE BOOKING STATUS
  // =========================
  Future<bool> updateBookingStatus(
    String bookingId,
    String status,
  ) async {
    final response = await http.put(
      Uri.parse(
        "${ApiService.baseUrl}/bookings/$bookingId",
      ),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "status": status,
      }),
    );

    return response.statusCode == 200;
  }

  // =========================
  // START TRIP
  // =========================
  Future<Map<String, dynamic>> startTrip(
    String bookingId,
  ) async {
    final response = await http.put(
      Uri.parse(
        "${ApiService.baseUrl}/bookings/start/$bookingId",
      ),
      headers: {
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode != 200) {
      throw Exception(
        "Failed to start trip: ${response.body}",
      );
    }

    return jsonDecode(response.body);
  }

  // =========================
  // UPDATE DRIVER LOCATION
  // =========================
  Future<Map<String, dynamic>> updateLocation({
    required String bookingId,
    required double latitude,
    required double longitude,
  }) async {
    final response = await http.put(
      Uri.parse(
        "${ApiService.baseUrl}/bookings/location/$bookingId",
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
      throw Exception(
        "Failed to update location: ${response.body}",
      );
    }

    return jsonDecode(response.body);
  }

  // =========================
  // GET LIVE LOCATION
  // =========================
  Future<Map<String, dynamic>> getLiveLocation(
    String bookingId,
  ) async {
    final response = await http.get(
      Uri.parse(
        "${ApiService.baseUrl}/bookings/location/$bookingId",
      ),
      headers: {
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode != 200) {
      throw Exception(
        "Failed to get live location: ${response.body}",
      );
    }

    final data = jsonDecode(response.body);

    return {
      "latitude": data["latitude"],
      "longitude": data["longitude"],
      "status": data["status"],
      "tripStarted": data["tripStarted"],
      "tripCompleted": data["tripCompleted"],
    };
  }
}