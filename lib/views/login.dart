import 'package:flutter/material.dart';
import 'package:hirehub/views/customtextfield.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController userNameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 60,
            ),
            Text(
              "Login Screen",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            CustomTextField(
              userFieldController: userNameController,
              hintMessage: "Email Address",
              icon: Icons.mail,
            ),
            SizedBox(
              height: 20,
            ),
            CustomTextField(
              userFieldController: passwordController,
              hintMessage: "Password",
              icon: Icons.lock,
              hideText: true,
              isPassword: true,
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {},
                  child: const Text("Forgot password?"),
                ),
              ],
            ),
            SizedBox(
              height: 25,
            ),
            CustomButton(
              text: "Login",
              onPressed: () {},
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Not a member?"),
                TextButton(onPressed: () {}, child: Text("Sign up")),
              ],
            )
          ],
        ),
      ),
    );
  }
}

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
