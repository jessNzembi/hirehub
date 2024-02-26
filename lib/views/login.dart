import 'package:flutter/material.dart';
import 'package:hirehub/views/custombutton.dart';
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/job-search.png", width: 200, height: 200,),
              SizedBox(
                height: 20,
              ),
              Text(
                "Welcome",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 78, 176, 221)),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Login To Continue",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 78, 176, 221)),
                  ),
                ],
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
                    style: TextButton.styleFrom(
                      foregroundColor: Color.fromARGB(255, 85, 170, 209)
                    ),
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
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      foregroundColor: Color.fromARGB(255, 85, 170, 209)
                    ),
                    child: Text("Sign up")
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
