import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hirehub/controllers/profilecontroller.dart';
import 'package:hirehub/widgets/card.dart';


class Profile extends StatelessWidget {
  final ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 130, 208, 245),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Get.toNamed("/settings");
            },
          ),
        ],
      ),
      body: Obx(() => profileController.userData.isEmpty
          ? Center(child: CircularProgressIndicator())
          : buildProfileUI(context, profileController.userData.value)),
    );
  }

  Widget buildProfileUI(BuildContext context, Map<String, dynamic> userData) {
    return Material(
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2.0,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 130, 208, 245),
                ),
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(height: 50),
                      CircleAvatar(
                        backgroundImage: userData['profilePicture'] != null
                            ? NetworkImage(
                                "https://jessi16.pythonanywhere.com${userData['profilePicture']}")
                            : AssetImage("assets/images/programmer.png")
                                as ImageProvider,
                        radius: 90.0,
                      ),
                      SizedBox(height: 3),
                      Text(
                        "${userData['firstName']} ${userData['lastName']}"
                            .toUpperCase(),
                      ),
                      SizedBox(height: 5),
                      Text(userData['position']),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.9,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 130, 208, 245),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.9,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(70),
                  topRight: Radius.circular(70),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 50),
                    InfoCard(
                      title: "Email",
                      content: userData['email'],
                      icon: Icons.mail,
                    ),
                    SizedBox(height: 15),
                    InfoCard(
                      title: "Phone Number",
                      content: userData['phoneNumber'],
                      icon: Icons.phone,
                    ),
                    SizedBox(height: 15),
                    InfoCard(
                      title: "Gender",
                      content: userData['gender'],
                      icon: Icons.person,
                    ),
                    SizedBox(height: 15),
                    InfoCard(
                      title: "Age",
                      content: userData['age'].toString(),
                      icon: Icons.person,
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
