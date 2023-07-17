import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recordkeeping/AuthenticationFirebase/auth.dart';

class HompePageAuth extends StatelessWidget {
  HompePageAuth({super.key});

  final User? user = Auth().currentUser;

  Future<void> signOut() async {
    await Auth().signOut();
  }

  Widget title() {
    return const Text('Firebase auth');
  }

  Widget userUid() {
    return Text(user?.email ?? 'User email');
  }

  Widget signOutButton() {
    return ElevatedButton(onPressed: signOut, child: Text("Sign Out"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [userUid(), signOutButton()],
      ),
    );
  }
}
