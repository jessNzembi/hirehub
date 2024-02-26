import 'package:flutter/material.dart';
import 'package:hirehub/views/custombutton.dart';
import 'package:hirehub/views/customtextfield.dart';

class Signup extends StatelessWidget {
  const Signup({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController firstNameController = TextEditingController();
    TextEditingController lastNameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController password1Controller = TextEditingController();
    TextEditingController password2Controller = TextEditingController();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(50),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/job-search.png",
                width: 200,
                height: 200,
              ),
              SizedBox(
                height: 20,
              ),
              // Text(
              //   "Welcome",
              //   style: TextStyle(
              //       fontSize: 30,
              //       fontWeight: FontWeight.bold,
              //       color: Color.fromARGB(255, 78, 176, 221)),
              // ),
              // SizedBox(
              //   height: 10,
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Join Us Today",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 78, 176, 221)),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextField(
                userFieldController: firstNameController,
                hintMessage: "First Name",
                icon: Icons.person,
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextField(
                userFieldController: lastNameController,
                hintMessage: "Last Name",
                icon: Icons.person,
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextField(
                userFieldController: emailController,
                hintMessage: "Email",
                icon: Icons.mail,
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextField(
                userFieldController: password1Controller,
                hintMessage: "Password",
                icon: Icons.lock,
                hideText: true,
                isPassword: true,
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextField(
                userFieldController: password2Controller,
                hintMessage: "Confirm Password",
                icon: Icons.lock,
                hideText: true,
                isPassword: true,
              ),
              SizedBox(
                height: 25,
              ),
              CustomButton(
                text: "Sign Up",
                onPressed: () {},
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account?"),
                  TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                          foregroundColor: Color.fromARGB(255, 85, 170, 209)),
                      child: Text("login")),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
