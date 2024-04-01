import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hirehub/controllers/homecontroller.dart';
import 'package:hirehub/views/dashboard.dart';
import 'package:hirehub/views/profile.dart';

HomeController homeController = Get.put(HomeController());
var screens = [
  Dashboard(),
  Text("Settings Page coming soon"),
  Profile(),
];

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        onTap: (index) {
          homeController.updateSelectedPage(index);
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
