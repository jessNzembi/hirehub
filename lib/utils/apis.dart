import 'dart:convert';
import 'package:hirehub/utils/local_storage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  final String baseUrl = 'http://127.0.0.1:8000';
  final LocalStorageService localStorageService = LocalStorageService();

  Future<bool> logout() async {
    int? userId = await localStorageService.getUserId();
    if (userId != null) {
      await localStorageService.clear();
      final response = await http.post(
        Uri.parse('$baseUrl/logout/'),
        body: {'userId': userId.toString()},
      );
      return response.statusCode == 200;
    }
    return false;
  }

  Future<bool> deleteAccount() async {
    int? userId = await localStorageService.getUserId();
    if (userId != null) {
      await localStorageService.clear();
      final response = await http.delete(
        Uri.parse('$baseUrl/delete/$userId/'),
      );
      return response.statusCode == 200;
    }
    return false;
  }
}
