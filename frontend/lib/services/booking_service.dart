import 'dart:convert';
import 'package:http/http.dart' as http;

import 'api_service.dart';

class BookingService {
  // =========================
  // Create Booking
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

    return jsonDecode(response.body);
  }

  // =========================
  // Get Pending Bookings
  // =========================
  Future<List> getPendingBookings() async {
    final response = await http.get(
      Uri.parse("${ApiService.baseUrl}/bookings/pending"),
      headers: {
        "Content-Type": "application/json",
      },
    );

    final data = jsonDecode(response.body);

    return data["bookings"];
  }
  // =========================
// Customer Bookings
// =========================

Future<List> getCustomerBookings(String customerId) async {
  final response = await http.get(
    Uri.parse("${ApiService.baseUrl}/bookings/customer/$customerId"),
  );

  final data = jsonDecode(response.body);

  return data["bookings"];
}

  // =========================
  // Update Booking Status
  // =========================
  Future<bool> updateBookingStatus(
    String bookingId,
    String status,
  ) async {
    final response = await http.put(
      Uri.parse("${ApiService.baseUrl}/bookings/$bookingId"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "status": status,
      }),
    );

    return response.statusCode == 200;
  }
}
