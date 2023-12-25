import 'dart:convert';

import 'package:http/http.dart' as http;

/// A utility class for making HTTP requests and handling responses.
class AppHttpHelper {
  static const String _baseUrl = 'https://ishwarchaudhary.com/api';

  /// Helper method to make a GET request.
  ///
  /// [endpoint]: The endpoint to be appended to the base URL for the GET request.
  /// Returns a Future<Map<String, dynamic>> with the response data.
  static Future<Map<String, dynamic>> get(String endpoint) async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/$endpoint'));
      return _handleResponse(response);
    } catch (e) {
      print('Error occurred: $e');
      return {};
    }
  }

  /// Helper method to make a POST request.
  ///
  /// [endpoint]: The endpoint to be appended to the base URL for the POST request.
  /// [data]: The data to be sent in the request body.
  /// Returns a Future<Map<String, dynamic>> with the response data.
  static Future<Map<String, dynamic>> post(
      String endpoint, dynamic data) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/$endpoint'),
        body: json.encode(data),
        headers: {'Content-Type': 'application/json'},
      );
      return _handleResponse(response);
    } catch (e) {
      print('Error occurred: $e');
      return {};
    }
  }

  /// Helper method to make a PUT request.
  ///
  /// [endpoint]: The endpoint to be appended to the base URL for the PUT request.
  /// [data]: The data to be sent in the request body.
  /// Returns a Future<Map<String, dynamic>> with the response data.
  static Future<Map<String, dynamic>> put(String endpoint, dynamic data) async {
    try {
      final response = await http.put(
        Uri.parse('$_baseUrl/$endpoint'),
        body: json.encode(data),
        headers: {'Content-Type': 'application/json'},
      );
      return _handleResponse(response);
    } catch (e) {
      print('Error occurred: $e');
      return {};
    }
  }

  /// Helper method to make a DELETE request.
  ///
  /// [endpoint]: The endpoint to be appended to the base URL for the DELETE request.
  /// Returns a Future<Map<String, dynamic>> with the response data.
  static Future<Map<String, dynamic>> delete(String endpoint) async {
    try {
      final response = await http.delete(Uri.parse('$_baseUrl/$endpoint'));
      return _handleResponse(response);
    } catch (e) {
      print('Error occurred: $e');
      return {};
    }
  }

  /// Handles the response from the API.
  ///
  /// [response]: The HTTP response object received from the API.
  /// Returns a Map<String, dynamic> if the response status code is 200, otherwise throws an Exception.
  static Map<String, dynamic> _handleResponse(http.Response response) {
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Request Failed with code: ${response.statusCode}');
    }
  }
}
