// ignore_for_file: non_constant_identifier_names, avoid_print, use_build_context_synchronously, must_be_immutable, prefer_typing_uninitialized_variables, unnecessary_brace_in_string_interps, unused_local_variable

import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:recordkeeping/calculator/calculator_ui.dart';
import 'package:recordkeeping/gradient/gradient_class.dart';
import 'package:recordkeeping/record/allrecords.dart';
import 'package:recordkeeping/record/record.dart';
import 'package:recordkeeping/reports/reports.dart';

import '../AuthenticationFirebase/auth.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /// GRADIENT
  Gradient gradient = const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Colors.orange,
      Colors.purple,
    ],
  );

  /// USERNAME
  String userName = "";

  /// USER GMAIL
  String userGmail = "";

  /// REFERENCE DATES
  String referenceDate_1 = "";
  String referenceDate_3 = "";
  String referenceDate_6 = "";
  String referenceDate_12 = "";

  /// TODAY DATE
  String todayDate = "";

  /// variable to store default period for the manual report request
  String selectedOption = "1 DAY";

  /// list variable to store all the data
  var contentOfReport;

  /// list variables to store the data for the last 3 months,6 months and 12 months
  List threeMonthsData = [];
  List sixMonthsData = [];
  List twelveMonthsData = [];

  ///START | END DATES
  String oneMonth_Start = "";
  String threeMonths_Start = "";
  String sixMonths_Start = "";
  String twelveMonths_Start = "";
  String oneMonth_End = "";
  String threeMonths_End = "";
  String sixMonths_End = "";
  String twelveMonths_End = "";

  /// variable to store the report content, type of report that has been generated and the report periods
  String reportType_ToDatabase_1 = "";
  String reportPeriod_ToDatabase_1 = "";
  List reportContent_ToDatabase_1 = [];

  String reportType_ToDatabase_3 = "";
  String reportPeriod_ToDatabase_3 = "";
  List reportContent_ToDatabase_3 = [];

  String reportType_ToDatabase_6 = "";
  String reportPeriod_ToDatabase_6 = "";
  List reportContent_ToDatabase_6 = [];

  String reportType_ToDatabase_12 = "";
  String reportPeriod_ToDatabase_12 = "";
  List reportContent_ToDatabase_12 = [];

  /// string variable to store the date clicked
  String clickedDate = "";

  /// widget to display the top contiainer
  Widget topContainer() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.14,
      width: MediaQuery.of(context).size.width * 1,
      margin: const EdgeInsets.only(left: 5, right: 5, top: 1, bottom: 3),
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      child: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.12,
            width: MediaQuery.of(context).size.width * 1,
            decoration: BoxDecoration(
                gradient: gradient,
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10))),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
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
                            fontSize: 14),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        recordsCount,
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 16),
                      ),
                    ],
                  ),
                  GestureDetector(
                      onTap: () {
                        getRecordTitles();
                      },
                      child: GradientIcon(Icons.refresh, 25, gradient))
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
      height: MediaQuery.of(context).size.height * 0.75,
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
      padding: const EdgeInsets.only(left: 15, right: 15),
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
                    /*Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              AccountUI(userGmail: userGmail)),
                    );*/
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
                  /*const PopupMenuItem<String>(
                    value: 'myaccount',
                    child: Text(
                      'Account',
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                  ),*/
                ],
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
      height: MediaQuery.of(context).size.height * 0.48,
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
                      fontSize: 17,
                      color: Colors.black,
                      fontWeight: FontWeight.w300),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => AllRecords(
                                  userGmail: userGmail,
                                ))));
                  },
                  child: Row(
                    children: [
                      const Text(
                        "View",
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(width: 5),
                      GradientIcon(Icons.view_comfy_alt, 20, gradient)
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.44,
            width: MediaQuery.of(context).size.width * 1,
            padding: const EdgeInsets.only(bottom: 10),
            decoration: const BoxDecoration(color: Colors.transparent),
            child: ListView.builder(
                reverse: false,
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
                                      userGmail: userGmail,
                                    ))));
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        margin: const EdgeInsets.only(bottom: 13),
                        padding: const EdgeInsets.only(
                            left: 5, right: 8, top: 10, bottom: 10),
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
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
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      recordsTitles[index]["date"]
                                          .substring(0, 10),
                                      style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w300),
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      "(${recordsTitles[index]["date"].substring(11)})",
                                      style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "Ksh ${recordsTitles[index]["amount"]}",
                              style: const TextStyle(
                                  fontSize: 14,
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
      height: MediaQuery.of(context).size.height * 0.1,
      width: MediaQuery.of(context).size.width * 0.95,
      margin: const EdgeInsets.only(top: 8),
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => Reports(
                            userGmail: userGmail,
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
                          .withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: const Offset(0, 1), // changes position of shadow
                    ),
                  ],
                  borderRadius: const BorderRadius.all(Radius.circular(5))),
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
          const SizedBox(width: 30),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => const CalculatorUI())));
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
                          .withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: const Offset(0, 1), // changes position of shadow
                    ),
                  ],
                  borderRadius: const BorderRadius.all(Radius.circular(5))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    "CALCULATE",
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
                      userGmail: userGmail,
                    ))));
      },
      child: Container(
        height: MediaQuery.of(context).size.height * 0.1,
        width: MediaQuery.of(context).size.width * 1,
        padding: const EdgeInsets.only(top: 5, bottom: 5),
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
    /// GMAIL
    fetchUserGmail();

    /// CURRENT MONTH & YEAR
    getCurrentMonthYear();

    /// REFERENCE DATE
    fetchReferenceDate_1();
    fetchReferenceDate_3();
    fetchReferenceDate_6();
    fetchReferenceDate_12();

    /// TODAY DATE
    fetchTodayDate();

    /// START DATES
    threeMonths_Start = referenceDate_3;
    sixMonths_Start = referenceDate_6;
    twelveMonths_Start = referenceDate_12;

    /// END DATES
    evaluateEndDates();

    /// COMPARISON
    reportDatesComparison();

    /// titles of the record
    getRecordTitles();

    /// number of `day`s in current month
    getNumberOfDays();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
            body: Container(
          height: MediaQuery.of(context).size.height * 1,
          width: MediaQuery.of(context).size.width * 1,
          decoration: const BoxDecoration(color: Colors.white),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [topContainer(), bottomContainer()],
          ),
        )),
      ),
    );
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

  /// Remove special characters
  String removeSpecialCharacters(String input) {
    final regex = RegExp(r'[^\w\s]');
    return input.replaceAll(regex, '');
  }

  /// function to get all the titles of the records
  void getRecordTitles() async {
    int count = 0;
    recordsTitles.clear();
    DatabaseReference databaseReference = FirebaseDatabase.instance
        .ref()
        .child("info")
        .child(removeSpecialCharacters(userGmail))
        .child("records");
    databaseReference.onValue.listen((DatabaseEvent event) async {
      for (var data in event.snapshot.children) {
        setState(() {
          recordsTitles.add(data.value);
          count = count + 1;
        });
      }
      recordsTitles = recordsTitles.reversed.toList();
      print(recordsTitles);

      setState(() {
        recordsCount = count.toString();
      });
    });
  }

  /// function to get the number of days in the current month
  void getNumberOfDays() {
    var now = DateTime.now();
    setState(() {
      numberOfDays_CurrentMonth = daysInMonth(now);
    });
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

    /// database operation
    DatabaseReference databaseReference = FirebaseDatabase.instance
        .ref()
        .child("info")
        .child(removeSpecialCharacters(userGmail))
        .child("records");
    databaseReference.onValue.listen((DatabaseEvent event) {
      for (var data in event.snapshot.children) {
        setState(() {
          recordData.add(data.value);
        });
      }
      print(recordData);
    });
    for (int x = 0; x < recordData.length; x++) {
      recordDate_Filtering = recordData[x]["date"];
      if (recordDate_Filtering == formattedDate) {
        setState(() {
          filteredData.add(recordData[x]);
        });
      }
    }
  }

  /// ONE month
  void getReportContent_OneMonth(String startDate, String endDate) async {
    /// Set period and dates
    setState(() {
      reportType_ToDatabase_1 = "1 Month";
      reportPeriod_ToDatabase_1 = "( $startDate - $endDate)";
    });

    /// Generate the report
    DatabaseReference databaseReference = FirebaseDatabase.instance
        .ref()
        .child("info")
        .child(removeSpecialCharacters(userGmail));
    databaseReference
        .child("records")
        .orderByChild('date')
        .startAt(startDate)
        .endAt(endDate)
        .onValue
        .listen((DatabaseEvent event) async {
      if (event.snapshot.children.isEmpty) {
        /// Do nothing
      } else {
        for (var data in event.snapshot.children) {
          reportContent_ToDatabase_1.add(data.value);
        }

        /// record the  report
        await databaseReference.child("reports").push().set({
          "reportType": reportType_ToDatabase_1,
          "reportPeriod": reportPeriod_ToDatabase_1,
          "reportContent": reportContent_ToDatabase_1
        });
      }

      /// Update reference date
      var localDatabase = Hive.box('Date1');
      localDatabase.put('date', endDate);
    });
  }

  /// THREE months
  void getReportContent_ThreeMonths(String startDate, String endDate) async {
    /// Set period and dates
    setState(() {
      reportType_ToDatabase_3 = "3 Months";
      reportPeriod_ToDatabase_3 = "( $startDate - $endDate)";
    });

    /// Generate the report
    DatabaseReference databaseReference = FirebaseDatabase.instance
        .ref()
        .child("info")
        .child(removeSpecialCharacters(userGmail));
    databaseReference
        .child("records")
        .orderByChild('date')
        .startAt(startDate)
        .endAt(endDate)
        .onValue
        .listen((DatabaseEvent event) async {
      if (event.snapshot.children.isEmpty) {
      } else {
        for (var data in event.snapshot.children) {
          reportContent_ToDatabase_3.add(data.value);
        }

        /// record the  report
        await databaseReference.child("reports").push().set({
          "reportType": reportType_ToDatabase_3,
          "reportPeriod": reportPeriod_ToDatabase_3,
          "reportContent": reportContent_ToDatabase_3
        });
      }

      /// Update reference date
      var localDatabase = Hive.box('Date3');
      localDatabase.put('date', endDate);
    });
  }

  /// SIX months
  void getReportContent_SixMonths(String startDate, String endDate) async {
    /// Set period and dates
    setState(() {
      reportType_ToDatabase_6 = "6 Months";
      reportPeriod_ToDatabase_6 = "( $startDate - $endDate)";
    });

    /// Generate the report
    DatabaseReference databaseReference = FirebaseDatabase.instance
        .ref()
        .child("info")
        .child(removeSpecialCharacters(userGmail));
    databaseReference
        .child("records")
        .orderByChild('date')
        .startAt(startDate)
        .endAt(endDate)
        .onValue
        .listen((DatabaseEvent event) async {
      if (event.snapshot.children.isEmpty) {
      } else {
        for (var data in event.snapshot.children) {
          reportContent_ToDatabase_6.add(data.value);
        }

        /// record the  report
        await databaseReference.child("reports").push().set({
          "reportType": reportType_ToDatabase_6,
          "reportPeriod": reportPeriod_ToDatabase_6,
          "reportContent": reportContent_ToDatabase_6
        });
      }

      /// Update reference date
      var localDatabase = Hive.box('Date6');
      localDatabase.put('date', endDate);
    });
  }

  /// TWELVE months
  void getReportContent_TwelveMonths(String startDate, String endDate) async {
    /// Set period and dates
    setState(() {
      reportType_ToDatabase_12 = "12 Months";
      reportPeriod_ToDatabase_12 = "( $startDate - $endDate)";
    });

    /// Generate the report
    DatabaseReference databaseReference = FirebaseDatabase.instance
        .ref()
        .child("info")
        .child(removeSpecialCharacters(userGmail));
    databaseReference
        .child("records")
        .orderByChild('date')
        .startAt(startDate)
        .endAt(endDate)
        .onValue
        .listen((DatabaseEvent event) async {
      if (event.snapshot.children.isEmpty) {
      } else {
        for (var data in event.snapshot.children) {
          reportContent_ToDatabase_12.add(data.value);
        }

        /// record the  report
        await databaseReference.child("reports").push().set({
          "reportType": reportType_ToDatabase_12,
          "reportPeriod": reportPeriod_ToDatabase_12,
          "reportContent": reportContent_ToDatabase_12
        });
      }

      var localDatabase = Hive.box('Date12');
      localDatabase.put('date', endDate);
    });
  }

  /// END dates
  void evaluateEndDates() {
    evaluateOneEndDate();
    evaluateThreeEndDate();
    evaluateSixEndDate();
    evaluateTwelveEndDate();
  }

  /// ONE month
  void evaluateOneEndDate() {
    DateTime startDate = DateTime.parse(oneMonth_Start);
    DateTime afterOneMonth = startDate.add(const Duration(days: 30));

    oneMonth_End = DateFormat('yyyy-MM-dd').format(afterOneMonth);
  }

  /// THREE months
  void evaluateThreeEndDate() {
    DateTime startDate = DateTime.parse(threeMonths_Start);
    DateTime afterThreeMonths = startDate.add(const Duration(days: 3 * 30));

    threeMonths_End = DateFormat('yyyy-MM-dd').format(afterThreeMonths);
  }

  /// SIX months
  void evaluateSixEndDate() {
    DateTime startDate = DateTime.parse(sixMonths_Start);
    DateTime afterSixMonths = startDate.add(const Duration(days: 6 * 30));

    sixMonths_End = DateFormat('yyyy-MM-dd').format(afterSixMonths);
  }

  /// TWELVE months
  void evaluateTwelveEndDate() {
    DateTime startDate = DateTime.parse(twelveMonths_Start);
    DateTime afterTwelveMonths = startDate.add(const Duration(days: 365));

    twelveMonths_End = DateFormat('yyyy-MM-dd').format(afterTwelveMonths);
  }

  /// Sign out
  Future<void> signOut() async {
    await Auth().signOut();
  }

  /// fetch user gmail
  void fetchUserGmail() {
    var localDatabase = Hive.box('Gmail');
    setState(() {
      userGmail = localDatabase.get('gmail');
    });
  }

  /// fetch reference date
  void fetchReferenceDate_1() {
    var localDatabase = Hive.box('Date');
    setState(() {
      referenceDate_1 = localDatabase.get('date1');
    });
  }

  /// fetch reference date
  void fetchReferenceDate_3() {
    var localDatabase = Hive.box('Date');
    setState(() {
      referenceDate_3 = localDatabase.get('date3');
    });
  }

  /// fetch reference date
  void fetchReferenceDate_6() {
    var localDatabase = Hive.box('Date');
    setState(() {
      referenceDate_6 = localDatabase.get('date6');
    });
  }

  /// fetch reference date
  void fetchReferenceDate_12() {
    var localDatabase = Hive.box('Date');
    setState(() {
      referenceDate_12 = localDatabase.get('date12');
    });
  }

  /// fetch today date
  void fetchTodayDate() {
    DateTime currentDate = DateTime.now();
    String currentMonth = currentDate.month.toString();
    String currentDay = currentDate.day.toString();
    String currentHour = currentDate.hour.toString();
    String currentMinute = currentDate.minute.toString();
    String currentSecond = currentDate.second.toString();
    String currentTime = "";
    if (currentHour.length == 1) {
      currentHour = "0$currentHour";
    }
    if (currentMinute.length == 1) {
      currentMinute = "0$currentMinute";
    }
    if (currentMonth.length == 1) {
      currentMonth = "0$currentMonth";
    }
    if (currentDay.length == 1) {
      currentDay = "0$currentDay";
    }
    currentTime = "$currentHour:$currentMinute:$currentSecond";
    print(currentTime);
    setState(() {
      todayDate = "${currentDate.year}-$currentMonth-$currentDay";
    });
  }

  /// compare today's date and the end date
  void reportDatesComparison() {
    // YEAR,MONTH,DAY
    int year_today = int.parse(todayDate.substring(0, 4));
    int month_today = int.parse(todayDate.substring(5, 7));
    int day_today = int.parse(todayDate.substring(8, 10));
    int year_3 = int.parse(threeMonths_End.substring(0, 4));
    int month_3 = int.parse(threeMonths_End.substring(5, 7));
    int day_3 = int.parse(threeMonths_End.substring(8, 10));
    int year_6 = int.parse(sixMonths_End.substring(0, 4));
    int month_6 = int.parse(sixMonths_End.substring(5, 7));
    int day_6 = int.parse(sixMonths_End.substring(8, 10));
    int year_12 = int.parse(twelveMonths_End.substring(0, 4));
    int month_12 = int.parse(twelveMonths_End.substring(5, 7));
    int day_12 = int.parse(twelveMonths_End.substring(8, 10));

    /// 3 Months
    if (year_today > year_3) {
      getReportContent_ThreeMonths(threeMonths_Start, threeMonths_End);
    } else {
      if (year_today == year_3) {
        if (month_today > month_3) {
          getReportContent_ThreeMonths(threeMonths_Start, threeMonths_End);
        } else {
          if (month_today == month_3) {
            if (day_today >= day_3) {
              getReportContent_ThreeMonths(threeMonths_Start, threeMonths_End);
            } else {}
          } else {}
        }
      } else {}
    }

    /// 6 Months
    if (year_today > year_6) {
      getReportContent_SixMonths(sixMonths_Start, sixMonths_End);
    } else {
      if (year_today == year_6) {
        if (month_today > month_6) {
          getReportContent_SixMonths(sixMonths_Start, sixMonths_End);
        } else {
          if (month_today == month_6) {
            if (day_today >= day_6) {
              getReportContent_SixMonths(sixMonths_Start, sixMonths_End);
            } else {}
          } else {}
        }
      } else {}
    }

    /// 12 Months
    if (year_today > year_12) {
      getReportContent_TwelveMonths(twelveMonths_Start, twelveMonths_End);
    } else {
      if (year_today == year_12) {
        if (month_today > month_12) {
          getReportContent_TwelveMonths(twelveMonths_Start, twelveMonths_End);
        } else {
          if (month_today == month_12) {
            if (day_today >= day_12) {
              getReportContent_TwelveMonths(
                  twelveMonths_Start, twelveMonths_End);
            } else {}
          } else {}
        }
      } else {}
    }
  }
}
