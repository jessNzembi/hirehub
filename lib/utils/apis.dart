import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:hirehub/controllers/profilecontroller.dart';
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
    Map<String, dynamic> userData = await localStorageService.getUserData();
    int? userId = userData['userId'];
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
    Map<String, dynamic> userData = await localStorageService.getUserData();
    int? userId = userData['userId'];
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
    Map<String, dynamic> userData = await localStorageService.getUserData();
    int? userId = userData['userId'];
    if (userId != null) {
      var request = http.MultipartRequest(
        'PUT',
        Uri.parse('$baseUrl/profiles/update/$userId/'),
      );

      request.fields.addAll(
          profileData.map((key, value) => MapEntry(key, value.toString())));

      if (image != null) {
        request.files.add(http.MultipartFile(
          'profile_picture',
          image.readAsBytes().asStream(),
          image.lengthSync(),
          filename: 'profile_picture.jpg',
        ));
      }

      var response = await request.send();

      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        var responseData = jsonDecode(responseBody);
        String newImagePath = responseData['profile_picture'];
        print(newImagePath);

        await localStorageService.storeUserData(
          userData['userId'],
          profileData['email'],
          profileData['firstName'],
          profileData['lastName'],
          profileData['position'],
          profileData['phoneNumber'],
          profileData['gender'],
          newImagePath,
          profileData['age'],
        );

        Map<String, dynamic> updatedUserData =
            await localStorageService.getUserData();
        print(updatedUserData['profilePicture']);
        Get.find<ProfileController>().updateUserData(updatedUserData);

        return true;
      }
    }
    return false;
  }

  Future<Map<String, dynamic>> getJobDetails(int? jobId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/jobs/view/$jobId'),
      );
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to fetch job details');
      }
    } catch (e) {
      throw Exception('Error fetching job details: $e');
    }
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
