import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../config/constants/api_endpoints.dart';

class ApiClient {
  static Future<List<dynamic>> fetchClients() async {
    try {
      final response = await http.get(
        Uri.parse('${ApiEndpoints.baseUrl}${ApiEndpoints.allclients}'),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return responseData['data'] as List;
      } else {
        throw Exception('Error fetching clients: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }
}
