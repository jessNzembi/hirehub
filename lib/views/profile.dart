import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hirehub/widgets/card.dart';
import 'package:http/http.dart' as http;
import 'package:hirehub/widgets/custombutton.dart';
import 'package:get/get.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> logout() async {
      final response =
          await http.post(Uri.parse('http://127.0.0.1:8000/logout/'));

      if (response.statusCode == 200) {
        // Logout successful
        Navigator.of(context).pushReplacementNamed('/login');
      } else {
        // Signup failed, handle error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Logout failed. Please try again.')),
        );
      }
    }

    return Material(
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2.76,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 130, 208, 245),
                ),
                child: Center(
                  child: Column(children: [
                    SizedBox(
                      height: 50,
                    ),
                    CircleAvatar(
                      backgroundImage: AssetImage(
                        "assets/images/woman.png",
                      ),
                      radius: 90.0,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text("Name"),
                  ]),
                ),
              ),
              SizedBox(
                height: 0,
              ),
              Text("Name"),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.5,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 130, 208, 245),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.5,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(70),
                    topRight: Radius.circular(70),
                  )),
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  InfoCard(
                      title: "Email", content: "Email.email", icon: Icons.mail),
                  SizedBox(
                    height: 15,
                  ),
                  InfoCard(
                      title: "Phone Number",
                      content: "Email.email",
                      icon: Icons.mail),
                  SizedBox(
                    height: 15,
                  ),
                  InfoCard(
                      title: "Gender",
                      content: "Email.email",
                      icon: Icons.mail),
                  SizedBox(
                    height: 15,
                  ),
                  InfoCard(
                      title: "Age",
                      content: "Email.email",
                      icon: Icons.mail),
                  SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                    text: "Update profile",
                    onPressed: () {
                        Get.toNamed("/updateProfile");
                      },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomButton(text: "Logout")
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
