import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hirehub/widgets/custombutton.dart';
import 'package:hirehub/widgets/customtextformfield.dart';

class UpdateProfile extends StatelessWidget {
  UpdateProfile({super.key});

  @override
  Widget build(BuildContext context) {
    //TextEditingController firstNameController = TextEditingController();
    TextEditingController positionController = TextEditingController();
    TextEditingController phoneNumberController = TextEditingController();
    TextEditingController genderController = TextEditingController();
    TextEditingController ageController = TextEditingController();

    Future<void> update() async {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:8000/signup/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          //'first_name': firstNameController.text,
          'position': positionController.text,
          'phone_number': phoneNumberController.text,
          'gender': genderController.text,
          'age': ageController.text,
        }),
      );

      if (response.statusCode == 201) {
        // Signup successful
        Navigator.of(context).pushReplacementNamed('/profile');
      } else {
        // Signup failed, handle error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Update failed. Please try again.')),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.only(
          left: 50,
          right: 50,
          top: 15, // Adjust this value to reduce the padding at the top
          bottom: 50,
        ),
        child: SingleChildScrollView(
          child: Form(
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                    backgroundImage: AssetImage(
                      "assets/images/woman.png",
                    ),
                    radius: 90.0,
                    ),
                    Positioned(
                      bottom: 1,
                      right: 5,
                      child: IconButton(
                        icon: Icon(Icons.camera_alt_sharp),
                          onPressed: () {
                            // Add functionality to change profile picture
                          },
                      )
                    )
                  ]
                ),
                SizedBox(height: 40),
                // CustomTextFormField(
                //   userFieldController: firstNameController,
                //   text: "First Name",
                //   icon: Icons.person,
                //   validator: (value) {
                //     if (value == null || value.isEmpty) {
                //       return 'Please enter your first name';
                //     }
                //     return null;
                //   },
                // ),
                //SizedBox(height: 20),
                CustomTextFormField(
                  userFieldController: positionController,
                  text: "Position",
                  icon: Icons.person,
                ),
                SizedBox(height: 20),
                CustomTextFormField(
                  userFieldController: phoneNumberController,
                  text: "Phone number",
                  icon: Icons.phone,
                ),
                SizedBox(height: 20),
                CustomTextFormField(
                  userFieldController: genderController,
                  text: "Gender",
                  icon: Icons.person_3,
                ),
                SizedBox(height: 20),
                CustomTextFormField(
                  userFieldController: ageController,
                  text: "Age",
                  icon: Icons.person_3,
                ),
                SizedBox(height: 25),
                CustomButton(
                  text: "Save",
                  onPressed: () {
                    Get.toNamed('/profile');
                  },
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
