import 'package:caredocs_apps/auth_services.dart';
import 'package:caredocs_apps/dashboard.dart';
import 'package:caredocs_apps/patient_dashboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Future<void> register(BuildContext context) async {
  bool isLoading = false;
  setState(() => isLoading = true);

  try {
    // 🔐 CREATE ACCOUNT
    String email = '';
    String password = '';
    final credential = await authServices.value.register(
      emailAddress: email,
      userpassword: password,
    );

    // ✅ IMPORTANT FIX: GET USER FROM CREDENTIAL
    final user = credential.user;

    if (user == null) {
      throw Exception("User creation failed");
    }

    // 🧠 SAVE USER DATA
    var name;
    var phone;
    var role;
    await FirebaseFirestore.instance.collection("users").doc(user.uid).set({
      "name": name,
      "email": email,
      "phone": phone,
      "role": role,
      "createdAt": DateTime.now(),
    });

    // 👤 PATIENT DATA
    if (role == "patient") {
      await FirebaseFirestore.instance.collection("patients").doc(user.uid).set(
        {"medicalHistory": []},
      );
    }

    // 🧑‍⚕️ PROVIDER DATA
    if (role == "provider") {
      var hospital;
      var department;
      var licenseId;
      await FirebaseFirestore.instance
          .collection("providers")
          .doc(user.uid)
          .set({
            "hospital": hospital,
            "department": department,
            "licenseId": licenseId,
            "verified": false,
          });
    }

    final bool mounted = true;
    if (!mounted) return;

    // ⏳ small delay for safety
    await Future.delayed(const Duration(milliseconds: 300));

    // 🧠 ROLE ROUTING (NO FIRESTORE RE-READ NEEDED)
    if (role == "provider") {
      Navigator.pushAndRemoveUntil(
        // ignore: use_build_context_synchronously
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
    ).showSnackBar(SnackBar(content: Text("Signup failed: $e")));
  } finally {
    final bool mounted = true;
    if (mounted) {
      setState(() => isLoading = false);
    }
  }
}

void setState(bool Function() param0) {}
