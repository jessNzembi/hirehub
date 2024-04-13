import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hirehub/utils/apis.dart';
import 'package:hirehub/widgets/custombutton.dart';
import 'package:hirehub/widgets/customtextformfield.dart';

class UpdateJob extends StatelessWidget {
  final int? jobId; // Make jobId optional

  UpdateJob({Key? key, this.jobId}) : super(key: key);

  final ApiService apiService = ApiService(); // Initialize ApiService
  //final jobId = int.tryParse(Get.arguments?['jobId'] ?? '');


  @override
  Widget build(BuildContext context) {
    final jobId = int.tryParse(Get.arguments?['jobId'] ?? '');
    TextEditingController jobNameController = TextEditingController();
    TextEditingController countryController = TextEditingController();
    TextEditingController cityController = TextEditingController();
    TextEditingController salaryController = TextEditingController();
    TextEditingController durationController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomTextFormField(
                  userFieldController: jobNameController,
                  text: "Job Name",
                ),
                SizedBox(height: 20),
                CustomTextFormField(
                  userFieldController: countryController,
                  text: "Country",
                ),
                SizedBox(height: 20),
                CustomTextFormField(
                  userFieldController: cityController,
                  text: "City",
                ),
                SizedBox(height: 20),
                CustomTextFormField(
                  userFieldController: salaryController,
                  text: "Salary",
                ),
                SizedBox(height: 20),
                CustomTextFormField(
                  userFieldController: durationController,
                  text: "Duration",
                ),
                SizedBox(height: 20),
                CustomTextFormField(
                  userFieldController: descriptionController,
                  text: "Description",
                ),
                SizedBox(height: 25),
                CustomButton(
                  text: "Save",
                  onPressed: () async {
                    // Get the updated job data
                    Map<String, dynamic> jobData = {
                      'job_name': jobNameController.text,
                      'country': countryController.text,
                      'city': cityController.text,
                      'salary': int.tryParse(salaryController.text),
                      'duration': durationController.text,
                      'description': descriptionController.text,
                    };

                    // Call the updateJob method
                    bool success = await apiService.updateJob(jobId!, jobData);
                    if (success) {
                      // Navigate back to the job management page
                      Get.back();
                    } else {
                      // Show error message
                      Get.snackbar('Error', 'Failed to update job',
                          snackPosition: SnackPosition.BOTTOM);
                    }
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
