import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hirehub/utils/routes.dart';

void main() {
  runApp(GetMaterialApp(
    initialRoute: "/profile",
    debugShowCheckedModeBanner: false,
    getPages: Routes.routes,
  ));
}
