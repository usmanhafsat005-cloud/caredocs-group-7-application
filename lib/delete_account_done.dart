import 'package:flutter/material.dart';
import 'LOGIN.dart';

class deleteaccountdone extends StatelessWidget {
  const deleteaccountdone({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Delete Account")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Your account has been successfully deleted.'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                  (route) => false,
                );
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
