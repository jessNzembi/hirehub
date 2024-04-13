// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:hirehub/utils/apis.dart';
// import 'package:hirehub/utils/local_storage.dart';
// import 'package:hirehub/widgets/custombutton.dart';
// import 'package:hirehub/widgets/customtextformfield.dart';

// class UpdateProfile extends StatelessWidget {
//   UpdateProfile({super.key});

//   final ApiService apiService = ApiService(); // Initialize ApiService

//   // List of gender options
//   final List<String> genderOptions = ['male', 'female', 'other'];

//   String? selectedGender; // Variable to store the selected gender

//   @override
//   Widget build(BuildContext context) {
//     TextEditingController positionController = TextEditingController();
//     TextEditingController phoneNumberController = TextEditingController();
//     TextEditingController ageController = TextEditingController();

//     return Scaffold(
//       appBar: AppBar(),
//       body: Padding(
//         padding: EdgeInsets.only(
//           left: 50,
//           right: 50,
//           top: 15,
//           bottom: 50,
//         ),
//         child: SingleChildScrollView(
//           child: Form(
//             child: Column(
//               children: [
//                 Stack(children: [
//                   CircleAvatar(
//                     backgroundImage: AssetImage(
//                       "assets/images/woman.png",
//                     ),
//                     radius: 90.0,
//                   ),
//                   Positioned(
//                       bottom: 1,
//                       right: 5,
//                       child: IconButton(
//                         icon: Icon(Icons.camera_alt_sharp),
//                         onPressed: () {
//                           // Add functionality to change profile picture
//                         },
//                       ))
//                 ]),
//                 SizedBox(height: 40),
//                 CustomTextFormField(
//                   userFieldController: positionController,
//                   text: "Position",
//                   icon: Icons.person,
//                 ),
//                 SizedBox(height: 20),
//                 CustomTextFormField(
//                   userFieldController: phoneNumberController,
//                   text: "Phone number",
//                   icon: Icons.phone,
//                 ),
//                 SizedBox(height: 20),
//                 DropdownButtonFormField<String>(
//                   value: selectedGender,
//                   icon: Icon(Icons.arrow_drop_down),
//                   iconSize: 24,
//                   elevation: 16,
//                   decoration: InputDecoration(
//                     labelText: 'Gender',
//                     prefixIcon: Icon(Icons.person),
//                     border: OutlineInputBorder(),
//                   ),
//                   onChanged: (String? newValue) {
//                     selectedGender = newValue;
//                   },
//                   items: genderOptions
//                       .map<DropdownMenuItem<String>>((String value) {
//                     return DropdownMenuItem<String>(
//                       value: value,
//                       child: Text(value),
//                     );
//                   }).toList(),
//                 ),
//                 SizedBox(height: 20),
//                 CustomTextFormField(
//                   userFieldController: ageController,
//                   text: "Age",
//                   icon: Icons.person_3,
//                 ),
//                 SizedBox(height: 25),
//                 CustomButton(
//                   text: "Save",
//                   onPressed: () async {
//                     // Get the user_id from local storage
//                     int? userId = await LocalStorageService().getUserId();
//                     if (userId == null) {
//                       // Handle scenario where user_id is not available
//                       Get.snackbar(
//                           'Error', 'User ID not found in local storage',
//                           snackPosition: SnackPosition.BOTTOM);
//                       return;
//                     }

//                     // Get the updated profile data
//                     Map<String, dynamic> profileData = {
//                       'user': userId,
//                       'position': positionController.text,
//                       'phone_number': phoneNumberController.text,
//                       'gender': selectedGender,
//                       'age': int.tryParse(ageController.text),
//                     };

//                     // Call the updateProfile method
//                     bool success = await apiService.updateProfile(profileData);
//                     if (success) {
//                       // Navigate to profile page
//                       Get.back();
//                     } else {
//                       // Show error message
//                       Get.snackbar('Error', 'Failed to update profile',
//                           snackPosition: SnackPosition.BOTTOM);
//                     }
//                   },
//                 ),
//                 SizedBox(height: 10),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:hirehub/utils/apis.dart';
// import 'package:hirehub/utils/local_storage.dart';
// import 'package:hirehub/widgets/custombutton.dart';
// import 'package:hirehub/widgets/customtextformfield.dart';
// import 'package:image_picker/image_picker.dart';

