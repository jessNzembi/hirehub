import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hirehub/utils/apis.dart';
import 'package:hirehub/widgets/custombutton.dart';
import 'package:hirehub/widgets/customtextformfield.dart';

class UpdateJob extends StatelessWidget {
  final int? jobId;

  UpdateJob({Key? key, this.jobId}) : super(key: key);

  final ApiService apiService = ApiService();
  final List<String> durationOptions = ['part-time', 'full-time'];

  @override
  Widget build(BuildContext context) {
    final jobId = int.tryParse(Get.arguments?['jobId'] ?? '');
    final TextEditingController jobNameController = TextEditingController();
    final TextEditingController countryController = TextEditingController();
    final TextEditingController cityController = TextEditingController();
    final TextEditingController salaryController = TextEditingController();
    final TextEditingController durationController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: FutureBuilder(
          future: apiService.getJobDetails(jobId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              final jobDetails = snapshot.data as Map<String, dynamic>;
              // Populate TextFormFields with fetched job details
              jobNameController.text = jobDetails['job_name'];
              countryController.text = jobDetails['country'];
              cityController.text = jobDetails['city'];
              salaryController.text = jobDetails['salary'].toString();
              durationController.text = jobDetails['duration'];
              descriptionController.text = jobDetails['description'];

              return SingleChildScrollView(
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
                      DropdownButtonFormField<String>(
                        value: durationController.text,
                        items: durationOptions.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          durationController.text = newValue!;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Duration',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(color: Colors.lightBlue),
                          ),
                        ),
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
                          Map<String, dynamic> jobData = {
                            'job_name': jobNameController.text,
                            'country': countryController.text,
                            'city': cityController.text,
                            'salary': int.tryParse(salaryController.text),
                            'duration': durationController.text,
                            'description': descriptionController.text,
                          };

                          bool success =
                              await apiService.updateJob(jobId!, jobData);
                          if (success) {
                            Get.back();
                          } else {
                            Get.snackbar('Error', 'Failed to update job',
                                snackPosition: SnackPosition.BOTTOM);
                          }
                        },
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
