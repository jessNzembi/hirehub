import 'dart:convert';
import 'dart:io';

import 'package:hirehub/utils/local_storage.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'http://127.0.0.1:8000';
  final LocalStorageService localStorageService = LocalStorageService();

  Future<bool> signup(
      String firstName, String lastName, String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/signup/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'password': password,
      }),
    );

    return response.statusCode == 201;
  }


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

  Future<bool> updateProfile(
      Map<String, dynamic> profileData, File? image) async {
    int? userId = await localStorageService.getUserId();
    if (userId != null) {
      // Create a multipart request for uploading both JSON data and the image file
      var request = http.MultipartRequest(
        'PUT',
        Uri.parse('$baseUrl/profiles/update/$userId/'),
      );

      // Add JSON data to the request
      request.fields.addAll(
          profileData.map((key, value) => MapEntry(key, value.toString())));

      // Add the image file to the request if available
      if (image != null) {
        request.files.add(http.MultipartFile(
          'profile_picture', // Field name for the image in the request
          image.readAsBytes().asStream(), // Stream of image bytes
          image.lengthSync(), // Length of the image file
          filename: 'profile_picture.jpg', // Filename for the image
        ));
      }

      // Send the request and get the response
      var response = await request.send();

      // Check if the request was successful (status code 200)
      if (response.statusCode == 200) {
        return true;
      }
    }
    return false;
  }

  Future<bool> updateJob(int jobId, Map<String, dynamic> jobData) async {
    final response = await http.put(
      Uri.parse('$baseUrl/jobs/update/$jobId/'),
      body: jsonEncode(jobData),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );
    return response.statusCode == 200;
  }
}
