import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ProfileController extends GetxController {
  var isLoading = true.obs;
  var position = ''.obs;
  var email = ''.obs;
  var phoneNumber = ''.obs;
  var gender = ''.obs;
  var age = 0.obs;

  void fetchUserProfile(int userId) async {
    try {
      isLoading(true);
      final response =
          await http.get(Uri.parse('http://127.0.0.1:8000/profiles/$userId'));
      if (response.statusCode == 200) {
        final profileData = jsonDecode(response.body);
        position(profileData['position']);
        email(profileData['email']);
        phoneNumber(profileData['phone_number']);
        gender(profileData['gender']);
        age(profileData['age']);
      } else {
        throw Exception('Failed to fetch user profile data');
      }
    } catch (e) {
      print('Error fetching user profile data: $e');
    } finally {
      isLoading(false);
    }
  }
}
