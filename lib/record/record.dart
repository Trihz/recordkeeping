// ignore_for_file: avoid_print

import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:recordkeeping/homepage/homepage.dart';
import 'package:intl/intl.dart';

class Records extends StatefulWidget {
  String userName = "";
  Records({super.key, required this.userName});

  @override
  State<Records> createState() => _RecordsState();
}

class _RecordsState extends State<Records> {
  /// variables to store the details concerning tyhe record
  String recordDate = "SELECT DATE";
  String recordTitle = "";
  String recordDescription = "";

  /// show the calendar
  Widget showCalendar() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.46,
      width: MediaQuery.of(context).size.width * 0.99,
      decoration: const BoxDecoration(
          color: Colors.blueAccent,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10))),
      child: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.08),
          Container(
            height: MediaQuery.of(context).size.height * 0.05,
            width: MediaQuery.of(context).size.width * 1,
            padding: const EdgeInsets.only(left: 20),
            decoration: const BoxDecoration(
              color: Colors.transparent,
            ),
            child: const Align(
              alignment: Alignment.centerLeft,
              /*child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => const HomePage())));
                },
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
              ),*/
            ),
          ),
          Container(
              height: MediaQuery.of(context).size.height * 0.32,
              width: MediaQuery.of(context).size.width * 1,
              decoration: const BoxDecoration(
                color: Colors.transparent,
              ),
              child: CalendarDatePicker2(
                config: CalendarDatePicker2Config(),
                value: [],
                onValueChanged: (value) {
                  formatDate(value[0].toString());
                  print(value);
                },
              )),
        ],
      ),
    );
  }

  /// show the operations recording container
  Widget operationsRecording() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.45,
      width: MediaQuery.of(context).size.width * 1,
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.05,
            width: MediaQuery.of(context).size.width * 0.7,
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(255, 99, 99, 99).withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: const Offset(0, 1), // changes position of shadow
                ),
              ],
            ),
            child: Center(
              child: Text(
                recordDate,
                style: const TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.05,
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  recordTitle = value;
                });
              },
              decoration: const InputDecoration(
                hintText: "Record title",
                contentPadding: EdgeInsets.all(10.0),
                hintStyle:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w300),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 126, 126, 126),
                    width: 0.5,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 126, 126, 126),
                    width: 0.5,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 126, 126, 126),
                    width: 0.5,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.25,
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  recordDescription = value;
                });
              },
              maxLines: 20,
              decoration: const InputDecoration(
                hintText: "Describe your record",
                contentPadding: EdgeInsets.all(10.0),
                hintStyle:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w300),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 126, 126, 126),
                    width: 0.5,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 126, 126, 126),
                    width: 0.5,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 126, 126, 126),
                    width: 0.5,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  /// show record button
  Widget recordButton() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.05,
      width: MediaQuery.of(context).size.width * 0.4,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: ElevatedButton(
          onPressed: () {
            checkEntryOfDetails();
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5))),
          child: const Text(
            "SAVE",
            style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
            ),
          )),
    );
  }

  @override
  void initState() {
    print("****************************************************************");
    print(widget.userName);
    print("****************************************************************");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height * 1,
          width: MediaQuery.of(context).size.width * 1,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Column(children: [
            showCalendar(),
            operationsRecording(),
            recordButton()
          ]),
        ),
      ),
    );
  }

  /// method  to save the record details
  void saveRecordsData() async {
    DatabaseReference ref =
        FirebaseDatabase.instance.ref("records").child(widget.userName);

    await ref.push().set({
      "date": recordDate,
      "title": recordTitle,
      "description": recordDescription
    });
  }

  /// function to format the datetime object
  void formatDate(String dateOuput) {
    DateTime dateTime = DateTime.parse(dateOuput);
    String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);

    setState(() {
      recordDate = formattedDate;
    });
    print("Report date: $recordDate");
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
                children: const [
                  Text(
                    "Record has been saved successfully",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 16),
                  ),
                  Icon(
                    Icons.check_circle_outline_rounded,
                    color: Colors.blueAccent,
                    size: 50,
                  )
                ],
              )),
        );
      },
    );
  }

  /// function to check whether all the details have been entered as required
  void checkEntryOfDetails() {
    if (recordDate == "SELECT DATE" ||
        recordTitle.isEmpty ||
        recordDescription.isEmpty) {
      print("Please enter missing details");
    } else {
      saveRecordsData();
      success(context);
    }
  }
}
