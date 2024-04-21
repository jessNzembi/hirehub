import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hirehub/controllers/addjobcontroller.dart';
import 'package:hirehub/controllers/jobcontroller.dart';
import 'package:hirehub/widgets/custombutton.dart';
import 'package:hirehub/widgets/customtextformfield.dart';

class JobManagement extends StatelessWidget {
  final AddJobController addJobController = Get.put(AddJobController());
  final JobsController jobsController = Get.put(JobsController());

  final List<String> durationOptions = ['part-time', 'full-time'];

  String? selectedDuration;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Job Management'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Add Job'),
              Tab(text: ' My Jobs'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildAddJobTab(),
            _buildJobsTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildAddJobTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomTextFormField(
            userFieldController: addJobController.jobNameController,
            text: 'Job Name',
          ),
          SizedBox(height: 20),
          CustomTextFormField(
            userFieldController: addJobController.countryController,
            text: 'Country',
          ),
          SizedBox(height: 20),
          CustomTextFormField(
            userFieldController: addJobController.cityController,
            text: 'City',
          ),
          SizedBox(height: 20),
          CustomTextFormField(
            userFieldController: addJobController.salaryController,
            text: 'Salary',
          ),
          SizedBox(height: 20),
          DropdownButtonFormField<String>(
            value: selectedDuration,
            elevation: 16,
            decoration: InputDecoration(
              labelText: 'Duration',
              border: OutlineInputBorder(),
            ),
            onChanged: (String? newValue) {
              selectedDuration = newValue;
            },
            items: durationOptions.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          SizedBox(height: 20),
          CustomTextFormField(
            userFieldController: addJobController.descriptionController,
            text: 'Description',
          ),
          SizedBox(height: 25),
          CustomButton(
            onPressed: () {
              addJobController.addJob(selectedDuration);
            },
            text: 'Add Job',
          ),
        ],
      ),
    );
  }

  Widget _buildJobsTab() {
    return Obx(() {
      if (jobsController.isLoading.value) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else {
        return ListView.builder(
          itemCount: jobsController.jobs.length,
          itemBuilder: (context, index) {
            final job = jobsController.jobs[index];
            return ListTile(
              title: Text(job['job_name']),
              subtitle: Text('${job['country']}, ${job['city']}'),
              onTap: () {
                // Implement navigation to update jobs page
                print(job['id']);
                //Get.toNamed('/update_jobs', arguments: job['id']);
                Get.toNamed('/update_jobs',
                    arguments: {'jobId': job['id'].toString()});
              },
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  // Implement deletion of job
                  jobsController.deleteJob(job['id']);
                },
              ),
            );
          },
        );
      }
    });
  }
}
