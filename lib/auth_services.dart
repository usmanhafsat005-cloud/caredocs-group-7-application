import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

ValueNotifier<AuthServices> authServices = ValueNotifier(AuthServices());

class AuthServices {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => firebaseAuth.authStateChanges();

  Future<UserCredential> signIn({
    required String emailAddress,
    required String userpassword,
  }) async {
    return await firebaseAuth.signInWithEmailAndPassword(
      email: emailAddress,
      password: userpassword,
    );
  }

  Future<UserCredential> register({
    required String emailAddress,
    required String userpassword,
  }) async {
    return await firebaseAuth.createUserWithEmailAndPassword(
      email: emailAddress,
      password: userpassword,
    );
  }

  Future<void> signout() async {
    await firebaseAuth.signOut();
  }

  Future<void> resetPassword({required String emailAddress}) async {
    await firebaseAuth.sendPasswordResetEmail(email: emailAddress);
  }

  Future<void> updateUsername({required String username}) async {
    await currentUser!.updateDisplayName(username);
  }

  Future<void> deleteAccount({
    required String email,
    required String password,
  }) async {
    AuthCredential credential = EmailAuthProvider.credential(
      email: email,
      password: password,
    );
    await currentUser!.reauthenticateWithCredential(credential);
    await currentUser!.delete();
    await firebaseAuth.signOut();
  }
 
  Future<void> resetPasswordFromCurrentPassword({
    required String currentPassword,
    required String newPassword,
    required String email,
  }) async {
    AuthCredential credential = EmailAuthProvider.credential(
      email: email,
      password: currentPassword,
    );
    await currentUser!.reauthenticateWithCredential(credential);
    await currentUser!.updatePassword(newPassword);
  }
}
