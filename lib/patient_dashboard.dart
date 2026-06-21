import 'package:flutter/material.dart';

class PatientDashboard extends StatelessWidget {
  const PatientDashboard({super.key});

  Widget card({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.teal.shade100,
          child: Icon(icon, color: Colors.teal),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),

      appBar: AppBar(
        title: const Text("Patient Portal"),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),

        children: [
          // 🏥 HEADER
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.teal,
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome 👋",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  "Your personal medical portal",
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // 🔒 SECURITY NOTICE
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.teal.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              "🔒 This is a read-only medical view. Only healthcare providers can modify records.",
              style: TextStyle(color: Colors.teal),
            ),
          ),

          const SizedBox(height: 20),

          // 🧠 MEDICAL SECTIONS
          card(
            icon: Icons.health_and_safety,
            title: "Diagnosis Summary",
            subtitle: "Available after consultation",
          ),

          card(
            icon: Icons.medication,
            title: "Treatment Plan",
            subtitle: "View only medical prescriptions",
          ),

          card(
            icon: Icons.calendar_month,
            title: "Appointments",
            subtitle: "Upcoming and past visits",
          ),

          card(
            icon: Icons.receipt_long,
            title: "Doctor Notes",
            subtitle: "Read-only provider notes",
          ),

          card(
            icon: Icons.history,
            title: "Medical History",
            subtitle: "Your health timeline",
          ),
        ],
      ),
    );
  }
}
