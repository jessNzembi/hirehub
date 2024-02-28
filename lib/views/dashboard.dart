import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:hirehub/views/customcontainer.dart';
import 'package:hirehub/views/customtextfield.dart';
import 'package:hirehub/views/customtext.dart';
import 'package:hirehub/views/customcontainer2.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
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
            Text(
              'Test User',
              style: TextStyle(fontSize: 18),
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
