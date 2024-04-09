import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showCustomSnackbar(
  String title,
  String message, {
  IconData? icon,
  Color? iconColor,
  Color? backgroundColor = Colors.white,
  Color? colorText = Colors.black,
}) {
  Get.snackbar(
    title,
    message,
    colorText: colorText,
    backgroundColor: Color.fromARGB(255, 78, 176, 221),
    icon: Icon(icon ?? Icons.info),
  );
}
