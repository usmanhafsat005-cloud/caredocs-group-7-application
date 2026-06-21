import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';
import 'auth_layout.dart';
import 'app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const CareDocs());
}

class CareDocs extends StatelessWidget {
  const CareDocs({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CAREDOCS',

      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,

      // Automatically follows the phone's setting
      themeMode: ThemeMode.system,

      home: AuthLayout(),
    );
  }
}

class AppTheme {
  static ThemeData? get lightTheme => null;

  static ThemeData? get darkTheme => null;
}
