import 'dart:convert';
import 'package:hirehub/utils/apis.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hirehub/widgets/custombutton.dart';
import 'package:hirehub/widgets/customtextformfield.dart';

class Signup extends StatelessWidget {
  Signup({super.key});

  final _formKey = GlobalKey<FormState>();
  final ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    TextEditingController firstNameController = TextEditingController();
    TextEditingController lastNameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController password1Controller = TextEditingController();
    TextEditingController password2Controller = TextEditingController();

    
    Future<void> signup() async {
      final response = await http.post(
        Uri.parse(
            'http://127.0.0.1:8000/signup/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'first_name': firstNameController.text,
          'last_name': lastNameController.text,
          'email': emailController.text,
          'password': password1Controller.text,
        }),
      );

      if (response.statusCode == 201) {
        // Signup successful
        Navigator.of(context).pushReplacementNamed('/login');
      } else {
        // Signup failed, handle error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Signup failed. Please try again.')),
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
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Join Us Today",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 78, 176, 221)),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                CustomTextFormField(
                  userFieldController: firstNameController,
                  text: "First Name",
                  icon: Icons.person,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your first name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                CustomTextFormField(
                  userFieldController: lastNameController,
                  text: "Last Name",
                  icon: Icons.person,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your last name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                CustomTextFormField(
                  userFieldController: emailController,
                  text: "Email",
                  icon: Icons.mail,
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
                SizedBox(height: 20),
                CustomTextFormField(
                  userFieldController: password1Controller,
                  text: "Password",
                  icon: Icons.lock,
                  hideText: true,
                  isPassword: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                CustomTextFormField(
                  userFieldController: password2Controller,
                  text: "Confirm Password",
                  icon: Icons.lock,
                  hideText: true,
                  isPassword: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    }
                    if (password1Controller.text != value) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 25),
                CustomButton(
                  text: "Sign Up",
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false){
                      //ignUp(firstNameController.text, lastNameController.text, emailController.text, password1Controller.text);
                      signup();
                    }
                  },
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account?"),
                    TextButton(
                        onPressed: () {
                          Get.toNamed("/login");
                        },
                        style: TextButton.styleFrom(
                            foregroundColor: Color.fromARGB(255, 85, 170, 209)),
                        child: Text("login")),
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
