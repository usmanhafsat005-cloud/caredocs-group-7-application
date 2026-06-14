import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'auth_services.dart';
import 'login.dart';
import 'dashboard.dart';

class SignUp extends StatelessWidget {
  SignUp({super.key});

  String email = "";
  String password = "";

  void register(BuildContext context) async {
    try {
      print(email);
      print(password);
      await authServices.value.register(
        emailAddress: email,
        userpassword: password,
      );
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Dashboard()),
        (route) => false,
      );
    } on FirebaseAuthException catch (error) {
      print(error.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sign up")),
      body: Column(
        children: [
          Text("Welcome to CAREDOCS, Create an account to start"),
          SizedBox(height: 20),
          Text("Full Name:"),
          TextFormField(),
          SizedBox(height: 10),
          Text("Email Address:"),
          TextFormField(
            onChanged: (value) {
              email = value;
            },
          ),
          SizedBox(height: 10),
          Text("Phone Number:"),
          TextFormField(),
          SizedBox(height: 10),
          Text("Password:"),
          TextFormField(
            obscureText: true,
            onChanged: (value) {
              password = value;
            },
          ),
          SizedBox(height: 10),
          Text("Confirm Password"),
          TextFormField(obscureText: true),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              register(context);
            },
            child: Text("Create Account"),
          ),
          SizedBox(height: 20),
          Text("Already have an account?"),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Login()),
              );
            },
            child: Text("Back to Login"),
          ),
        ],
      ),
    );
  }
}
