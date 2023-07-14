// ignore_for_file: must_be_immutable, non_constant_identifier_names, avoid_print, prefer_typing_uninitialized_variables

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:recordkeeping/reports/report_display.dart';

class Reports extends StatefulWidget {
  String userName = "";
  Reports({super.key, required this.userName});

  @override
  State<Reports> createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {
  /// variable to store the gradient color for containers
  Gradient gradient = const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Colors.orange,
      Colors.purple,
    ],
  );

  /// string variable to store the period of the report
  String reportPeriod = "3 months";

  /// list variable to store all the data
  var contentOfReport;

  /// list variable to store the fetched reports
  List fetchedReports = [];

  /// Integer variables to store the count of the reports depending in the month
  int count3 = 0;
  int count6 = 0;
  int count12 = 0;

  /// widget to show the top container
  Widget topContainer() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.15,
      width: MediaQuery.of(context).size.width * 0.95,
      padding: const EdgeInsets.only(left: 10),
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Reports Count",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 16),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.08,
                width: MediaQuery.of(context).size.width * 0.27,
                decoration: BoxDecoration(
                    gradient: gradient,
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(255, 156, 156, 156)
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
                      "3 Months",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 15),
                    ),
                    Text(
                      "(${count3.toString()})",
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                          fontSize: 15),
                    ),
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.08,
                width: MediaQuery.of(context).size.width * 0.27,
                decoration: BoxDecoration(
                    gradient: gradient,
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(255, 156, 156, 156)
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
                      "6 Months",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 15),
                    ),
                    Text(
                      "(${count6.toString()})",
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                          fontSize: 15),
                    ),
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.08,
                width: MediaQuery.of(context).size.width * 0.27,
                decoration: BoxDecoration(
                    gradient: gradient,
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(255, 156, 156, 156)
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
                      "12 Months",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 15),
                    ),
                    Text(
                      "(${count12.toString()})",
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                          fontSize: 15),
                    ),
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
      height: MediaQuery.of(context).size.height * 0.75,
      width: MediaQuery.of(context).size.width * 0.95,
      padding: const EdgeInsets.only(left: 10),
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "All Reports",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 16),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.68,
            width: MediaQuery.of(context).size.width * 0.95,
            decoration: const BoxDecoration(
              color: Colors.transparent,
            ),
            child: Align(
              child: ListView.builder(
                  padding: const EdgeInsets.all(0.0),
                  scrollDirection: Axis.vertical,
                  itemCount: fetchedReports.length,
                  itemBuilder: ((context, index) {
                    return Container(
                        height: MediaQuery.of(context).size.height * 0.1,
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
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  fetchedReports[index]["reportPeriod"],
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 15),
                                ),
                                Text(
                                  fetchedReports[index]["reportType"],
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 15),
                                ),
                              ],
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
    fetchAllReports();
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

  /// function to fetch all the reports from the database
  void fetchAllReports() async {
    DatabaseReference databaseReference = FirebaseDatabase.instance
        .ref()
        .child("info")
        .child(widget.userName)
        .child("reports");
    databaseReference.onValue.listen((event) {
      for (var data in event.snapshot.children) {
        setState(() {
          fetchedReports.add(data.value);
        });
      }
      print(fetchedReports);
      for (int x = 0; x < fetchedReports.length; x++) {
        if (fetchedReports[x]["reportType"] == "3 Months") {
          count3++;
        } else if (fetchedReports[x]["reportType"] == "6 Months") {
          count6++;
        } else if (fetchedReports[x]["reportType"] == "12 Months") {
          count12++;
        }
        print(fetchedReports[x]["reportType"]);
      }
      print(count3);
      print(count6);
      print(count12);
    });
  }
}
