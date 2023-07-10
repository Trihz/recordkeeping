import 'package:flutter/material.dart';
import 'package:recordkeeping/homepage/homepage.dart';

class AllRecords extends StatefulWidget {
  const AllRecords({super.key});

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
          GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => const HomePage())));
              },
              child:
                  const Icon(Icons.arrow_back_ios, color: Colors.blueAccent)),
          SizedBox(
            width: MediaQuery.of(context).size.height * 0.12,
          ),
          const Text(
            "All Records",
            style: TextStyle(
                color: Colors.blueAccent,
                fontWeight: FontWeight.w400,
                fontSize: 19),
          ),
        ],
      ),
    );
  }

  /// widget to display a list of all the reports
  Widget reportsDisplay() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      width: MediaQuery.of(context).size.width * 0.95,
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: 10,
          itemBuilder: ((context, index) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.2,
              width: MediaQuery.of(context).size.width * 1,
              margin: const EdgeInsets.only(bottom: 30, left: 10, right: 10),
              padding: const EdgeInsets.only(
                  left: 10, right: 10, top: 10, bottom: 10),
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
                      children: const [
                        Text(
                          "Selling of products",
                          style: TextStyle(
                              fontSize: 17,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "(12-01-2023)",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "On January 12, 2023, am officially recording the sale of a TV to a client. This transaction marks an important event in which a TV was successfully sold and delivered. The client, [Client Name], expressed interest in purchasing a TV, and after thorough discussion and agreement on the terms, the sale was finalized.",
                      style: TextStyle(
                          wordSpacing: 2,
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
              ),
            );
          })),
    );
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
}