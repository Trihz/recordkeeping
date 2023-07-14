// ignore_for_file: avoid_print

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:recordkeeping/authentication/login.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  /// variable to store the gradient color for containers
  Gradient gradient = const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Colors.orange,
      Colors.purple,
    ],
  );

  /// variables to store the user details
  String userName = "";
  String userGmail = "";
  String userPassword = "";
  String userPassword2 = "";

  /// LOGIN widget
  Widget displaySignUp() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.55,
      width: MediaQuery.of(context).size.width * 0.8,
      padding: const EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Text(
            "Sign up",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w400, fontSize: 22),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.05,
            width: MediaQuery.of(context).size.width * 0.7,
            decoration: const BoxDecoration(
              color: Colors.transparent,
            ),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  userName = value;
                });
              },
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.person,
                  size: 20,
                  color: Colors.white,
                ),
                isCollapsed: true,
                iconColor: Colors.white,
                hintText: "Name",
                contentPadding: EdgeInsets.all(10.0),
                hintStyle: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w200,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                    width: 1.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                    width: 1.0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                    width: 1.0,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.05,
            width: MediaQuery.of(context).size.width * 0.7,
            decoration: const BoxDecoration(
              color: Colors.transparent,
            ),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  userGmail = value;
                });
              },
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.mail,
                  size: 20,
                  color: Colors.white,
                ),
                isCollapsed: true,
                iconColor: Colors.white,
                hintText: "Gmail",
                contentPadding: EdgeInsets.all(10.0),
                hintStyle:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w200),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                    width: 1.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                    width: 1.0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                    width: 1.0,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.05,
            width: MediaQuery.of(context).size.width * 0.7,
            decoration: const BoxDecoration(
              color: Colors.transparent,
            ),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  userPassword = value;
                });
              },
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.password,
                  size: 20,
                  color: Colors.white,
                ),
                isCollapsed: true,
                iconColor: Colors.white,
                hintText: "Password",
                contentPadding: EdgeInsets.all(10.0),
                hintStyle:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w200),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                    width: 1.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                    width: 1.0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                    width: 1.0,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.05,
            width: MediaQuery.of(context).size.width * 0.7,
            decoration: const BoxDecoration(
              color: Colors.transparent,
            ),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  userPassword2 = value;
                });
              },
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.password,
                  size: 20,
                  color: Colors.white,
                ),
                isCollapsed: true,
                iconColor: Colors.white,
                hintText: "Confirm password",
                contentPadding: EdgeInsets.all(10.0),
                hintStyle:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w200),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                    width: 1.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                    width: 1.0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                    width: 1.0,
                  ),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.05,
                width: MediaQuery.of(context).size.width * 0.3,
                margin: const EdgeInsets.only(left: 10),
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => const Authentication())));
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)))),
                  child: const Text(
                    "LOGIN",
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.05,
                width: MediaQuery.of(context).size.width * 0.3,
                margin: const EdgeInsets.only(right: 10),
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
                child: ElevatedButton(
                  onPressed: () {
                    checkDetails();
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)))),
                  child: const Text(
                    "SIGNUP",
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height * 1,
        width: MediaQuery.of(context).size.width * 1,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Center(
          child: displaySignUp(),
        ),
      ),
    );
  }

  /// alert dialog to indicate that the record has been saved successfully
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
                  Column(
                    children: const [
                      Text(
                        "You have been registered successfully,",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 15),
                      ),
                      Text(
                        " you can now login",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 16),
                      ),
                    ],
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.05,
                    width: MediaQuery.of(context).size.width * 0.3,
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) =>
                                    const Authentication())));
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.blueAccent,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)))),
                      child: const Text(
                        "LOGIN",
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 15),
                      ),
                    ),
                  ),
                ],
              )),
        );
      },
    );
  }

  /// function to sign up the user
  void registerUser() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("users");

    await ref
        .child(userName)
        .set({"username": userName, "userpassword": userPassword});
  }

  /// check whether all the details have been entered
  void checkDetails() {
    if (userName.isEmpty ||
        userGmail.isEmpty ||
        userPassword.isEmpty ||
        userPassword2.isEmpty) {
      showSnackBar("Please enter all the details");
    } else {
      checkPasswordMatching();
    }
  }

  /// check whether the passwords are matching
  void checkPasswordMatching() {
    if (userPassword != userPassword2) {
      showSnackBar("Passwords are not matching");
    } else {
      registerUser();
      success(context);
    }
  }

  /// signup errors snackbar
  void showSnackBar(String snackbarMessage) {
    final snackBar = SnackBar(
      backgroundColor: Colors.blueAccent,
      padding: const EdgeInsets.all(0),
      duration: const Duration(milliseconds: 600),
      content: Container(
        height: MediaQuery.of(context).size.height * 0.06,
        width: MediaQuery.of(context).size.width * 1,
        decoration: const BoxDecoration(color: Colors.transparent),
        child: Center(
          child: Text(
            snackbarMessage,
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.w400, fontSize: 18),
          ),
        ),
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
