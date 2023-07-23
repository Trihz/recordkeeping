// ignore_for_file: must_be_immutable, avoid_print, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class ReportDisplay extends StatefulWidget {
  List contentOfReport = [];
  String typeOfReport = "";
  String periodOfReport = "";

  ReportDisplay(
      {super.key,
      required this.contentOfReport,
      required this.typeOfReport,
      required this.periodOfReport});

  @override
  State<ReportDisplay> createState() => _ReportDisplayState();
}

class _ReportDisplayState extends State<ReportDisplay> {
  /// widget to display the content of the record
  Widget reportContentDisplay() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      width: MediaQuery.of(context).size.width * 0.92,
      padding: const EdgeInsets.only(top: 15, bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GradientText("Period:",
                  style: TextStyle(fontWeight: FontWeight.w300, fontSize: 15),
                  colors: const [Colors.orange, Colors.purple]),
              const SizedBox(width: 10),
              GradientText(widget.typeOfReport,
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                  colors: const [Colors.orange, Colors.purple]),
            ],
          ),
          GradientText(widget.periodOfReport,
              style: TextStyle(fontWeight: FontWeight.w300, fontSize: 15),
              colors: const [Colors.orange, Colors.purple]),
          const Divider(color: Color.fromARGB(255, 164, 164, 164)),
          Container(
            height: MediaQuery.of(context).size.height * 0.68,
            width: MediaQuery.of(context).size.width * 1,
            decoration: const BoxDecoration(
              color: Colors.transparent,
            ),
            child: ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: widget.contentOfReport[0].length,
                itemBuilder: ((context, index) {
                  return Container(
                    width: MediaQuery.of(context).size.width * 1,
                    margin: const EdgeInsets.only(bottom: 20),
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.65,
                          decoration: const BoxDecoration(
                            color: Colors.transparent,
                          ),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  widget.contentOfReport[0][index]["title"],
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14),
                                ),
                              ),
                              const SizedBox(height: 7),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "(${widget.contentOfReport[0][index]["date"]})",
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 12),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  widget.contentOfReport[0][index]
                                      ["description"],
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 13),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            color: Colors.transparent,
                          ),
                          child: Center(
                            child: Column(
                              children: [
                                Text(
                                  "Ksh",
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 13),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  widget.contentOfReport[0][index]["amount"],
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                })),
          ),
        ],
      ),
    );
  }

  /// initial function of the screen
  @override
  void initState() {
    print("********************************");
    print(widget.typeOfReport);
    print(widget.periodOfReport);
    print("********************************");
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
      child: Center(
        child: reportContentDisplay(),
      ),
    ));
  }
}
