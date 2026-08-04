import 'dart:convert';

import 'package:http/http.dart' as http;

import 'api_service.dart';

class BookingService {
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
}