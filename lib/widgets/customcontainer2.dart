//import 'dart:html';

import 'package:flutter/material.dart';

class CustomContainer2 extends StatelessWidget {
  final String imagePath;
  final String title;
  final String location;
  //final String jobDetails;
  //final String buttonText;
  final Color color;
  //final VoidCallback onButtonPressed;

  CustomContainer2({
    required this.imagePath,
    required this.title,
    required this.location,
    //required this.jobDetails,
    //required this.onButtonPressed,
    //this.buttonText = "Apply Now",
    this.color = const Color.fromARGB(255, 120, 204, 243),
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: color,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // Image at the top and center
              Center(
                child: Image.asset(
                  imagePath,
                  width: 70,
                  height: 70,
                  fit: BoxFit.contain, // Use BoxFit.contain to avoid stretching
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                children: [
                  Text(title,
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Text(location),
                ],
              ),
              //SizedBox(height: 10),

              //Text(jobDetails),
            ],
          ),
        ),
      ),
    );
  }
}
