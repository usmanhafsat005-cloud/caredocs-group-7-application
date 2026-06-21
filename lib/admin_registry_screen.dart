import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminRegistryScreen extends StatelessWidget {
  const AdminRegistryScreen({super.key});

  Stream<QuerySnapshot> getUsers() {
    return FirebaseFirestore.instance.collection("users").snapshots();
  }

  Widget userCard(Map<String, dynamic> data) {
    final role = data["role"] ?? "patient";
    final name = data["name"] ?? "No name";
    final email = data["email"] ?? "No email";

    Color roleColor = role == "provider" ? Colors.blue : Colors.green;
    IconData roleIcon = role == "provider"
        ? Icons.medical_services
        : Icons.person;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: roleColor.withOpacity(0.2),
          child: Icon(roleIcon, color: roleColor),
        ),

        title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),

        subtitle: Text(email),

        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: roleColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            role.toUpperCase(),
            style: TextStyle(
              color: roleColor,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),

      appBar: AppBar(
        title: const Text("Admin Registry"),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),

      body: StreamBuilder<QuerySnapshot>(
        stream: getUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No users found"));
          }

          final users = snapshot.data!.docs;

          // 🔥 SPLIT USERS
          final patients = users
              .where((u) => (u["role"] ?? "") == "patient")
              .toList();

          final providers = users
              .where((u) => (u["role"] ?? "") == "provider")
              .toList();

          return ListView(
            padding: const EdgeInsets.all(16),

            children: [
              const Text(
                "🧑‍⚕️ Healthcare Providers",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),

              ...providers.map(
                (u) => userCard(u.data() as Map<String, dynamic>),
              ),

              const SizedBox(height: 20),

              const Text(
                "👤 Patients",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),

              ...patients.map(
                (u) => userCard(u.data() as Map<String, dynamic>),
              ),
            ],
          );
        },
      ),
    );
  }
}
