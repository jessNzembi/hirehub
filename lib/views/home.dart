// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:hirehub/controllers/homecontroller.dart';
// import 'package:hirehub/views/dashboard.dart';
// import 'package:hirehub/views/jobs.dart';
// import 'package:hirehub/views/profile.dart';

// HomeController homeController = Get.put(HomeController());
// var screens = [
//   Dashboard(),
//   JobManagement(),
//   Profile(),
// ];

// class Home extends StatelessWidget {
//   const Home({Key? key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       bottomNavigationBar: GetBuilder<HomeController>(
//         builder: (controller) {
//           return BottomNavigationBar(
//             //backgroundColor: Colors.white, // Set background color
//             selectedItemColor: Colors.blue, // Default selected item color
//             unselectedItemColor: Colors.grey, // Default unselected item color
//             currentIndex: controller.selectedPage.value,
//             items: const <BottomNavigationBarItem>[
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.home),
//                 label: 'Home',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.add),
//                 label: 'Jobs',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.person),
//                 label: 'Profile',
//               ),
//             ],
//             onTap: (index) {
//               controller.updateSelectedPage(index);
//               switch (index) {
//                 case 0:
//                   Get.toNamed('/dash'); // Navigate to the home page
//                   break;
//                 case 1:
//                   Get.toNamed('/jobs'); // Navigate to the job management page
//                   break;
//                 case 2:
//                   Get.toNamed('/profile'); // Navigate to the profile page
//                   break;
//               }
              
//             },
//           );
//         },
//       ),
//       body: Obx(
//         () => Center(
//           child: screens[homeController.selectedPage.value],
//         ),
//       ),
//     );
//   }
// }

//import 'package:academia/exports/barrel.dart';
import 'package:flutter/material.dart';
import 'package:hirehub/views/dashboard.dart';
import 'package:hirehub/views/jobs.dart';
import 'package:hirehub/views/profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  final pages = [
    Dashboard(),
    JobManagement(),
    Profile(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(index: currentIndex, children: pages),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        items: const [
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.home),
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            activeIcon: Icon(Icons.add),
            label: 'Jobs',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
