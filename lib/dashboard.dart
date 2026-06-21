import 'package:flutter/material.dart';

import 'profile.dart';
import 'Page_1.dart';
import 'auth_services.dart';
import 'login.dart';
import 'note_page.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  // CARD WIDGET
  Widget card({
    required BuildContext context,
    required IconData icon,
    required String title,
    VoidCallback? onTap,
  }) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(15),
        leading: CircleAvatar(
          backgroundColor: Colors.teal.shade100,
          child: Icon(icon, color: Colors.teal),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 18),
        onTap: onTap,
      ),
    );
  }

  // OPEN NOTE PAGE
  void openNote(BuildContext context, String title) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => NotePage(title: title)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),

      appBar: AppBar(
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text("CAREDOCS"),

        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => Profile()),
              );
            },
          ),

          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await authServices.value.signout();

              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const Login()),
                (route) => false,
              );
            },
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            // HEADER
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.teal,
                borderRadius: BorderRadius.circular(20),
              ),

              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome Back 👋",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Manage patient records with ease.",
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "Quick Access",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            // 🟢 BIODATA (REAL PAGE)
            card(
              context: context,
              icon: Icons.person,
              title: "BIODATA",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => pageone()),
                );
              },
            ),

            // 🟢 NOTE-BASED SECTIONS
            card(
              context: context,
              icon: Icons.report_problem,
              title: "PATIENT COMPLAINT",
              onTap: () => openNote(context, "PATIENT COMPLAINT"),
            ),

            card(
              context: context,
              icon: Icons.medical_information,
              title: "PATIENT EXAMINATION",
              onTap: () => openNote(context, "PATIENT EXAMINATION"),
            ),

            card(
              context: context,
              icon: Icons.medication,
              title: "TREATMENT",
              onTap: () => openNote(context, "TREATMENT"),
            ),

            card(
              context: context,
              icon: Icons.science,
              title: "INVESTIGATIONS",
              onTap: () => openNote(context, "INVESTIGATIONS"),
            ),

            card(
              context: context,
              icon: Icons.calendar_month,
              title: "FOLLOW-UP & APPOINTMENT",
              onTap: () => openNote(context, "FOLLOW-UP & APPOINTMENT"),
            ),
          ],
        ),
      ),
    );
  }
}
