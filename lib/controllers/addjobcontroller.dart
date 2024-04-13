// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;

// class AddJobController extends GetxController {
//   final TextEditingController jobNameController = TextEditingController();
//   final TextEditingController countryController = TextEditingController();
//   final TextEditingController cityController = TextEditingController();
//   final TextEditingController salaryController = TextEditingController();
//   final RxString duration = ''.obs;
//   final TextEditingController descriptionController = TextEditingController();

//   Future<void> addJob() async {
//     try {
//       final SharedPreferences prefs = await SharedPreferences.getInstance();
//       final userId = prefs.getInt('userId');
//       if (userId != null) {
//         final response = await http.post(
//           Uri.parse('http://127.0.0.1:8000/jobs/add/'),
//           body: {
//             'user': userId.toString(),
//             'job_name': jobNameController.text,
//             'country': countryController.text,
//             'city': cityController.text,
//             'salary': int.tryParse(salaryController.text),
//             'duration': duration.value,
//             'description': descriptionController.text,
//           },
//         );
//         if (response.statusCode == 201) {
//           Get.snackbar('Success', 'Job added successfully',
//               duration: Duration(seconds: 2));
//           // Clear form fields after successful submission
//           jobNameController.clear();
//           countryController.clear();
//           cityController.clear();
//           salaryController.clear();
//           duration.value = '';
//           descriptionController.clear();
//         } else {
//           throw Exception('Failed to add job');
//         }
//       } else {
//         throw Exception('User ID not found in local storage');
//       }
//     } catch (e) {
//       print('Error adding job: $e');
//     }
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AddJobController extends GetxController {
  final TextEditingController jobNameController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController salaryController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  Future<void> addJob(String? selectedDuration) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final userId = prefs.getInt('userId');
      if (userId != null) {
        final response = await http.post(
          Uri.parse('http://127.0.0.1:8000/jobs/add/'),
          body: {
            'user': userId.toString(),
            'job_name': jobNameController.text,
            'country': countryController.text,
            'city': cityController.text,
            'salary': int.tryParse(salaryController.text).toString(),
            'duration': selectedDuration,
            'description': descriptionController.text,
          },
        );
        if (response.statusCode == 201) {
          Get.snackbar('Success', 'Job added successfully',
              duration: Duration(seconds: 2));
          // Clear form fields after successful submission
          jobNameController.clear();
          countryController.clear();
          cityController.clear();
          salaryController.clear();
          descriptionController.clear();
        } else {
          throw Exception('Failed to add job');
        }
      } else {
        throw Exception('User ID not found in local storage');
      }
    } catch (e) {
      print('Error adding job: $e');
    }
  }
}
