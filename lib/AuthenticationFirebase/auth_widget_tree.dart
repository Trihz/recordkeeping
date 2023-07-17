import 'package:flutter/material.dart';
import 'package:recordkeeping/AuthenticationFirebase/auth.dart';
import 'package:recordkeeping/AuthenticationFirebase/auth_homepage.dart';
import 'package:recordkeeping/AuthenticationFirebase/auth_login.dart';
import 'package:recordkeeping/homepage/homepage.dart';

class AuthWidgetTree extends StatefulWidget {
  const AuthWidgetTree({super.key});

  @override
  State<AuthWidgetTree> createState() => _AuthWidgetTreeState();
}

class _AuthWidgetTreeState extends State<AuthWidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().authStateChange,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return HomePage(userGmail: "Test");
        } else {
          return const LoginPage();
        }
      },
    );
  }
}
