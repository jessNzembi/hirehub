import 'package:get/get.dart';
import 'package:hirehub/views/add_job.dart';
import 'package:hirehub/views/dashboard.dart';
import 'package:hirehub/views/home.dart';
import 'package:hirehub/views/jobs.dart';
import 'package:hirehub/views/profile.dart';
import 'package:hirehub/views/settings.dart';
import 'package:hirehub/views/update_profile.dart';
import 'package:hirehub/views/welcome.dart';
import 'package:hirehub/views/login.dart';
import 'package:hirehub/views/signup.dart';

class Routes {
  static var routes = [
    GetPage(name: "/", page: () => Welcome()),
    GetPage(name: "/home", page: () => HomePage()),
    GetPage(name: "/login", page: () => Login()),
    GetPage(name: "/settings", page: () => Settings()),
    GetPage(name: "/signup", page: () => Signup()),
    GetPage(name: "/dash", page: () => Dashboard()),
    GetPage(name: "/profile", page: () => Profile()),
    GetPage(name: "/updateProfile", page: () => UpdateProfile()),
    GetPage(name: "/jobs", page: () => JobManagement()),
    GetPage(
      name: "/update_jobs",
      page: () => UpdateJob(),
      transition: Transition.fade,
      binding: BindingsBuilder(() {
        Get.put<UpdateJob>(
          UpdateJob(jobId: int.tryParse(Get.parameters['jobId'] ?? '')),
        );
      }),
    ),
  ];
}
