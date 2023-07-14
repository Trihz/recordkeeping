// ignore_for_file: must_be_immutable

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:recordkeeping/homepage/homepage.dart';
import 'package:recordkeeping/reports/report_display.dart';

class Reports extends StatefulWidget {
  String userName = "";
  Reports({super.key, required this.userName});

  @override
  State<Reports> createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {
  /// string variable to store the period of the report
  String reportPeriod = "3 months";

  /// list variable to store all the data
  List contentOfReport = [];

  /// list variables to store the data for the last 3 months,6 months and 12 months
  List threeMonthsData = [];
  List sixMonthsData = [];
  List twelveMonthsData = [];

  /// widget to show the top container
  Widget topContainer() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.21,
      width: MediaQuery.of(context).size.width * 0.95,
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [
              const SizedBox(
                width: 5,
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
                width: MediaQuery.of(context).size.height * 0.12,
              ),
              const Text(
                "Previous reports",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                    fontSize: 18),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.13,
                width: MediaQuery.of(context).size.width * 0.27,
                decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(255, 99, 99, 99)
                            .withOpacity(0.3),
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset:
                            const Offset(0, 1), // changes position of shadow
                      ),
                    ],
                    borderRadius: const BorderRadius.all(Radius.circular(5))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text(
                      "3 MONTHS",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 13),
                    ),
                    const Text(
                      "(10)",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 14),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.03,
                      width: MediaQuery.of(context).size.width * 0.2,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: ElevatedButton(
                          onPressed: (() {
                            setState(() {
                              reportPeriod = "3 months";
                            });
                          }),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.blueAccent),
                          child: const Text(
                            "VIEW",
                            style: TextStyle(fontSize: 12),
                          )),
                    )
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.13,
                width: MediaQuery.of(context).size.width * 0.27,
                decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(255, 99, 99, 99)
                            .withOpacity(0.3),
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset:
                            const Offset(0, 1), // changes position of shadow
                      ),
                    ],
                    borderRadius: const BorderRadius.all(Radius.circular(5))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text(
                      "6 MONTHS",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 13),
                    ),
                    const Text(
                      "(2)",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 14),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.03,
                      width: MediaQuery.of(context).size.width * 0.2,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: ElevatedButton(
                          onPressed: (() {
                            setState(() {
                              reportPeriod = "6 months";
                            });
                          }),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.blueAccent),
                          child: const Text(
                            "VIEW",
                            style: TextStyle(fontSize: 12),
                          )),
                    )
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.13,
                width: MediaQuery.of(context).size.width * 0.27,
                decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(255, 99, 99, 99)
                            .withOpacity(0.3),
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset:
                            const Offset(0, 1), // changes position of shadow
                      ),
                    ],
                    borderRadius: const BorderRadius.all(Radius.circular(5))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text(
                      "12 MONTHS",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 13),
                    ),
                    const Text(
                      "(1)",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 14),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.03,
                      width: MediaQuery.of(context).size.width * 0.2,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: ElevatedButton(
                          onPressed: (() {
                            setState(() {
                              reportPeriod = "12 months";
                            });
                          }),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.blueAccent),
                          child: const Text(
                            "VIEW",
                            style: TextStyle(fontSize: 12),
                          )),
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  /// widget to display a list of all the reports
  Widget reportsDisplay() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      width: MediaQuery.of(context).size.width * 0.95,
      padding: const EdgeInsets.only(left: 10),
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Reports (${reportPeriod})",
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w300,
                  fontSize: 18),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.62,
            width: MediaQuery.of(context).size.width * 0.95,
            decoration: const BoxDecoration(
              color: Colors.transparent,
            ),
            child: Align(
              child: ListView.builder(
                  padding: const EdgeInsets.all(0.0),
                  scrollDirection: Axis.vertical,
                  itemCount: 5,
                  itemBuilder: ((context, index) {
                    return Container(
                        height: MediaQuery.of(context).size.height * 0.07,
                        width: MediaQuery.of(context).size.width * 0.8,
                        margin: const EdgeInsets.only(
                            bottom: 15, left: 10, right: 15),
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, top: 10, bottom: 10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: const Color.fromARGB(255, 0, 0, 0)
                                    .withOpacity(0.1),
                                spreadRadius: 1,
                                blurRadius: 1,
                                offset: const Offset(
                                    0, 1), // changes position of shadow
                              ),
                            ],
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text(
                              "(12/02/2023 - 1/05/2023)",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) => ReportDisplay(
                                              contentOfReport: [
                                                contentOfReport
                                              ],
                                            ))));
                              },
                              child: Row(
                                children: const [
                                  Icon(
                                    Icons.view_timeline,
                                    color: Colors.blueAccent,
                                    size: 20,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    "VIEW",
                                    style: TextStyle(
                                        color: Colors.blueAccent,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ));
                  })),
            ),
          ),
        ],
      ),
    );
  }

  /// initial function of the screen
  @override
  void initState() {
    getReportContent();
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
            reportsDisplay()
          ],
        ),
      ),
    );
  }

  /// function to generate the report for the records
  void getReportContent() {
    DatabaseReference databaseReference =
        FirebaseDatabase.instance.ref().child("records").child(widget.userName);
    databaseReference.onValue.listen((DatabaseEvent event) {
      for (var data in event.snapshot.children) {
        setState(() {
          contentOfReport.add(data.value);
        });
      }

      print(contentOfReport);
    });
  }
}
