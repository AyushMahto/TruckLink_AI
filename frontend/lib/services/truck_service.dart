import 'dart:convert';

import 'package:http/http.dart' as http;

import 'api_service.dart';

class TruckService {
  Future<List<dynamic>> getAvailableTrucks() async {
    final response = await http.get(
      Uri.parse("${ApiService.baseUrl}/trucks/available"),
    );

    final data = jsonDecode(response.body);

    if (data["success"] == true) {
      return data["trucks"];
    }

    return [];
  }
}