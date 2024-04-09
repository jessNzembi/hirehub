// import 'package:flutter/material.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:get/get.dart';
// import 'package:hirehub/controllers/usercontroller.dart';
// import 'package:hirehub/widgets/customcontainer.dart';
// import 'package:hirehub/widgets/customtextfield.dart';
// import 'package:hirehub/widgets/customtext.dart';
// import 'package:hirehub/widgets/customcontainer2.dart';
// import 'package:hirehub/utils/local_storage.dart';

// class Dashboard extends StatelessWidget {
//   Dashboard({super.key});

//   final localStorageService = LocalStorageService();

//   @override
//   Widget build(BuildContext context) {
//     final UserController userController = Get.put(UserController());
//     TextEditingController searchController = TextEditingController();

//     final userId = await localStorageService.getUserId();
//     if (userId != null) {
//       userController.fetchUserInfo(userId);
//     }
    
//     return Scaffold(
//       appBar: AppBar(
//         leading: Image.asset(
//           'assets/images/woman.png',
//           fit: BoxFit.cover,
//         ),
//         title: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: <Widget>[
//             Text(
//               'Good Morning,',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             Text(
//               'Test User',
//               style: TextStyle(fontSize: 18),
//             ),
//           ],
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(15.0),
//         child: ListView(
//           children: [
//             CustomTextField(
//               userFieldController: searchController,
//               hintMessage: "Search job",
//               icon: Icons.search,
//             ),
//             SizedBox(
//               height: 25,
//             ),
//             CustomText(
//               label: "Popular Jobs",
//               fontWeight: FontWeight.bold,
//               fontSize: 25,
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             CarouselSlider(
//               items: [
//                 CustomContainer(
//                   imagePath: "assets/images/meta.png",
//                   title: "UI/UX Designer",
//                   location: "Nairobi, Kenya",
//                   jobDetails: "-Full time  -Remote  -sh150000/month",
//                   color: Color.fromARGB(255, 2, 167, 243),
//                 ),
//                 CustomContainer(
//                   imagePath: "assets/images/amazon.png",
//                   title: "Software Engineer",
//                   location: "Nairobi, Kenya",
//                   jobDetails: "-Full time  -Remote  -sh150000/month",
//                   color: Color.fromARGB(255, 35, 177, 243),
//                 ),
//                 CustomContainer(
//                   imagePath: "assets/images/spotify.png",
//                   title: "AI Engineer",
//                   location: "Nairobi, Kenya",
//                   jobDetails: "-Full time  -Remote  -sh1000000/month",
//                   color: Color.fromARGB(255, 76, 193, 247),
//                 ),
//               ],
//               options: CarouselOptions(
//                 height: 380.0,
//                 enlargeCenterPage: true,
//                 autoPlay: true,
//                 aspectRatio: 16 / 9,
//                 autoPlayCurve: Curves.fastOutSlowIn,
//                 enableInfiniteScroll: true,
//                 autoPlayAnimationDuration: Duration(milliseconds: 800),
//                 viewportFraction: 0.8,
//               ),
//             ),
//             CustomText(
//               label: "Your Recomendations",
//               fontWeight: FontWeight.bold,
//               fontSize: 25,
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             CustomContainer2(
//                 imagePath: "assets/images/facebook.png",
//                 title: "Database Designer",
//                 location: "Nairobi, Kenya"),
//             CustomContainer2(
//                 imagePath: "assets/images/apple.png",
//                 title: "Database Designer",
//                 location: "Nairobi, Kenya"),
//             CustomContainer2(
//                 imagePath: "assets/images/ibm.png",
//                 title: "Database Designer",
//                 location: "Nairobi, Kenya"),
//           ],
//         ),
//       ),
      
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:hirehub/controllers/usercontroller.dart';
import 'package:hirehub/widgets/customcontainer.dart';
import 'package:hirehub/widgets/customtextfield.dart';
import 'package:hirehub/widgets/customtext.dart';
import 'package:hirehub/widgets/customcontainer2.dart';
import 'package:hirehub/utils/local_storage.dart';

class Dashboard extends StatelessWidget {
  Dashboard({Key? key}) : super(key: key);

  final localStorageService = LocalStorageService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int?>(
      future: _fetchUserInfo(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Placeholder widget while waiting
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return _buildDashboard(context);
        }
      },
    );
  }

  Future<int?> _fetchUserInfo() async {
    final userId = await localStorageService.getUserId();
    if (userId != null) {
      final userController = Get.put(UserController());
      userController.fetchUserInfo(userId);
    }
    return userId;
  }

  Widget _buildDashboard(BuildContext context) {
    final TextEditingController searchController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        leading: Image.asset(
          'assets/images/woman.png',
          fit: BoxFit.cover,
        ),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'Good Morning,',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            GetBuilder<UserController>(
              builder: (controller) {
                return Text(
                  '${controller.firstName} ${controller.lastName}',
                  style: TextStyle(fontSize: 18),
                );
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: [
            CustomTextField(
              userFieldController: searchController,
              hintMessage: "Search job",
              icon: Icons.search,
            ),
            SizedBox(
              height: 25,
            ),
            CustomText(
              label: "Popular Jobs",
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
            SizedBox(
              height: 20,
            ),
            CarouselSlider(
              items: [
                CustomContainer(
                  imagePath: "assets/images/meta.png",
                  title: "UI/UX Designer",
                  location: "Nairobi, Kenya",
                  jobDetails: "-Full time  -Remote  -sh150000/month",
                  color: Color.fromARGB(255, 2, 167, 243),
                ),
                CustomContainer(
                  imagePath: "assets/images/amazon.png",
                  title: "Software Engineer",
                  location: "Nairobi, Kenya",
                  jobDetails: "-Full time  -Remote  -sh150000/month",
                  color: Color.fromARGB(255, 35, 177, 243),
                ),
                CustomContainer(
                  imagePath: "assets/images/spotify.png",
                  title: "AI Engineer",
                  location: "Nairobi, Kenya",
                  jobDetails: "-Full time  -Remote  -sh1000000/month",
                  color: Color.fromARGB(255, 76, 193, 247),
                ),
              ],
              options: CarouselOptions(
                height: 380.0,
                enlargeCenterPage: true,
                autoPlay: true,
                aspectRatio: 16 / 9,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                viewportFraction: 0.8,
              ),
            ),
            CustomText(
              label: "Your Recomendations",
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
            SizedBox(
              height: 10,
            ),
            CustomContainer2(
                imagePath: "assets/images/facebook.png",
                title: "Database Designer",
                location: "Nairobi, Kenya"),
            CustomContainer2(
                imagePath: "assets/images/apple.png",
                title: "Database Designer",
                location: "Nairobi, Kenya"),
            CustomContainer2(
                imagePath: "assets/images/ibm.png",
                title: "Database Designer",
                location: "Nairobi, Kenya"),
          ],
        ),
      ),
    );
  }
}
