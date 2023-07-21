// ignore_for_file: non_constant_identifier_names

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:recordkeeping/gradient/gradient_class.dart';

import '../homepage/homepage.dart';

class AccountUI extends StatefulWidget {
  String userGmail = "";
  AccountUI({super.key, required this.userGmail});

  @override
  State<AccountUI> createState() => _AccountUIState();
}

class _AccountUIState extends State<AccountUI> {
  /// GRADIENT
  Gradient gradient = const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Colors.orange,
      Colors.purple,
    ],
  );

  /// string varaible to store the new username
  String newUsername = "";

  /// widget for changing user name
  Widget changeUserName() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.15,
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Align(
            alignment: Alignment.center,
            child: Text(
              "Change username",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w300,
                  fontSize: 16),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.04,
              width: MediaQuery.of(context).size.width * 0.5,
              decoration: const BoxDecoration(
                color: Colors.transparent,
              ),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    newUsername = value;
                  });
                },
                decoration: const InputDecoration(
                  prefixIcon: Icon(
                    Icons.person,
                    size: 20,
                    color: Color.fromARGB(255, 134, 134, 134),
                  ),
                  isCollapsed: true,
                  hintText: "New username",
                  contentPadding: EdgeInsets.all(10.0),
                  hintStyle: TextStyle(
                      color: Color.fromARGB(255, 134, 134, 134),
                      fontSize: 12,
                      fontWeight: FontWeight.w300),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 134, 134, 134),
                      width: 1.0,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 134, 134, 134),
                      width: 1.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 134, 134, 134),
                      width: 1.0,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.04,
              width: MediaQuery.of(context).size.width * 0.3,
              decoration: const BoxDecoration(
                color: Colors.transparent,
              ),
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    print("Chnage username");
                    changeUsername_Function();
                    success(context);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.shade200,
                      foregroundColor: Colors.white,
                      shadowColor: Colors.grey,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)))),
                  child: const Text(
                    "CHANGE",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                        color: Colors.black),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// initial function of the screen
  @override
  void initState() {
    print(widget.userGmail);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.8,
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: const BoxDecoration(
            color: Colors.transparent,
          ),
          child: Column(
            children: [
              const Text(
                "Account Settings",
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                    color: Colors.orange),
              ),
              const SizedBox(
                height: 15,
              ),
              changeUserName()
            ],
          ),
        ),
      ),
    );
  }

  /// function to change the username
  void changeUsername_Function() async {
    DatabaseReference databaseReference = FirebaseDatabase.instance
        .ref()
        .child("users")
        .child(removeSpecialCharacters(widget.userGmail));
    await databaseReference.update({"username": newUsername});
  }

  /// Remove special characters
  String removeSpecialCharacters(String input) {
    final regex = RegExp(r'[^\w\s]');
    return input.replaceAll(regex, '');
  }

  /// SUCCESS DIALOG
  void success(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
              height: MediaQuery.of(context).size.height * 0.2,
              width: MediaQuery.of(context).size.width * 1,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    "Username changed successfully",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 14),
                  ),
                  GradientIcon(
                      Icons.check_circle_outline_rounded, 50, gradient),
                  const SizedBox(height: 10),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => const HomePage())));
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey.shade200,
                          foregroundColor: Colors.black,
                          shadowColor: Colors.grey),
                      child: const Text("HOME"))
                ],
              )),
        );
      },
    );
  }
}
