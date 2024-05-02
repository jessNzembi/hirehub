
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
//import 'package:hirehub/controllers/profilecontroller.dart';
import 'package:hirehub/utils/apis.dart';
import 'package:hirehub/utils/local_storage.dart';
import 'package:hirehub/widgets/custombutton.dart';
import 'package:hirehub/widgets/customtextformfield.dart';
import 'package:image_picker/image_picker.dart';

class UpdateProfile extends StatefulWidget {
  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final ApiService apiService = ApiService();
  final LocalStorageService localStorageService = LocalStorageService();
  final List<String> genderOptions = ['male', 'female', 'other'];
  String? selectedGender;
  final TextEditingController positionController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController fNameController = TextEditingController();
  final TextEditingController lNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  File? _image;

  @override
  void initState() {
    super.initState();
    // Fetch user data from local storage and populate text fields
    _populateTextFields();
  }

  Future<void> _populateTextFields() async {
    Map<String, dynamic> userData = await localStorageService.getUserData();
    setState(() {
      emailController.text = userData['email'];
      fNameController.text = userData['firstName'];
      lNameController.text = userData['lastName'];
      positionController.text = userData['position'];
      phoneNumberController.text = userData['phoneNumber'];
      ageController.text = userData['age'].toString();
      if (userData['gender'] == ''){
        selectedGender = genderOptions[2];
      } else {
        selectedGender = userData['gender'];
      }
    });
  }

  Future<void> _getImage(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final imageFile = File(pickedFile.path);
      setState(() {
        _image = imageFile;
      });
    } else {
      print('No image selected.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              InkWell(
                onTap: () => _getImage(context),
                child: Container(
                  width: 180.0,
                  height: 180.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey[200],
                  ),
                  child: _image != null
                      ? ClipOval(
                          child: kIsWeb
                              ? Image.network(_image!.path)
                              : Image.file(
                                  _image!,
                                  fit: BoxFit.cover,
                                  width: 180.0,
                                  height: 180.0,
                                ),
                        )
                      : Center(
                          child: Icon(
                            Icons.add_a_photo,
                            size: 50.0,
                            color: Colors.grey[600],
                          ),
                        ),
                ),
              ),
              SizedBox(height: 40),
              CustomTextFormField(
                userFieldController: fNameController,
                text: "First Name",
                icon: Icons.person,
              ),
              SizedBox(height: 20,),
              CustomTextFormField(
                userFieldController: lNameController,
                text: "Last Name",
                icon: Icons.person,
              ),
              SizedBox(height: 20),
              CustomTextFormField(
                userFieldController: emailController,
                text: "Email",
                icon: Icons.person,
              ),
              SizedBox(height: 20),
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
              DropdownButtonFormField<String>(
                value: selectedGender,
                icon: Icon(Icons.arrow_drop_down),
                iconSize: 24,
                elevation: 16,
                decoration: const InputDecoration(
                  labelText: 'Gender',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Colors.lightBlue),
                  ),
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedGender = newValue;
                  });
                },
                items:
                    genderOptions.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
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
                onPressed: () async {
                  Map<String, dynamic> userData =
                      await localStorageService.getUserData();
                  if (userData['userId'] == null) {
                    Get.snackbar('Error', 'User ID not found in local storage',
                        snackPosition: SnackPosition.BOTTOM);
                    return;
                  }

                  Map<String, dynamic> updatedUserData = {
                    'userId': userData['userId'],
                    'email': emailController.text,
                    'firstName': fNameController.text,
                    'lastName': lNameController.text,
                    'position': positionController.text,
                    'phoneNumber': phoneNumberController.text,
                    'gender': selectedGender,
                    'profilePicture': userData['profilePicture'],
                    'age': int.tryParse(ageController.text) ?? 0,
                  };

                  bool success =
                      await apiService.updateProfile(updatedUserData, _image);
                  if (success) {
                    Get.back();
                  } else {
                    Get.snackbar('Error', 'Failed to update profile',
                        snackPosition: SnackPosition.BOTTOM);
                  }

                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
