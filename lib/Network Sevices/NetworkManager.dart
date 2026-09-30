import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class NetworkManager {
  static final shared = NetworkManager();

  Future<dynamic> getRequest(String url) async {
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        var json = jsonDecode(response.body);
        return json;
      } else {
        throw FormatException("Failed to decode response for ${url}");
      }
    } on SocketException {
      throw Exception("Failed to load. Check Your Internet Connection");
    } catch (error) {
      throw Exception(error.toString());
    }
  }

  Future<dynamic> postRequest<T>(
    String url,
    String username,
    String password,
    T model
  ) async {
    try {
      var postRequest = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': "application/json"},
        body: jsonEncode({username: "abc@example,com", password: "password"}),
      );

      if (postRequest.statusCode >= 200 && postRequest.statusCode <= 299) {
        var json = jsonDecode(postRequest.body);
        return json;
      } else {
        throw FormatException("Fails to load. Something went wrong with ${url}, ${postRequest.statusCode}, ${postRequest.body}",);
      }
    } on SocketException {
      throw Exception("Failed to load. Check Your Internet Connection");
    } catch (error) {
      throw Exception(error.toString());
    }
  }
}
