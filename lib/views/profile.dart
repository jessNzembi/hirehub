// import 'package:flutter/material.dart';
// import 'package:hirehub/controllers/profilecontroller.dart';
// import 'package:hirehub/controllers/usercontroller.dart';
// import 'package:hirehub/widgets/card.dart';
// import 'package:get/get.dart';
// import 'package:hirehub/widgets/custombutton.dart';
// import 'package:hirehub/utils/local_storage.dart';

// class Profile extends StatelessWidget {
//   final ProfileController profileController = Get.put(ProfileController());
//   final UserController userController = Get.put(UserController());
//   final LocalStorageService localStorageService = LocalStorageService();

//   @override
//   Widget build(BuildContext context) {
//     fetchUserProfile();

//     return Scaffold(
//       body: Obx(() {
//         if (profileController.isLoading.value) {
//           return Center(child: CircularProgressIndicator());
//         } else {
//           return buildProfileUI(context);
//         }
//       }),
//     );
//   }

//   void fetchUserProfile() async {
//     int? userId = await localStorageService.getUserId();
//     if (userId != null) {
//       profileController.fetchUserProfile(userId);
//     }
//   }

//   Widget buildProfileUI(BuildContext context) {
//     return Material(
//       child: Stack(
//         children: [
//           Column(
//             children: [
//               Container(
//                 width: MediaQuery.of(context).size.width,
//                 height: MediaQuery.of(context).size.height / 1.96,
//                 decoration: BoxDecoration(
//                   color: Color.fromARGB(255, 130, 208, 245),
//                 ),
//                 child: Center(
//                   child: Column(children: [
//                     SizedBox(
//                       height: 50,
//                     ),
//                     CircleAvatar(
//                       backgroundImage: AssetImage(
//                         "assets/images/woman.png",
//                       ),
//                       radius: 90.0,
//                     ),
//                     SizedBox(
//                       height: 3,
//                     ),
//                     Text("${userController.firstName} ${userController.lastName}".toUpperCase()),
//                     SizedBox(
//                       height: 5,
//                     ),
//                     Obx(() => Text(profileController.position.value)),
//                   ]),
//                 ),
//               ),
//             ],
//           ),
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: Container(
//               width: MediaQuery.of(context).size.width,
//               height: MediaQuery.of(context).size.height / 1.55,
//               decoration: BoxDecoration(
//                 color: Color.fromARGB(255, 130, 208, 245),
//               ),
//             ),
//           ),
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: Container(
//               width: MediaQuery.of(context).size.width,
//               height: MediaQuery.of(context).size.height / 1.55,
//               decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(70),
//                     topRight: Radius.circular(70),
//                   )),
//               child: Column(
//                 children: [
//                   SizedBox(
//                     height: 50,
//                   ),
//                   InfoCard(
//                       title: "Email",
//                       content: userController.email,
//                       icon: Icons.mail),
//                   SizedBox(
//                     height: 15,
//                   ),
//                   InfoCard(
//                       title: "Phone Number",
//                       content: profileController.phoneNumber.value,
//                       icon: Icons.mail),
//                   SizedBox(
//                     height: 15,
//                   ),
//                   InfoCard(
//                       title: "Gender",
//                       content: profileController.gender.value,
//                       icon: Icons.mail),
//                   SizedBox(
//                     height: 15,
//                   ),
//                   InfoCard(
//                       title: "Age",
//                       content: profileController.age.value.toString(),
//                       icon: Icons.mail),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   // CustomButton(
//                   //   text: "Update profile",
//                   //   onPressed: () {
//                   //     Get.toNamed("/updateProfile");
//                   //   },
//                   // ),
//                   // SizedBox(
//                   //   height: 10,
//                   // ),
//                   //CustomButton(text: "Logout")
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hirehub/controllers/profilecontroller.dart';
import 'package:hirehub/controllers/usercontroller.dart';
import 'package:hirehub/widgets/card.dart';
import 'package:hirehub/utils/local_storage.dart';

class Profile extends StatelessWidget {
  final ProfileController profileController = Get.put(ProfileController());
  final UserController userController = Get.put(UserController());
  final LocalStorageService localStorageService = LocalStorageService();

  @override
  Widget build(BuildContext context) {
    fetchUserProfile();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 130, 208, 245), // Make the app bar transparent
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // Navigate to settings page
              Get.toNamed("/settings");
            },
          ),
        ],
      ),
      body: Obx(() {
        if (profileController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else {
          return buildProfileUI(context);
        }
      }),
    );
  }

  void fetchUserProfile() async {
    int? userId = await localStorageService.getUserId();
    if (userId != null) {
      profileController.fetchUserProfile(userId);
    }
  }

  Widget buildProfileUI(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 1.96,
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
                      height: 3,
                    ),
                    Text(
                        "${userController.firstName} ${userController.lastName}"
                            .toUpperCase()),
                    SizedBox(
                      height: 5,
                    ),
                    Obx(() => Text(profileController.position.value)),
                  ]),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.8,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 130, 208, 245),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.8,
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
                      title: "Email",
                      content: userController.email,
                      icon: Icons.mail),
                  SizedBox(
                    height: 15,
                  ),
                  InfoCard(
                      title: "Phone Number",
                      content: profileController.phoneNumber.value,
                      icon: Icons.mail),
                  SizedBox(
                    height: 15,
                  ),
                  InfoCard(
                      title: "Gender",
                      content: profileController.gender.value,
                      icon: Icons.mail),
                  SizedBox(
                    height: 15,
                  ),
                  InfoCard(
                      title: "Age",
                      content: profileController.age.value.toString(),
                      icon: Icons.mail),
                  SizedBox(
                    height: 20,
                  ),
                  // CustomButton(
                  //   text: "Update profile",
                  //   onPressed: () {
                  //     Get.toNamed("/updateProfile");
                  //   },
                  // ),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  //CustomButton(text: "Logout")
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
