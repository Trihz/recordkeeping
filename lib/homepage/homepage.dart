// ignore_for_file: non_constant_identifier_names, avoid_print, use_build_context_synchronously, must_be_immutable

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:recordkeeping/Account/account_ui.dart';
import 'package:recordkeeping/record/allrecords.dart';
import 'package:recordkeeping/record/record.dart';
import 'package:recordkeeping/reports/reports.dart';

class HomePage extends StatefulWidget {
  String userName = "";
  HomePage({super.key, required this.userName});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedOption = "1 DAY";

  /// widget to display the top contiainer
  Widget topContainer() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.32,
      width: MediaQuery.of(context).size.width * 1,
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      child: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width * 1,
            decoration: const BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.only(
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
                scrollingDates()
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
                    child: const Icon(
                      Icons.refresh,
                      color: Colors.blueAccent,
                      size: 30,
                    ),
                  )
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
      height: MediaQuery.of(context).size.height * 0.68,
      width: MediaQuery.of(context).size.width * 1,
      decoration: const BoxDecoration(color: Colors.transparent),
      child: Column(
        children: [records(), statsContainer(), floatingButton()],
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
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => const AccountUI())));
                },
                child: Container(
                    width: 30,
                    height: 30,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.person)),
              ),
              Text(
                widget.userName,
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

  /// wdiget to display the scrolling dates
  Widget scrollingDates() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.08,
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: const BoxDecoration(color: Colors.transparent),
      child: ListView.builder(
          itemCount: numberOfDays_CurrentMonth,
          scrollDirection: Axis.horizontal,
          itemBuilder: ((context, index) {
            return GestureDetector(
              onTap: () {
                showSnackBar();
                getRecordsBasedOnDate(
                    (index + 1).toString(), currentMonth, currentYear);
                print(index + 1);
              },
              child: Container(
                height: MediaQuery.of(context).size.height * 0.07,
                width: MediaQuery.of(context).size.width * 0.15,
                margin:
                    const EdgeInsets.only(left: 4, right: 4, top: 2, bottom: 2),
                decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(255, 255, 255, 255)
                            .withOpacity(0.3),
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset:
                            const Offset(0, 1), // changes position of shadow
                      ),
                    ],
                    borderRadius: const BorderRadius.all(Radius.circular(3))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text(
                      "Day",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 15),
                    ),
                    Text(
                      (index + 1).toString(),
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 15),
                    ),
                  ],
                ),
              ),
            );
          })),
    );
  }

  /// widget to display the records of the user
  Widget records() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.38,
      width: MediaQuery.of(context).size.width * 1,
      margin: const EdgeInsets.only(top: 15, bottom: 10),
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
                                  userName: widget.userName,
                                ))));
                  },
                  child: Row(
                    children: const [
                      Text(
                        "View",
                        style: TextStyle(
                            fontSize: 17,
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(width: 5),
                      Icon(
                        Icons.view_comfy_alt,
                        color: Colors.blueAccent,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.35,
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
                                      userName: widget.userName,
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
                                const Icon(Icons.view_comfy_alt,
                                    color: Colors.blueAccent),
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
      margin: const EdgeInsets.only(top: 20, bottom: 20),
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.12,
            width: MediaQuery.of(context).size.width * 0.6,
            padding: const EdgeInsets.only(left: 8, right: 5),
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Request a report",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                        fontSize: 18),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.05,
                      width: MediaQuery.of(context).size.width * 0.3,
                      padding: const EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: const Color.fromARGB(255, 99, 99, 99)
                                  .withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 1,
                              offset: const Offset(
                                  0, 1), // changes position of shadow
                            ),
                          ],
                          borderRadius:
                              const BorderRadius.all(Radius.circular(7))),
                      child: DropdownButton<String>(
                        iconEnabledColor: Colors.black,
                        underline: const SizedBox(),
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 14),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        value: selectedOption,
                        onChanged: (value) {},
                        items: <String>[
                          '1 DAY',
                          '1 WEEK',
                          '1 MONTH',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey.shade200,
                            foregroundColor: Colors.black),
                        child: const Text("REQUEST"))
                  ],
                )
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => Reports(
                            userName: widget.userName,
                          ))));
            },
            child: Container(
              height: MediaQuery.of(context).size.height * 0.12,
              width: MediaQuery.of(context).size.width * 0.3,
              padding: const EdgeInsets.only(left: 7, right: 5),
              decoration: BoxDecoration(
                  color: Colors.blueAccent,
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
                children: const [
                  Text(
                    "REPORTS",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 17),
                  ),
                  Icon(
                    Icons.view_agenda,
                    color: Colors.black,
                    size: 25,
                  )
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
                      userName: widget.userName,
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
              color: Colors.blueAccent,
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
    print("****************************************************************");
    print(widget.userName);
    print("****************************************************************");

    /// current month and year
    getCurrentMonthYear();

    /// titles of the record
    getRecordTitles();

    /// number of `day`s in current month
    getNumberOfDays();

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

  /// function to get all the titles of the records
  void getRecordTitles() {
    int count = 0;
    recordsTitles.clear();
    DatabaseReference databaseReference =
        FirebaseDatabase.instance.ref().child("records").child(widget.userName);
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
    DatabaseReference databaseReference =
        FirebaseDatabase.instance.ref().child("records").child(widget.userName);
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

  /// function to show the snackbar
  void showSnackBar() async {
    print("Snackbar: $filteredData");

    // Retrieve the data from Firebase
    await getRecordsBasedOnDate("22", currentMonth, currentYear);

    print("Snackbar: $filteredData");
    print(filteredData.length);
    final snackBar = SnackBar(
      backgroundColor: Colors.blueAccent,
      padding: const EdgeInsets.all(0),
      duration: const Duration(days: 20),
      content: Container(
        height: MediaQuery.of(context).size.height * 0.4,
        width: MediaQuery.of(context).size.width * 1,
        decoration: const BoxDecoration(color: Colors.blueAccent),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.05,
              width: MediaQuery.of(context).size.width * 1,
              margin: const EdgeInsets.only(left: 10),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: const Center(
                child: Text(
                  "(10-04-2022)",
                  style: TextStyle(
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.w600,
                      fontSize: 18),
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width * 1,
              margin: const EdgeInsets.only(left: 10),
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: ListView.builder(
                  itemCount: filteredData.length,
                  itemBuilder: ((context, index) {
                    return Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, top: 6, bottom: 6),
                      margin: const EdgeInsets.only(
                          bottom: 15, left: 10, right: 10, top: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(255, 99, 99, 99)
                                .withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 1,
                            offset: const Offset(
                                0, 1), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                filteredData[index]["title"],
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 13),
                              ),
                              Text(
                                filteredData[index]["date"],
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 13),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              filteredData[index]["description"],
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 13),
                            ),
                          ),
                        ],
                      ),
                    );
                  })),
            ),
          ],
        ),
      ),
      action: SnackBarAction(
        label: 'BACK',
        textColor: Colors.white,
        onPressed: () {},
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
