import 'package:flutter/material.dart';
import 'package:hirehub/widgets/card.dart';

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
          InfoCard(title: "Name", content: jobName, icon: Icons.business_center),
          // ListTile(
          //   tileColor: Color.fromARGB(255, 130, 208, 245),
          //   title: Text('Job Name: $jobName',style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,),),
          // ),
          SizedBox(
            height: 10,
          ),
          InfoCard(
              title: "Location", content: "$city, $country", icon: Icons.location_city),
          // ListTile(
          //   tileColor: Color.fromARGB(255, 130, 208, 245),
          //   title: Text('Location: $city, $country',
          //     style: TextStyle(
          //       fontSize: 20,
          //       fontWeight: FontWeight.bold,
          //     ),
          //   ),
          // ),
          SizedBox(
            height: 10,
          ),
          InfoCard(
              title: "Duration", content: duration, icon: Icons.schedule),
          // ListTile(
          //   tileColor: Color.fromARGB(255, 130, 208, 245),
          //   title: Text('Duration: $duration',
          //     style: TextStyle(
          //       fontSize: 20,
          //       fontWeight: FontWeight.bold,
          //     ),
          //   ),
          // ),
          SizedBox(
            height: 10,
          ),
          InfoCard(
              title: "Salary", content: salary, icon: Icons.monetization_on),
          // ListTile(
          //   tileColor: Color.fromARGB(255, 130, 208, 245),
          //   title: Text('Salary: $salary',
          //     style: TextStyle(
          //       fontSize: 20,
          //       fontWeight: FontWeight.bold,
          //     ),
          //   ),
          // ),
          SizedBox(
            height: 10,
          ),
          InfoCard(
              title: "Description", content: description, icon: Icons.description),
          // ListTile(
          //   tileColor: Color.fromARGB(255, 130, 208, 245),
          //   title: Text(
          //     'Description: $description',
          //     style: TextStyle(
          //       fontSize: 20,
          //       fontWeight: FontWeight.bold,
          //     ),
          //   ),
          // ),
          SizedBox(
            height: 10,
          ),
          InfoCard(
              title: "To apply, send an email to:", content: uploaderEmail, icon: Icons.mail),
          // ListTile(
          //   tileColor: Color.fromARGB(255, 130, 208, 245),
          //   title: Text('To apply, send an email to:',
          //     style: TextStyle(
          //       fontSize: 20,
          //       fontWeight: FontWeight.bold,
          //     ),
          //   ),
          //   subtitle: Text(uploaderEmail,
          //     style: TextStyle(
          //       fontSize: 20,
          //       fontWeight: FontWeight.bold,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
