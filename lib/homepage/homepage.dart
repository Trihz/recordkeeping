// ignore_for_file: non_constant_identifier_names, avoid_print, use_build_context_synchronously, must_be_immutable, prefer_typing_uninitialized_variables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:recordkeeping/Account/account_ui.dart';
import 'package:recordkeeping/gradient/gradient_class.dart';
import 'package:recordkeeping/record/allrecords.dart';
import 'package:recordkeeping/record/record.dart';
import 'package:recordkeeping/reports/reports.dart';
import 'dart:io';

import '../AuthenticationFirebase/auth.dart';

class HomePage extends StatefulWidget {
  String userGmail = "";
  HomePage({super.key, required this.userGmail});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /// variable to store the gradient color for containers
  Gradient gradient = const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Colors.orange,
      Colors.purple,
    ],
  );

  /// String varaible for storing the fetched username
  String userName = "";

  /// variable to store default period for the manual report request
  String selectedOption = "1 DAY";

  /// list variable to store all the data
  var contentOfReport;

  /// list variables to store the data for the last 3 months,6 months and 12 months
  List threeMonthsData = [];
  List sixMonthsData = [];
  List twelveMonthsData = [];

  /// variables to store the start and end dates of the 3,6 and 12 months period
  String threeMonths_Start = "2023-07-14";
  String sixMonths_Start = "2023-07-14";
  String twelveMonths_Start = "2023-07-14";
  String threeMonths_End = "";
  String sixMonths_End = "";
  String twelveMonths_End = "";

  /// variable to store the report content, type of report that has been generated and the report periods
  String reportType_ToDatabase = "";
  String reportPeriod_ToDatabase = "";
  List reportContent_ToDatabase = [];

  /// string variable to store the date clicked
  String clickedDate = "";

  /// widget to display the top contiainer
  Widget topContainer() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.22,
      width: MediaQuery.of(context).size.width * 1,
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      child: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.2,
            width: MediaQuery.of(context).size.width * 1,
            decoration: BoxDecoration(
                gradient: gradient,
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40))),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.09,
                ),
                accountIcon(),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            right: MediaQuery.of(context).size.height * 0.1,
            left: MediaQuery.of(context).size.height * 0.1,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.05,
              width: MediaQuery.of(context).size.width * 0.6,
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 99, 99, 99)
                          .withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: const Offset(0, 1), // changes position of shadow
                    ),
                  ],
                  borderRadius: const BorderRadius.all(Radius.circular(5))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "RECORDS:",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w300,
                            fontSize: 16),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        recordsCount,
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 18),
                      ),
                    ],
                  ),
                  GestureDetector(
                      onTap: () {
                        getRecordTitles();
                      },
                      child: GradientIcon(Icons.refresh, 30, gradient))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  /// widget to display the bottom container
  Widget bottomContainer() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.78,
      width: MediaQuery.of(context).size.width * 1,
      decoration: const BoxDecoration(color: Colors.transparent),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          records(),
          statsContainer(),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          floatingButton()
        ],
      ),
    );
  }

  /// widget to display the account icon
  Widget accountIcon() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.06,
      width: MediaQuery.of(context).size.width * 1,
      padding: const EdgeInsets.only(left: 30, right: 15),
      decoration: const BoxDecoration(color: Colors.transparent),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Record Keeping",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 19),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              PopupMenuButton<String>(
                child: Container(
                    width: 30,
                    height: 30,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.person)),
                onSelected: (value) {
                  if (value == 'logout') {
                    signOut();
                  } else if (value == 'myaccount') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              AccountUI(userGmail: widget.userGmail)),
                    );
                  }
                },
                itemBuilder: (BuildContext context) => [
                  const PopupMenuItem<String>(
                    value: 'logout',
                    child: Text(
                      'Logout',
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                  ),
                  const PopupMenuItem<String>(
                    value: 'myaccount',
                    child: Text(
                      'Account',
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                  ),
                ],
              ),
              Text(
                userName,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 13),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// widget to display the records of the user
  Widget records() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.53,
      width: MediaQuery.of(context).size.width * 1,
      decoration: const BoxDecoration(color: Colors.transparent),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.03,
            width: MediaQuery.of(context).size.width * 1,
            margin: const EdgeInsets.only(left: 20, right: 10),
            decoration: const BoxDecoration(color: Colors.transparent),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Records",
                  style: TextStyle(
                      fontSize: 19,
                      color: Colors.black,
                      fontWeight: FontWeight.w300),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => AllRecords(
                                  userGmail: widget.userGmail,
                                ))));
                  },
                  child: Row(
                    children: [
                      const Text(
                        "View",
                        style: TextStyle(
                            fontSize: 17,
                            color: Colors.black,
                            fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(width: 5),
                      GradientIcon(Icons.view_comfy_alt, 25, gradient)
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.49,
            width: MediaQuery.of(context).size.width * 1,
            decoration: const BoxDecoration(color: Colors.transparent),
            child: ListView.builder(
                itemCount: recordsTitles.length,
                padding: const EdgeInsets.all(20),
                scrollDirection: Axis.vertical,
                itemBuilder: ((context, index) {
                  return Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => AllRecords(
                                      userGmail: widget.userGmail,
                                    ))));
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.07,
                        width: MediaQuery.of(context).size.width * 0.9,
                        margin: const EdgeInsets.only(bottom: 13),
                        padding: const EdgeInsets.only(left: 5, right: 5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: const Color.fromARGB(255, 0, 0, 0)
                                  .withOpacity(0.1),
                              spreadRadius: 2,
                              blurRadius: 1,
                              offset: const Offset(
                                  0, 1), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                GradientIcon(
                                    Icons.view_comfy_alt, 25, gradient),
                                const SizedBox(width: 10),
                                Text(
                                  recordsTitles[index]["title"],
                                  style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                            Text(
                              recordsTitles[index]["date"],
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w300),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                })),
          ),
        ],
      ),
    );
  }

  /// stats container
  Widget statsContainer() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.12,
      width: MediaQuery.of(context).size.width * 0.95,
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => Reports(
                            userGmail: widget.userGmail,
                          ))));
            },
            child: Container(
              height: MediaQuery.of(context).size.height * 0.12,
              width: MediaQuery.of(context).size.width * 0.3,
              padding: const EdgeInsets.only(left: 7, right: 5),
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 99, 99, 99)
                          .withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: const Offset(0, 1), // changes position of shadow
                    ),
                  ],
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    "REPORTS",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 13),
                  ),
                  GradientIcon(Icons.view_agenda, 35, gradient)
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => Reports(
                            userGmail: widget.userGmail,
                          ))));
            },
            child: Container(
              height: MediaQuery.of(context).size.height * 0.12,
              width: MediaQuery.of(context).size.width * 0.3,
              padding: const EdgeInsets.only(left: 7, right: 5),
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 99, 99, 99)
                          .withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: const Offset(0, 1), // changes position of shadow
                    ),
                  ],
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    "CALCULATOR",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 13),
                  ),
                  GradientIcon(Icons.calculate, 35, gradient)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  /// floating button widget
  Widget floatingButton() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: ((context) => Records(
                      userGmail: widget.userGmail,
                    ))));
      },
      child: Container(
        height: MediaQuery.of(context).size.height * 0.08,
        width: MediaQuery.of(context).size.width * 1,
        decoration: const BoxDecoration(
          color: Colors.transparent,
        ),
        child: Center(
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              gradient: gradient,
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: const Offset(0, 1), // changes position of shadow
                ),
              ],
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Text(
                "NEW",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// initial function of the screen
  @override
  void initState() {
    var box = Hive.box('Gmail');
    box.put('name', 'David');
    var name = box.get('name');
    print('Name: $name');
    print(widget.userGmail);

    /// fetch username
    fetchUserName();

    /// current month and year
    getCurrentMonthYear();

    /// titles of the record
    getRecordTitles();

    /// number of `day`s in current month
    getNumberOfDays();

    evaluateThreeMonthsPeriod();
    evaluateSixMonthsPeriod();
    evaluateTwelveMonthsPeriod();
    getReportContent_ThreeMonths(threeMonths_Start, threeMonths_End);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: MediaQuery.of(context).size.height * 1,
      width: MediaQuery.of(context).size.width * 1,
      decoration: const BoxDecoration(color: Colors.white),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [topContainer(), bottomContainer()],
      ),
    ));
  }

  /// List to store the elements of the scrolling dates
  List scrollingDates_Values = [1, 2, 3, 4, 5, 6, 7, 8, 9];

  /// variable to store the records titles
  List recordsTitles = [];

  /// list variable to store the record data
  List recordData = [];

  /// variable to store the total number if records present
  String recordsCount = "";

  /// list variable to store the filtered data
  List filteredData = [];

  /// Integer variable to store the number of days in the current month
  int numberOfDays_CurrentMonth = 0;

  /// string vraiables to store current month and year
  String currentMonth = "";
  String currentYear = "";

  /// Auth User object
  final User? user = Auth().currentUser;

  /// Get username
  void fetchUserName() {
    DatabaseReference databaseReference = FirebaseDatabase.instance
        .ref()
        .child("users")
        .child(removeSpecialCharacters(widget.userGmail))
        .child("username");
    databaseReference.onValue.listen((event) {
      setState(() {
        userName = event.snapshot.value.toString();
      });
    });
  }

  /// Remove special characters
  String removeSpecialCharacters(String input) {
    final regex = RegExp(r'[^\w\s]');
    return input.replaceAll(regex, '');
  }

  /// function to get all the titles of the records
  void getRecordTitles() {
    int count = 0;
    recordsTitles.clear();
    DatabaseReference databaseReference = FirebaseDatabase.instance
        .ref()
        .child("info")
        .child(removeSpecialCharacters(widget.userGmail))
        .child("records");
    databaseReference.onValue.listen((DatabaseEvent event) {
      for (var data in event.snapshot.children) {
        setState(() {
          recordsTitles.add(data.value);
          count = count + 1;
        });
      }
      setState(() {
        recordsCount = count.toString();
      });
      print(recordsTitles[0]["title"]);
      print(recordsTitles[1]["title"]);
    });
  }

  /// function to get the number of days in the current month
  void getNumberOfDays() {
    var now = DateTime.now();
    setState(() {
      numberOfDays_CurrentMonth = daysInMonth(now);
    });
    print(numberOfDays_CurrentMonth);
    print(daysInMonth(now));
  }

  int daysInMonth(DateTime date) {
    var firstDayThisMonth = DateTime(date.year, date.month, date.day);
    var firstDayNextMonth = DateTime(firstDayThisMonth.year,
        firstDayThisMonth.month + 1, firstDayThisMonth.day);
    return firstDayNextMonth.difference(firstDayThisMonth).inDays;
  }

  /// function to get current month and year
  void getCurrentMonthYear() {
    setState(() {
      currentMonth = DateTime.now().month.toString();
      currentYear = DateTime.now().year.toString();
    });
  }

  /// function to return the records based on the date passed as variable
  Future<void> getRecordsBasedOnDate(
      String dateClicked, String month, String year) async {
    /// clear the filtered data variable
    filteredData.clear();
    //recordData.clear();
    print("Before: $filteredData");

    /// get current month and date first
    getCurrentMonthYear();

    /// declare variables
    String recordDate_Filtering = "";
    String formattedDate = "";

    /// format individual date components
    if (month.length == 1) {
      month = "0$month";
    }
    if (dateClicked.length == 1) {
      dateClicked = "0$dateClicked";
    }

    /// format the date for querying purpose
    formattedDate = "$year-$month-$dateClicked";
    print(formattedDate);

    /// database operation
    DatabaseReference databaseReference = FirebaseDatabase.instance
        .ref()
        .child("info")
        .child(removeSpecialCharacters(widget.userGmail))
        .child("records");
    databaseReference.onValue.listen((DatabaseEvent event) {
      for (var data in event.snapshot.children) {
        setState(() {
          recordData.add(data.value);
        });
      }
    });
    for (int x = 0; x < recordData.length; x++) {
      recordDate_Filtering = recordData[x]["date"];
      if (recordDate_Filtering == formattedDate) {
        setState(() {
          filteredData.add(recordData[x]);
        });
      }
    }
    print("After: $filteredData");
  }

  /// THREE months
  void getReportContent_ThreeMonths(String startDate, String endDate) async {
    DatabaseReference databaseReference =
        FirebaseDatabase.instance.ref().child("info").child(widget.userGmail);
    databaseReference
        .child("records")
        .orderByChild('date')
        .startAt(startDate)
        .endAt(endDate)
        .onValue
        .listen((DatabaseEvent event) async {
      setState(() {
        contentOfReport = event.snapshot.value;
      });
      print(contentOfReport);
      setState(() {
        reportType_ToDatabase = "3 Months";
        reportPeriod_ToDatabase = "( $startDate - $endDate)";
        reportContent_ToDatabase.add(contentOfReport);
      });
      print(reportType_ToDatabase);
      print(reportPeriod_ToDatabase);
      print(reportContent_ToDatabase);
      await databaseReference.child("reports").push().set({
        "reportType": reportType_ToDatabase,
        "reportPeriod": reportPeriod_ToDatabase,
        "reportContent": contentOfReport.toString()
      });
    });
  }

  /// SIX months
  void getReportContent_SixMonths(String startDate, String endDate) async {
    Query databaseReference = FirebaseDatabase.instance
        .ref()
        .child("records")
        .child(widget.userGmail);
    databaseReference
        .orderByChild('date')
        .startAt(startDate)
        .endAt(endDate)
        .onValue
        .listen((DatabaseEvent event) {
      final contentOfReport = event.snapshot.value;

      if (contentOfReport != null) {
        print(contentOfReport);
      }
    });
  }

  /// TWELVE months
  void getReportContent_TwelveMonths(String startDate, String endDate) async {
    Query databaseReference = FirebaseDatabase.instance
        .ref()
        .child("records")
        .child(widget.userGmail);
    databaseReference
        .orderByChild('date')
        .startAt(startDate)
        .endAt(endDate)
        .onValue
        .listen((DatabaseEvent event) {
      final contentOfReport = event.snapshot.value;

      if (contentOfReport != null) {
        print(contentOfReport);
      }
    });
  }

  /// THREE months
  void evaluateThreeMonthsPeriod() {
    DateTime startDate = DateTime.parse(threeMonths_Start);
    DateTime afterThreeMonths = startDate.add(const Duration(days: 3 * 30));

    threeMonths_End = DateFormat('yyyy-MM-dd').format(afterThreeMonths);
    print(threeMonths_Start);
    print(threeMonths_End);
  }

  /// SIX months
  void evaluateSixMonthsPeriod() {
    DateTime startDate = DateTime.parse(sixMonths_Start);
    DateTime afterSixMonths = startDate.add(const Duration(days: 6 * 30));

    sixMonths_End = DateFormat('yyyy-MM-dd').format(afterSixMonths);
    print(sixMonths_Start);
    print(sixMonths_End);
  }

  /// TWELVE months
  void evaluateTwelveMonthsPeriod() {
    DateTime startDate = DateTime.parse(twelveMonths_Start);
    DateTime afterTwelveMonths = startDate.add(const Duration(days: 365));

    twelveMonths_End = DateFormat('yyyy-MM-dd').format(afterTwelveMonths);
    print(twelveMonths_Start);
    print(twelveMonths_End);
  }

  /// record the generated report if any
  void recordReport() async {
    print("***************************");
    print(reportType_ToDatabase);
    print(reportPeriod_ToDatabase);
    print(reportContent_ToDatabase);
    DatabaseReference databaseReference =
        FirebaseDatabase.instance.ref().child("reports");
    await databaseReference.child(reportType_ToDatabase).set({
      "reportType": reportType_ToDatabase,
      "reportPeriod": reportPeriod_ToDatabase,
      "reportContent": reportContent_ToDatabase
    });
  }

  /// Sign out
  Future<void> signOut() async {
    await Auth().signOut();
  }
}
