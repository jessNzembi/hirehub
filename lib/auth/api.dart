import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<void> signUp(
    String firstName, String lastName, String email, String password) async {
  final response = await http.post(
    Uri.parse('http://your-django-server.com/signup/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'password': password,
    }),
  );

  if (response.statusCode == 201) {
    print("Success");
    Get.toNamed("/login");
    // If the server returns a  201 CREATED response,
    // then navigate to another page.
    // For example, to the login page.
  } else {
    print('Response body: ${response.body}');
    // If the server returns an error,
    // then throw an exception.
    throw Exception('Failed to sign up.');
  }
}
