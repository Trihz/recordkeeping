// ignore_for_file: avoid_print, non_constant_identifier_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hive/hive.dart';
import 'package:recordkeeping/AuthenticationFirebase/auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  /// variable to store the gradient color for containers
  Gradient gradient = const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Colors.orange,
      Colors.purple,
    ],
  );

  // Add this boolean variable to your State class
  bool isLoading = false;

  String? errorMessage = '';
  bool isLogin = true;

  bool isPasswordVisible = false;

  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();

  /// SIGN IN
  Future<void> signInWithEmailAndPassword() async {
    print("Auth class (SignIn) *********");
    saveGmail(controllerEmail.text);
    checkReferenceDate();

    setState(() {
      isLoading = true;
    });

    try {
      await Auth().signInWithEmailAndPassword(
        email: controllerEmail.text,
        password: controllerPassword.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
        showSnackBar(errorMessage!);
        isLoading = false; // Hide the circular progress indicator on error
      });
    }

    setState(() {
      isLoading = false; // Hide the circular progress indicator on success
    });
  }

  /// CREATE USER
  Future<void> creatUserWithEmailAndPassword() async {
    print("Auth class (Sign Up) *********");
    saveGmail(controllerEmail.text);
    checkReferenceDate();
    try {
      await Auth().createUserWithEmailAndPassowrd(
          email: controllerEmail.text, password: controllerPassword.text);
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
        showSnackBar(errorMessage!);
      });
    }
  }

  /// TEXTFIELD
  Widget entryField(String title, TextEditingController controller) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.06,
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      child: TextField(
        controller: controller,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          hintText: title,
          hintStyle:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
          border: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromARGB(255, 255, 255, 255),
              width: 0.5,
            ),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromARGB(255, 255, 255, 255),
              width: 0.5,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromARGB(255, 255, 255, 255),
              width: 0.5,
            ),
          ),
          disabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromARGB(255, 255, 255, 255),
              width: 0.5,
            ),
          ),
        ),
      ),
    );
  }

  /// TEXTFIELD PASSWORD
  Widget entryField_Password(String title, TextEditingController controller) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.06,
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      child: TextField(
        controller: controller,
        obscuringCharacter: "*",
        obscureText: !isPasswordVisible,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          suffixIcon: IconButton(
            icon: Icon(
              isPasswordVisible ? Icons.visibility : Icons.visibility_off,
              color: const Color.fromARGB(255, 255, 255, 255),
            ),
            onPressed: () {
              setState(() {
                isPasswordVisible = !isPasswordVisible;
              });
            },
          ),
          hintText: title,
          hintStyle:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
          border: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromARGB(255, 255, 255, 255),
              width: 0.5,
            ),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromARGB(255, 255, 255, 255),
              width: 0.5,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromARGB(255, 255, 255, 255),
              width: 0.5,
            ),
          ),
          disabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromARGB(255, 255, 255, 255),
              width: 0.5,
            ),
          ),
        ),
      ),
    );
  }

  /// ERROR MESSAGE
  Widget errorMessageDisplay() {
    return Text(errorMessage == '' ? '' : 'Humm ? $errorMessage');
  }

  /// SUBMIT BUTTON
  Widget submitButton() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.06,
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(
        gradient: gradient,
      ),
      child: ElevatedButton(
          onPressed: isLogin
              ? signInWithEmailAndPassword
              : creatUserWithEmailAndPassword,
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white, foregroundColor: Colors.black),
          child: Text(
            isLogin ? 'LOGIN' : 'REGISTER',
            style: const TextStyle(color: Colors.black, fontSize: 16),
          )),
    );
  }

  /// LOGIN OR REGISTER TEXT
  Widget loginOrRegister() {
    return TextButton(
        onPressed: () {
          setState(() {
            isLogin = !isLogin;
          });
        },
        child: Text(
          isLogin ? 'Register instead' : 'Login instead',
          style: const TextStyle(color: Colors.white, fontSize: 13),
        ));
  }

  /// record data errors snackbar
  void showSnackBar(String snackbarMessage) {
    final snackBar = SnackBar(
      backgroundColor: Colors.white,
      padding: const EdgeInsets.all(0),
      duration: const Duration(milliseconds: 1000),
      content: Container(
        height: MediaQuery.of(context).size.height * 0.1,
        width: MediaQuery.of(context).size.width * 1,
        padding: const EdgeInsets.only(left: 10, right: 10),
        decoration: BoxDecoration(gradient: gradient),
        child: Center(
          child: Text(
            snackbarMessage,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w400, fontSize: 15),
          ),
        ),
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  /// save the user gmail to local database
  void saveGmail(String userGmail) {
    var localDatabase = Hive.box('Gmail');
    localDatabase.put('gmail', userGmail);
  }

  /// get current date
  /// function to save the reference date is called within this function
  void getCurrentDate() {
    DateTime currentDate = DateTime.now();
    String currentMonth = currentDate.month.toString();
    String currentDay = currentDate.day.toString();
    if (currentMonth.length == 1) {
      currentMonth = "0$currentMonth";
    }
    if (currentDay.length == 1) {
      currentDay = "0$currentMonth";
    }
    String formattedDate = "${currentDate.year}-$currentMonth-$currentDay";
    saveReferenceDate_1(formattedDate);
    saveReferenceDate_3(formattedDate);
    saveReferenceDate_6(formattedDate);
    saveReferenceDate_12(formattedDate);
    print(formattedDate);
  }

  /// function to check whether the reference date has already been set
  /// the reference date should be set only once
  /// thus the app has to check wether the date has been set each time during login or setup to avoid setting up the reference date again
  /// getCurrentDate() function is called within this function
  void checkReferenceDate() async {
    var localDatabase = Hive.box('Date');
    bool containsKey0 = localDatabase.containsKey('date1');
    bool containsKey1 = localDatabase.containsKey('date3');
    bool containsKey2 = localDatabase.containsKey('date6');
    bool containsKey3 = localDatabase.containsKey('date12');
    print(containsKey0);
    print(containsKey1);
    print(containsKey2);
    print(containsKey3);
    if (!containsKey0 && !containsKey1 && !containsKey2 && !containsKey3) {
      localDatabase.put('date1', "");
      localDatabase.put('date3', "");
      localDatabase.put('date6', "");
      localDatabase.put('date12', "");
    }
    String referenceDate0 = await localDatabase.get('date1');
    String referenceDate1 = await localDatabase.get('date3');
    String referenceDate2 = await localDatabase.get('date6');
    String referenceDate3 = await localDatabase.get('date12');
    print("***$referenceDate0");
    print("***$referenceDate1");
    print("***$referenceDate2");
    print("***$referenceDate3");
    if (referenceDate0.isEmpty ||
        referenceDate1.isEmpty ||
        referenceDate2.isEmpty ||
        referenceDate3.isEmpty) {
      getCurrentDate();
      print("FALSE");
    } else {
      print("TRUE");
    }
  }

  /// save current date to the database
  void saveReferenceDate_1(String referenceDate) {
    var localDatabase = Hive.box('Date');
    localDatabase.put('date1', referenceDate);
  }

  /// save current date to the database
  void saveReferenceDate_3(String referenceDate) {
    var localDatabase = Hive.box('Date');
    localDatabase.put('date3', referenceDate);
  }

  /// save current date to the database
  void saveReferenceDate_6(String referenceDate) {
    var localDatabase = Hive.box('Date');
    localDatabase.put('date6', referenceDate);
  }

  /// save current date to the database
  void saveReferenceDate_12(String referenceDate) {
    var localDatabase = Hive.box('Date');
    localDatabase.put('date12', referenceDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Center(
          child: isLoading
              ? Container(
                  height: 100,
                  width: 100,
                  decoration: const BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: Center(
                    child: Stack(
                      children: [
                        Center(
                          child: Container(
                              height: 100,
                              width: 100,
                              decoration: const BoxDecoration(
                                  color: Colors.transparent),
                              child: const SpinKitCircle(
                                  color: Colors.orange, size: 100)),
                        ),
                      ],
                    ),
                  ),
                )
              : Container(
                  height: MediaQuery.of(context).size.height * 0.35,
                  width: MediaQuery.of(context).size.width * 0.8,
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
                  decoration: BoxDecoration(
                      gradient: gradient,
                      borderRadius: const BorderRadius.all(Radius.circular(5))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      entryField("email", controllerEmail),
                      entryField_Password("password", controllerPassword),
                      submitButton(),
                      loginOrRegister()
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
