// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class UserController extends GetxController {
//   String firstName = '';
//   String lastName = '';
//   String email = '';

//   Future<void> fetchUserInfo(int userId) async {
//     try {
//       final response = await http.get(Uri.parse('http://127.0.0.1:8000/users/$userId'));
//       if (response.statusCode == 200) {
//         final userData = json.decode(response.body);
//         firstName = userData['first_name'];
//         lastName = userData['last_name'];
//         email = userData['email'];
//         update(); // Notify listeners
//       } else {
//         throw Exception('Failed to fetch user information');
//       }
//     } catch (e) {
//       print('Error fetching user information: $e');
//     }
//   }
// }

import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class UserController extends GetxController {
  var isLoading = true.obs;
  var firstName = ''.obs;
  var lastName = ''.obs;
  var email = ''.obs;

  void fetchUserInfo(int userId) async {
    try {
      isLoading(true);
      final response =
          await http.get(Uri.parse('http://127.0.0.1:8000/users/$userId'));
      if (response.statusCode == 200) {
        final userData = json.decode(response.body);
        firstName(userData['first_name']);
        lastName(userData['last_name']);
        email(userData['email']);
      } else {
        throw Exception('Failed to fetch user information');
      }
    } catch (e) {
      print('Error fetching user information: $e');
    } finally {
      isLoading(false);
    }
  }
}
