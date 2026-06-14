import 'package:flutter/material.dart';
import 'profile.dart';
import 'Page_1.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CAREDOCS"),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Profile()),
              );
            },
            child: Icon(Icons.person),
          ),
        ],
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => pageone()),
              );
            },
            child: Card(child: ListTile(title: Text("BIODATA"))),
          ),
          GestureDetector(
            onTap: null,
            child: Card(child: ListTile(title: Text("PATIENT COMPLAINT"))),
          ),
          GestureDetector(
            onTap: null,
            child: Card(child: ListTile(title: Text("PATIENT EXAMINATION"))),
          ),
          GestureDetector(
            onTap: null,
            child: Card(child: ListTile(title: Text("TREATMENT"))),
          ),
          GestureDetector(
            onTap: null,
            child: Card(child: ListTile(title: Text("INVESTIGATIONS"))),
          ),
          GestureDetector(
            onTap: null,
            child: Card(
              child: ListTile(title: Text("FOLLOW-UP & APPOINTMENT")),
            ),
          ),
        ],
      ),
    );
  }
}
