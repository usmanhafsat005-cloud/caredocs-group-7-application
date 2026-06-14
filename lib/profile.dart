import 'package:flutter/material.dart';
import 'auth_services.dart';
import 'change_username.dart';
import 'change_password.dart';
import 'delete_my_account.dart';
import 'login.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile")),
      body: Column(
        children: [
          Card(child: ListTile(title: Text("Full Name:"))),
          Card(child: ListTile(title: Text("Email:"))),
          Card(child: ListTile(title: Text("Phone Number:"))),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              authServices.value.signout();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => Login()),
                (route) => false,
              );

              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => Login()),
              // );
            },
            child: Text("Logout"),
          ),
          SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => changeusername()),
              );
            },
            child: Text("Change Username"),
          ),
          SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => changepassword()),
              );
            },
            child: Text("Change Password"),
          ),
          SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DeleteMyAccount()),
              );
            },
            child: Text("Delete Account"),
          ),
        ],
      ),
    );
  }
}
