import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hirehub/controllers/homecontroller.dart';
import 'package:hirehub/views/dashboard.dart';
import 'package:hirehub/views/profile.dart';

HomeController homeController = Get.put(HomeController());
var screens = [
  Dashboard(),
  Text("Add your jobs here"),
  //Text("Settings Page coming soon"),
  Profile(),
];

class Home extends StatelessWidget {
  const Home({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: GetBuilder<HomeController>(
        builder: (controller) {
          return BottomNavigationBar(
            //backgroundColor: Colors.white, // Set background color
            selectedItemColor: Colors.blue, // Default selected item color
            unselectedItemColor: Colors.grey, // Default unselected item color
            currentIndex: controller.selectedPage.value,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add),
                label: 'Jobs',
              ),
              // BottomNavigationBarItem(
              //   icon: Icon(Icons.settings),
              //   label: 'Settings',
              // ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
            onTap: (index) {
              controller.updateSelectedPage(index);
            },
          );
        },
      ),
      body: Obx(
        () => Center(
          child: screens[homeController.selectedPage.value],
        ),
      ),
    );
  }
}
