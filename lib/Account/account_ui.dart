import 'package:flutter/material.dart';

class AccountUI extends StatefulWidget {
  const AccountUI({super.key});

  @override
  State<AccountUI> createState() => _AccountUIState();
}

class _AccountUIState extends State<AccountUI> {
  /// widget for changing user name
  Widget changeUserName() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.2,
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Change username",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w300, fontSize: 19),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.05,
            width: MediaQuery.of(context).size.width * 0.7,
            decoration: const BoxDecoration(
              color: Colors.transparent,
            ),
            child: TextField(
              onChanged: (value) {
                setState(() {});
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
          Container(
            height: MediaQuery.of(context).size.height * 0.04,
            width: MediaQuery.of(context).size.width * 0.3,
            decoration: const BoxDecoration(
              color: Colors.transparent,
            ),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)))),
              child: const Text(
                "CHANGE",
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
              ),
            ),
          ),
        ],
      ),
    );
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
                    color: Colors.blueAccent),
              ),
              changeUserName()
            ],
          ),
        ),
      ),
    );
  }
}
