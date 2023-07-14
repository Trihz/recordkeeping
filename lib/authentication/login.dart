// ignore_for_file: non_constant_identifier_names, avoid_print

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:recordkeeping/authentication/signup.dart';
import 'package:recordkeeping/homepage/homepage.dart';

class Authentication extends StatefulWidget {
  const Authentication({super.key});

  @override
  State<Authentication> createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  /// variable to store the password and username of the user
  String userName = "";
  String userPassword = "";
  String userPassword_Database = "";

  /// LOGIN widget
  Widget displayLogin() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      width: MediaQuery.of(context).size.width * 0.7,
      padding: const EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
        color: Colors.blueAccent,
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
            "Login",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w600, fontSize: 22),
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
                hintStyle:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
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
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
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
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
                child: ElevatedButton(
                  onPressed: () {
                    loginUser();
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.blueAccent,
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
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => const SignUp())));
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.blueAccent,
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
          color: Colors.blueAccent,
        ),
        child: Center(
          child: displayLogin(),
        ),
      ),
    );
  }

  /// function to login the user
  void loginUser() async {
    print(userName);
    print(userPassword);
    if (userName.isEmpty || userPassword.isEmpty) {
      print("Enter all details");
    } else {
      DatabaseReference databaseReference = FirebaseDatabase.instance
          .ref()
          .child("users")
          .child(userName)
          .child("userpassword");

      databaseReference.onValue.listen((event) {
        setState(() {
          userPassword_Database = event.snapshot.value.toString();
        });
      });
      print(userPassword_Database);
      if (userPassword_Database == "null") {
        print("The user does not exists");
      } else {
        if (userPassword_Database == userPassword) {
          print("Passwords are matching");
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: ((context) => HomePage(
                        userName: userName,
                      ))),
              (route) => false);
        } else {
          print("Passwords not matching");
        }
      }
    }
  }
}