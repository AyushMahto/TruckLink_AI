import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_service.dart';

class LocationService {
  Future<Map<String, dynamic>> getTruckLocation(String truckId) async {
    final response = await http.get(
      Uri.parse("${ApiService.baseUrl}/trucks/location/$truckId"),
    );

    return jsonDecode(response.body);
  }

  Future<void> updateTruckLocation(
      String truckId,
      double lat,
      double lng,
      ) async {
    await http.put(
      Uri.parse("${ApiService.baseUrl}/trucks/location/$truckId"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "latitude": lat,
        "longitude": lng,
      }),
    );
  }
}