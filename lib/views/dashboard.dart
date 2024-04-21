import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hirehub/controllers/profilecontroller.dart';
import 'package:hirehub/utils/local_storage.dart';
import 'package:hirehub/views/jobdetails.dart';
import 'package:hirehub/widgets/customcontainer.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';

class Dashboard extends StatelessWidget {
  final ProfileController profileController = Get.put(ProfileController());
  final LocalStorageService localStorageService = LocalStorageService();
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: Obx(
          () => profileController.userData.isEmpty
              ? Center(child: CircularProgressIndicator())
              : profileController.userData['profilePicture'] != null
                  ? CircleAvatar(
                      backgroundImage: NetworkImage( "http://127.0.0.1:8000${profileController.userData['profilePicture']}",
                      ),
                    )
                  : Image.asset('assets/images/woman.png'),
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                fetchJobs();
              })
        ],
        title: Obx(
          () => profileController.userData.isEmpty
              ? CircularProgressIndicator()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Welcome,',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${profileController.userData['firstName']} ${profileController.userData['lastName']}"
                          .toUpperCase(),
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            // TextField(
            //   controller: searchController,
            //   decoration: InputDecoration(
            //     hintText: 'Search job',
            //     prefixIcon: Icon(Icons.search),
            //   ),
            // ),
            SizedBox(height: 20),
            Text(
              'Popular Jobs',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            SizedBox(height: 20),
            FutureBuilder<List<dynamic>>(
              future: fetchJobs(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  List<dynamic> jobsData = snapshot.data!;
                  return CarouselSlider.builder(
                    itemCount: jobsData.length > 3 ? 3 : jobsData.length,
                    itemBuilder: (context, index, _) {
                      final job = jobsData[index];
                      return CustomContainer(
                        imagePath: job['logo'] ?? "assets/images/ibm.png",
                        title: job['job_name'],
                        location: "${job['city']}, ${job['country']}",
                        jobDetails: "- ${job['duration'] ?? ""}  - ${job['salary'] ?? "unknown"}/=",
                        color: Color.fromARGB(255, 2, 167, 243),
                        //onButtonPressed: navigateToJobDetailsPage(context, job),
                      );
                    },
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
                  );
                }
              },
            ),
            Text(
              'All Jobs',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              height: 600,
              child: FutureBuilder<List<dynamic>>(
                future: fetchJobs(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    List<dynamic> jobsData = snapshot.data!;
                    return ListView.separated(
                      itemCount: jobsData.length,
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 10),
                      itemBuilder: (context, index) {
                        final job = jobsData[index];
                        return ListTile(
                          tileColor: Color.fromARGB(255, 130, 208, 245),
                          title: Text(job['job_name']),
                          subtitle: Text('${job['city']}, ${job['country']}'),
                          leading: job['logo'] != null
                              ? Image.network(job['logo'])
                              : Image.asset('assets/images/ibm.png'),
                          onTap: () {
                            navigateToJobDetailsPage(context, job);
                          },
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

Future<List<dynamic>> fetchJobs() async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:8000/jobs/all/'));
    if (response.statusCode == 200) {
      List<dynamic> jobsData = jsonDecode(response.body);
      for (var job in jobsData) {
        final userId = job['user'];
        final userResponse =
            await http.get(Uri.parse('http://127.0.0.1:8000/users/$userId'));
        if (userResponse.statusCode == 200) {
          final userData = jsonDecode(userResponse.body);
          job['uploader_email'] = userData['email'];
        }
      }
      return jobsData;
    } else {
      throw Exception('Failed to fetch jobs');
    }
  }


  void navigateToJobDetailsPage(
      BuildContext context, Map<String, dynamic> job) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => JobDetailsPage(
          jobName: job['job_name'],
          city: job['city'],
          country: job['country'],
          duration: job['duration'] ?? 'Unknown',
          description: job['description'],
          salary: job['salary'].toString(),
          uploaderEmail: job['uploader_email'] ?? 'Unknown',
          logoUrl: job['logo'],
        ),
      ),
    );
  }
}
