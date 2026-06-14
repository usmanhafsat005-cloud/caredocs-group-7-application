import 'package:flutter/material.dart';
import 'auth_services.dart';
import 'app_loading_page.dart';
import 'dashboard.dart';
import 'login.dart';

class AuthLayout extends StatelessWidget {
  const AuthLayout({super.key, this.widgetIfNotConnected});

  final Widget? widgetIfNotConnected;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: authServices,
      builder: (context, authServices, child) {
        return StreamBuilder(
          stream: authServices.authStateChanges,
          builder: (context, snapshot) {
            Widget widget;
            if (snapshot.connectionState == ConnectionState.waiting) {
              widget = AppLoadingPage();
            } else if (snapshot.hasData) {
              widget = Dashboard();
            } else {
              widget = Login();
            }
            return widget;
          },
        );
      },
    );
  }
}
