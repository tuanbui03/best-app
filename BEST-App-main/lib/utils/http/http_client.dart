import 'dart:convert';
import 'package:http/http.dart' as http;


class THttpHelper {
  //10.0.2.2
  static const String _baseUrl = 'http://192.168.1.4:8080/api/best_app';
  // Helper method to make a GET request
  static dynamic get(String endpoint) async {
    print("-----------------------------------\n${_baseUrl}/${endpoint}\n------------------");
    final response = await http.get(Uri.parse('$_baseUrl/$endpoint'));
    return _handleResponse(response);
  }

  //Helper method to make a POST request
  static dynamic post(String endpoint, dynamic data) async
  {
    final response = await http.post(
      Uri.parse('$_baseUrl/$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );
    return _handleResponse(response);
  }

  // Helper method to make a PUT request
  static dynamic put(String endpoint, dynamic data) async
  {
    final response = await http.put(
      Uri.parse('$_baseUrl/$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );
    return _handleResponse(response);
  }

  // Helper method to make a DELETE request
  static dynamic delete(String endpoint) async {
    final response = await http.delete(Uri.parse('$_baseUrl/$endpoint'));
    return _handleResponse(response);
  }

  // Handle the HTTP response
  static dynamic _handleResponse(http.Response response){
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }
}