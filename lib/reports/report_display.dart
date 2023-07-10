import 'package:flutter/material.dart';

class ReportDisplay extends StatefulWidget {
  List contentOfReport = [];
  ReportDisplay({super.key, required this.contentOfReport});

  @override
  State<ReportDisplay> createState() => _ReportDisplayState();
}

class _ReportDisplayState extends State<ReportDisplay> {
  /// widget to display the content of the record
  Widget recordContent() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      width: MediaQuery.of(context).size.width * 0.9,
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
            children: const [
              Text(
                "Period:",
                style: TextStyle(
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.w400,
                    fontSize: 18),
              ),
              SizedBox(width: 10),
              Text(
                "3 Months",
                style: TextStyle(
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.w500,
                    fontSize: 18),
              ),
            ],
          ),
          const Text(
            "(10-01-2022)  -  (10-04-2022)",
            style: TextStyle(
                color: Colors.blueAccent,
                fontWeight: FontWeight.w300,
                fontSize: 18),
          ),
          const Divider(color: Color.fromARGB(255, 164, 164, 164)),
          Container(
            height: MediaQuery.of(context).size.height * 0.58,
            width: MediaQuery.of(context).size.width * 1,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: widget.contentOfReport[0].length,
                itemBuilder: ((context, index) {
                  return Container(
                    width: MediaQuery.of(context).size.width * 1,
                    margin: const EdgeInsets.only(bottom: 15),
                    padding: const EdgeInsets.only(left: 20, right: 20),
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
                                fontWeight: FontWeight.w500,
                                fontSize: 18),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            widget.contentOfReport[0][index]["description"],
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w300,
                                fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  );
                })),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.05,
            width: MediaQuery.of(context).size.width * 0.5,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: ElevatedButton(
              onPressed: (() {}),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white),
              child: const Text(
                "DOWNLOAD",
                style: TextStyle(fontWeight: FontWeight.w300, fontSize: 18),
              ),
            ),
          )
        ],
      ),
    );
  }

  /// initial function of the screen
  @override
  void initState() {
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
        child: recordContent(),
      ),
    ));
  }
}
