import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
//import 'package:hirehub/controllers/homecontroller.dart';
import 'package:hirehub/utils/routes.dart';
//import 'package:hirehub/views/home.dart';
import 'package:hirehub/views/welcome.dart';

void main() {
  //Get.put(HomeController());
  runApp(GetMaterialApp(
    home: Welcome(),
    //initialRoute: "/",
    debugShowCheckedModeBanner: false,
    getPages: Routes.routes,
  ));
}
