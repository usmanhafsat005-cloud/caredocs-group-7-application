import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // 1. IMPORT FIREBASE AUTH
import 'login.dart';

class changepassword extends StatelessWidget {
  changepassword({super.key});

  final ValueNotifier<String> emailNotifier = ValueNotifier<String>('');
  final ValueNotifier<String> currentPasswordNotifier = ValueNotifier<String>(
    '',
  );
  final ValueNotifier<String> newPasswordNotifier = ValueNotifier<String>('');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Change Password')),
      body: Column(
        children: [
          const Text('Use the form below to reset your password'),
          const SizedBox(height: 10),

          const Text('email'),
          TextFormField(onChanged: (value) => emailNotifier.value = value),
          const SizedBox(height: 10),

          const Text('Current password'),
          TextFormField(
            obscureText: true,
            onChanged: (value) => currentPasswordNotifier.value = value,
          ),
          const SizedBox(height: 10),

          const Text('New password'),
          TextFormField(
            obscureText: true,
            onChanged: (value) => newPasswordNotifier.value = value,
          ),
          const SizedBox(height: 10),

          AnimatedBuilder(
            animation: Listenable.merge([
              emailNotifier,
              currentPasswordNotifier,
              newPasswordNotifier,
            ]),
            builder: (context, child) {
              bool isFormValid =
                  emailNotifier.value.trim().isNotEmpty &&
                  currentPasswordNotifier.value.trim().isNotEmpty &&
                  newPasswordNotifier.value.trim().isNotEmpty;

              return ElevatedButton(
                onPressed: isFormValid
                    ? () async {
                        // 2. MAKE THIS FUNCTION ASYNC
                        try {
                          // Get the currently logged-in user
                          User? user = FirebaseAuth.instance.currentUser;

                          if (user != null) {
                            // 3. SECURE RE-AUTHENTICATION (Required by Firebase to change passwords)
                            AuthCredential credential =
                                EmailAuthProvider.credential(
                                  email: emailNotifier.value.trim(),
                                  password: currentPasswordNotifier.value
                                      .trim(),
                                );

                            await user.reauthenticateWithCredential(credential);

                            // 4. UPDATE THE PASSWORD ON THE SERVER
                            await user.updatePassword(
                              newPasswordNotifier.value.trim(),
                            );

                            // 5. SIGN OUT (Forces them to log back in with the new password)
                            await FirebaseAuth.instance.signOut();

                            // Success message
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Password updated successfully! Please log in again.',
                                ),
                              ),
                            );

                            // 6. ROUTE TO LOGIN PAGE
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => Login()),
                              (route) => false,
                            );
                          }
                        } on FirebaseAuthException catch (e) {
                          // Catch Firebase errors (e.g., "wrong current password")
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(e.message ?? 'An error occurred.'),
                            ),
                          );
                        } catch (e) {
                          print(e);
                        }
                      }
                    : null,
                child: const Text('Submit'),
              );
            },
          ),
        ],
      ),
    );
  }
}
