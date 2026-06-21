import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'auth_services.dart';
import 'dashboard.dart';
import 'patient_dashboard.dart';
import 'login.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String email = "";
  String password = "";
  String name = "";
  String phone = "";

  String role = "patient";

  String hospital = "";
  String department = "";
  String licenseId = "";

  bool isLoading = false;

  Future<void> register() async {
    setState(() => isLoading = true);

    try {
      // 🔐 CREATE USER
      final credential = await authServices.value.register(
        emailAddress: email.trim(),
        userpassword: password.trim(),
      );

      final user = credential.user;

      if (user == null) {
        throw Exception("User creation failed");
      }

      // 🧠 SAVE USER DATA
      await FirebaseFirestore.instance.collection("users").doc(user.uid).set({
        "name": name.trim(),
        "email": email.trim(),
        "phone": phone.trim(),
        "role": role,
        "createdAt": FieldValue.serverTimestamp(),
      });

      // 👤 PATIENT DATA
      if (role == "patient") {
        await FirebaseFirestore.instance
            .collection("patients")
            .doc(user.uid)
            .set({"medicalHistory": []});
      }

      // 🧑‍⚕️ PROVIDER DATA
      if (role == "provider") {
        await FirebaseFirestore.instance
            .collection("providers")
            .doc(user.uid)
            .set({
              "hospital": hospital.trim(),
              "department": department.trim(),
              "licenseId": licenseId.trim(),
              "verified": false,
            });
      }

      // 🔄 ENSURE AUTH STATE IS READY
      await FirebaseAuth.instance.currentUser?.reload();

      if (!mounted) return;

      // 🚀 AUTO ROUTE (NO LOGIN SCREEN)
      if (role == "provider") {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const Dashboard()),
          (route) => false,
        );
      } else {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const PatientDashboard()),
          (route) => false,
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Signup error: $e")));
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create Account")),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            const Text(
              "Welcome to CAREDOCS 👋",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            const Text(
              "Select Account Type:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            Row(
              children: [
                Radio(
                  value: "patient",
                  groupValue: role,
                  onChanged: (value) {
                    setState(() => role = value.toString());
                  },
                ),
                const Text("Patient"),

                Radio(
                  value: "provider",
                  groupValue: role,
                  onChanged: (value) {
                    setState(() => role = value.toString());
                  },
                ),
                const Text("Healthcare Provider"),
              ],
            ),

            const SizedBox(height: 10),

            const Text("Full Name"),
            TextFormField(onChanged: (v) => name = v),

            const SizedBox(height: 10),

            const Text("Phone Number"),
            TextFormField(onChanged: (v) => phone = v),

            const SizedBox(height: 10),

            const Text("Email"),
            TextFormField(onChanged: (v) => email = v),

            const SizedBox(height: 10),

            const Text("Password"),
            TextFormField(obscureText: true, onChanged: (v) => password = v),

            const SizedBox(height: 15),

            // 🧑‍⚕️ PROVIDER FIELDS
            if (role == "provider") ...[
              const Divider(),
              const Text(
                "Hospital Information",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),

              const Text("Hospital Name"),
              TextFormField(onChanged: (v) => hospital = v),

              const SizedBox(height: 10),

              const Text("Department"),
              TextFormField(onChanged: (v) => department = v),

              const SizedBox(height: 10),

              const Text("License ID"),
              TextFormField(onChanged: (v) => licenseId = v),
            ],

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: isLoading ? null : register,
                child: isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text("Create Account"),
              ),
            ),

            const SizedBox(height: 20),

            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const Login()),
                  );
                },
                child: const Text("Already have an account? Login"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
