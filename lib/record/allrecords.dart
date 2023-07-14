// ignore_for_file: must_be_immutable, avoid_print

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class AllRecords extends StatefulWidget {
  String userName = "";
  AllRecords({super.key, required this.userName});

  @override
  State<AllRecords> createState() => _AllRecordsState();
}

class _AllRecordsState extends State<AllRecords> {
  /// widget to show the top container
  Widget topContainer() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.05,
      width: MediaQuery.of(context).size.width * 0.95,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        children: [
          const SizedBox(
            width: 5,
          ),
          const SizedBox(
            width: 10,
          ),
          /*GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => const HomePage())));
              },
              child: const Icon(
                Icons.arrow_back_ios,
                color: Colors.blueAccent,
                size: 20,
              )),*/
          SizedBox(
            width: MediaQuery.of(context).size.height * 0.15,
          ),
          const Text(
            "All Records",
            style: TextStyle(
                color: Colors.orange,
                fontWeight: FontWeight.w400,
                fontSize: 19),
          ),
        ],
      ),
    );
  }

  /// widget to display a list of all the reports
  Widget recordsDisplay() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      width: MediaQuery.of(context).size.width * 0.95,
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.all(10),
          itemCount: recordsDetails.length,
          itemBuilder: ((context, index) {
            return Container(
              width: MediaQuery.of(context).size.width * 1,
              margin: const EdgeInsets.only(bottom: 30, left: 10, right: 10),
              padding: const EdgeInsets.only(
                  left: 10, right: 10, top: 10, bottom: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color:
                        const Color.fromARGB(255, 99, 99, 99).withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: const Offset(0, 1), // changes position of shadow
                  ),
                ],
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          recordsDetails[index]["title"],
                          style: const TextStyle(
                              fontSize: 17,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "( ${recordsDetails[index]["date"]} )",
                          style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        recordsDetails[index]["description"],
                        style: const TextStyle(
                            wordSpacing: 2,
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.w300),
                      ),
                    ),
                  ],
                ),
              ),
            );
          })),
    );
  }

  /// initial function of the screen
  @override
  void initState() {
    getAllRecords();
    super.initState();
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.08),
            topContainer(),
            recordsDisplay()
          ],
        ),
      ),
    );
  }

  /// variables to store the details of all the records
  List recordsDetails = [];

  /// function to return the details of all the records
  void getAllRecords() {
    DatabaseReference databaseReference = FirebaseDatabase.instance
        .ref()
        .child("info")
        .child(widget.userName)
        .child("records");
    databaseReference.onValue.listen((DatabaseEvent event) {
      for (var data in event.snapshot.children) {
        setState(() {
          recordsDetails.add(data.value);
        });
      }
      print(recordsDetails[0]["title"]);
      print(recordsDetails[0]["description"]);
    });
  }
}
