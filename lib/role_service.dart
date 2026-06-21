import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RoleService {
  static Future<String> getRole() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) return "patient";

    final doc = await FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid)
        .get();

    if (!doc.exists) return "patient";

    return doc.data()?["role"] ?? "patient";
  }
}
