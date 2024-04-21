import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hirehub/utils/local_storage.dart';
import 'package:http/http.dart' as http;
import 'package:hirehub/widgets/custombutton.dart';
import 'package:hirehub/widgets/customtextformfield.dart';

class Login extends StatelessWidget {
  Login({super.key});

  final _formKey = GlobalKey<FormState>();
  final LocalStorageService localStorageService = LocalStorageService();

  @override
  Widget build(BuildContext context) {
    TextEditingController userNameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    Future<void> login() async {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:8000/login/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': userNameController.text,
          'password': passwordController.text,
        }),
      );

      if (response.statusCode == 200) {
        // Login successful
        var userData = jsonDecode(response.body);
        var userId = userData['user_id'];
        var firstName = userData['first_name'];
        var lastName = userData['last_name'];
        var email = userData['email'];
        var position = userData['position'] ?? "";
        var phoneNumber = userData['phone_number'] ?? "";
        var gender = userData['gender'] ?? "";
        var age = userData['age'] ?? 0;
        var profilePic = userData['profile_picture'];

        localStorageService.storeUserData(userId, email, firstName, lastName, position, phoneNumber, gender, profilePic, age);
        print(userId);
        print(profilePic);
        Navigator.of(context).pushReplacementNamed('/home');
      } else {
        // Signup failed, handle error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed. Please try again.')),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(50),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/job-search.png",
                  width: 200,
                  height: 200,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Welcome",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 78, 176, 221)),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Login To Continue",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 78, 176, 221)),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                CustomTextFormField(
                  userFieldController: userNameController,
                  text: "Email Address",
                  icon: Icons.email,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                CustomTextFormField(
                  userFieldController: passwordController,
                  text: "Password",
                  icon: Icons.lock,
                  isPassword: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: const Text("Forgot password?"),
                      style: TextButton.styleFrom(
                          foregroundColor: Color.fromARGB(255, 85, 170, 209)),
                    ),
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                CustomButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      //ignUp(firstNameController.text, lastNameController.text, emailController.text, password1Controller.text);
                      login();
                    }
                  },
                  text: "Login",
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Not a member?"),
                    TextButton(
                        onPressed: () => Get.toNamed("/signup"),
                        style: TextButton.styleFrom(
                            foregroundColor: Color.fromARGB(255, 85, 170, 209)),
                        child: Text("Sign up")),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
