import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color buttonColor;
  final VoidCallback? onPressed;
  const CustomButton(
      {super.key,
      required this.text,
      this.buttonColor = const Color.fromARGB(255, 130, 208, 245),
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: buttonColor,
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(20))),
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(fontSize: 20, color: Colors.black),
          )),
    );
  }
}
