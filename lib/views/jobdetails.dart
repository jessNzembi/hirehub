import 'package:flutter/material.dart';

class JobDetailsPage extends StatelessWidget {
  final String jobName;
  final String city;
  final String country;
  final String? logoUrl;
  final String duration;
  final String description;
  final String salary;
  final String uploaderEmail;

  const JobDetailsPage({
    required this.jobName,
    required this.city,
    required this.country,
    required this.duration,
    required this.salary,
    required this.description,
    required this.uploaderEmail,
    this.logoUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Job Details'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (logoUrl != null) Image.network(logoUrl!),
          SizedBox(height: 10,),
          ListTile(
            tileColor: Color.fromARGB(255, 130, 208, 245),
            title: Text('Job Name: $jobName',style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,),),
          ),
          SizedBox(
            height: 10,
          ),
          ListTile(
            tileColor: Color.fromARGB(255, 130, 208, 245),
            title: Text('Location: $city, $country',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          ListTile(
            tileColor: Color.fromARGB(255, 130, 208, 245),
            title: Text('Duration: $duration',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          ListTile(
            tileColor: Color.fromARGB(255, 130, 208, 245),
            title: Text('Salary: $salary',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          ListTile(
            tileColor: Color.fromARGB(255, 130, 208, 245),
            title: Text(
              'Description: $description',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          ListTile(
            tileColor: Color.fromARGB(255, 130, 208, 245),
            title: Text('To apply, send an email to:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(uploaderEmail,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
