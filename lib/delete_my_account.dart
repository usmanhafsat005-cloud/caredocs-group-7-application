import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'delete_account_done.dart';

class DeleteMyAccount extends StatelessWidget {
  DeleteMyAccount({super.key});

  final ValueNotifier<String> passwordNotifier = ValueNotifier<String>('');

  Future<void> deleteAccount(BuildContext context) async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No user is currently signed in.')),
        );
        return;
      }

      await user.delete();

      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const deleteaccountdone()),
        );
      }
    } on FirebaseAuthException catch (e) {
      String message = e.message ?? 'Failed to delete account';

      if (e.code == 'requires-recent-login') {
        message =
            'For security reasons, please log in again before deleting your account.';
      }

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    } catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to delete account.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Delete Account')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text('Confirm Password'),
            const SizedBox(height: 10),
            TextFormField(
              obscureText: true,
              onChanged: (value) {
                passwordNotifier.value = value;
              },
            ),
            const SizedBox(height: 10),
            ValueListenableBuilder<String>(
              valueListenable: passwordNotifier,
              builder: (context, passwordValue, child) {
                return ElevatedButton(
                  onPressed: passwordValue.trim().isNotEmpty
                      ? () => deleteAccount(context)
                      : null,
                  child: const Text('Delete Account'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
