//import 'dart:html';

import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.userFieldController,
    required this.text,
    this.icon,
    this.isPassword = false,
    this.hideText = false,
    this.validator,
  });

  final TextEditingController userFieldController;
  final String text;
  final IconData? icon;
  final bool hideText;
  final bool isPassword;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        obscureText: hideText,
        controller: userFieldController,
        decoration: InputDecoration(
            labelText: text,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(color: Colors.lightBlue),
            ),
            prefixIcon: Icon(icon),
            suffixIcon: isPassword
                ? Icon(Icons.visibility)
                : Container(
                    height: 5,
                    width: 5,
                  )),
        validator: validator);
  }
}
