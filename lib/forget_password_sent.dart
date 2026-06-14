import 'package:flutter/material.dart';

class ForgetPasswordSent extends StatelessWidget {
  const ForgetPasswordSent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text("Password reset link has been sent to your email"),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Back"),
            ),
          ],
        ),
      ),
    );
  }
}
