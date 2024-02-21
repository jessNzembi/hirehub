import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? userFieldController;
  final String? hintMessage;
  final IconData? icon;
  final bool hideText;
  final bool isPassword;
  const CustomTextField(
      {super.key,
      required this.userFieldController,
      required this.hintMessage,
      this.icon,
      this.hideText = false,
      this.isPassword = false});

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: hideText,
      cursorRadius: const Radius.elliptical(5, 0),
      controller: userFieldController,
      decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(color: Colors.lightBlue)),
          hintText: hintMessage,
          prefixIcon: Icon(icon),
          suffixIcon: isPassword
              ? Icon(Icons.visibility)
              : Container(
                  height: 5,
                  width: 5,
                )),
    );
  }
}