// class UpdateProfile extends StatelessWidget {
//   final ApiService apiService = ApiService();
//   final List<String> genderOptions = ['male', 'female', 'other'];
//   String? selectedGender;
//   final TextEditingController positionController = TextEditingController();
//   final TextEditingController phoneNumberController = TextEditingController();
//   final TextEditingController ageController = TextEditingController();
//   File? _image;

//   Future<void> _getImage(BuildContext context) async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       final imageFile = File(pickedFile.path);
//       _image = imageFile;
//       Get.forceAppUpdate(); // Rebuild the widget to display the selected image
//     } else {
//       print('No image selected.');
//     }
//   }


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               InkWell(
//                 onTap: () => _getImage(context),
//                 child: Container(
//                   width: 180.0,
//                   height: 180.0,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     image: DecorationImage(
//                       fit: BoxFit.cover,
//                       image: _image != null
//                           ? FileImage(_image!)
//                           : AssetImage("assets/images/woman.png")
//                               as ImageProvider,
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 40),
//               CustomTextFormField(
//                 userFieldController: positionController,
//                 text: "Position",
//                 icon: Icons.person,
//               ),
//               SizedBox(height: 20),
//               CustomTextFormField(
//                 userFieldController: phoneNumberController,
//                 text: "Phone number",
//                 icon: Icons.phone,
//               ),
//               SizedBox(height: 20),
//               DropdownButtonFormField<String>(
//                 value: selectedGender,
//                 icon: Icon(Icons.arrow_drop_down),
//                 iconSize: 24,
//                 elevation: 16,
//                 decoration: InputDecoration(
//                   labelText: 'Gender',
//                   prefixIcon: Icon(Icons.person),
//                   border: OutlineInputBorder(),
//                 ),
//                 onChanged: (String? newValue) {
//                   selectedGender = newValue;
//                   // Rebuild the widget to reflect the selected gender
//                   Get.forceAppUpdate();
//                 },
//                 items:
//                     genderOptions.map<DropdownMenuItem<String>>((String value) {
//                   return DropdownMenuItem<String>(
//                     value: value,
//                     child: Text(value),
//                   );
//                 }).toList(),
//               ),
//               SizedBox(height: 20),
//               CustomTextFormField(
//                 userFieldController: ageController,
//                 text: "Age",
//                 icon: Icons.person_3,
//               ),
//               SizedBox(height: 25),
//               CustomButton(
//                 text: "Save",
//                 onPressed: () async {
//                   // Get the user_id from local storage
//                   int? userId = await LocalStorageService().getUserId();
//                   if (userId == null) {
//                     Get.snackbar(
//                         'Error', 'User ID not found in local storage',
//                         snackPosition: SnackPosition.BOTTOM);
//                     return;
//                   }

//                   // Get the updated profile data
//                   Map<String, dynamic> profileData = {
//                     'user': userId,
//                     'position': positionController.text,
//                     'phone_number': phoneNumberController.text,
//                     'gender': selectedGender,
//                     'age': int.tryParse(ageController.text),
//                   };

//                   // Call the updateProfile method and pass the selected image
//                   bool success =
//                       await apiService.updateProfile(profileData, _image);
//                   if (success) {
//                     // Navigate to the previous screen
//                     Get.back();
//                   } else {
//                     // Show error message
//                     Get.snackbar('Error', 'Failed to update profile',
//                         snackPosition: SnackPosition.BOTTOM);
//                   }
//                 },
//               ),
//               SizedBox(height: 10),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  final List<String> genderOptions = ['male', 'female', 'other'];
  String? selectedGender;
  final TextEditingController positionController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  File? _image;

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
                decoration: InputDecoration(
                  labelText: 'Gender',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
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
                  int? userId = await LocalStorageService().getUserId();
                  if (userId == null) {
                    Get.snackbar('Error', 'User ID not found in local storage',
                        snackPosition: SnackPosition.BOTTOM);
                    return;
                  }

                  Map<String, dynamic> profileData = {
                    'user': userId,
                    'position': positionController.text,
                    'phone_number': phoneNumberController.text,
                    'gender': selectedGender,
                    'age': int.tryParse(ageController.text),
                  };

                  bool success =
                      await apiService.updateProfile(profileData, _image);
                  if (success) {
                    Get.back();
                  } else {
                    Get.snackbar('Error', 'Failed to update profile',
                        snackPosition: SnackPosition.BOTTOM);
                  }
                },
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
