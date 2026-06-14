import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // 1. Added Firebase Auth import
import 'LOGIN.dart';

class changeusername extends StatelessWidget {
  changeusername({super.key});

  // 2. Create a ValueNotifier to track the username string dynamically
  final ValueNotifier<String> usernameNotifier = ValueNotifier<String>('');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Change Username')),
      body: Column(
        children: [
          const Text('Confirm New Username'), // Fixed typo 'Uesrname'
          const SizedBox(height: 10),

          TextFormField(
            onChanged: (value) {
              // 3. Update notifier value as the user types
              usernameNotifier.value = value;
            },
          ),
          const SizedBox(height: 10),

          // 4. Wrap the button in a ValueListenableBuilder
          ValueListenableBuilder<String>(
            valueListenable: usernameNotifier,
            builder: (context, usernameValue, child) {
              // Check if the username text field is not empty
              bool isFormValid = usernameValue.trim().isNotEmpty;

              return ElevatedButton(
                // 5. Button is active only if text is entered, otherwise it's null (disabled)
                onPressed: isFormValid
                    ? () async {
                        try {
                          // Get the current logged-in user
                          User? user = FirebaseAuth.instance.currentUser;

                          if (user != null) {
                            // 6. Update the display name in Firebase backend
                            await user.updateDisplayName(usernameValue.trim());

                            // Optional: Alert the user it worked
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Username updated successfully!'),
                              ),
                            );

                            // 7. Route back to Login screen
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => Login()),
                              (route) => false,
                            );
                          }
                        } catch (e) {
                          // Handle errors (e.g., connection issues)
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Error: ${e.toString()}')),
                          );
                        }
                      }
                    : null, // Disables button visually and functionally
                child: const Text('Submit'),
              );
            },
          ),
        ],
      ),
    );
  }
}
