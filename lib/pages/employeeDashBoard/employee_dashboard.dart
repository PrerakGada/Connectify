import 'package:connectify/theme/palette.dart';
import 'package:connectify/widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import '../../models/bar.dart';
import '../../models/user.dart';
import '../../widgets/circular_progress_indicator.dart';

import '../Graph/graph.dart';
import 'bar_chart_graph.dart';

class EmployeeDashBoard extends StatefulWidget {
  static const id = '/employeeScreen';
  const EmployeeDashBoard({super.key});

  @override
  State<EmployeeDashBoard> createState() => _EmployeeDashBoardState();
}

class _EmployeeDashBoardState extends State<EmployeeDashBoard> {
  final categorycontroller = TextEditingController();
  List<String> stats = [
    "Profile Viewed",
    "Contacted You",
    "Profile Bookmarked"
  ];
  List<Color> color = [
    Color.fromARGB(255, 199, 244, 194),
    Color.fromARGB(255, 191, 181, 255),
    Color.fromARGB(255, 252, 220, 141)
  ];
  final List<BarChartModel> data = [
    BarChartModel(
      year: "2014",
      financial: 250,
      color: charts.ColorUtil.fromDartColor(Color(0xFF47505F)),
    ),
    BarChartModel(
      year: "2015",
      financial: 300,
      color: charts.ColorUtil.fromDartColor(Colors.red),
    ),
    BarChartModel(
      year: "2016",
      financial: 100,
      color: charts.ColorUtil.fromDartColor(Colors.green),
    ),
    BarChartModel(
      year: "2017",
      financial: 450,
      color: charts.ColorUtil.fromDartColor(Colors.black),
    ),
    BarChartModel(
      year: "2018",
      financial: 630,
      color: charts.ColorUtil.fromDartColor(Colors.lightBlueAccent),
    ),
    BarChartModel(
      year: "2019",
      financial: 1000,
      color: charts.ColorUtil.fromDartColor(Colors.pink),
    ),
    BarChartModel(
      year: "2020",
      financial: 400,
      color: charts.ColorUtil.fromDartColor(Colors.purple),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.grey,
        elevation: 0,
        title: Row(children: [
          SearchBar(
              height: 40,
              width: 300,
              controller: categorycontroller,
              title: "Search Designation,..",
              onChanged: () {}),
          SizedBox(
            width: 25,
          ),
          Icon(Icons.notifications)
        ]),
      ),
      body: Container(
          child: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: AppColors.black,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Your Profile Score",
                        style: TextStyle(
                            color: AppColors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      Icon(Icons.info)
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      CircularProgressIndicatorWithPercentage(
                          percent: 50.0, radius: 30.0),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Poor",
                              style: TextStyle(
                                color: AppColors.primary,
                                fontSize: 15,
                              )),
                          Text(
                              "Improve profile strength fill all\nthe gaps to get your perfect job",
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 15,
                              ))
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: 300,
                      height: 50,
                      child: ElevatedButton(
                          onPressed: () async {},
                          style: ButtonStyle(
                            elevation: MaterialStateProperty.all(0),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color.fromARGB(255, 200, 124, 254)),
                          ),
                          child: const Text(
                            "Complete Your Profile >",
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: AppColors.black,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Hi Siddesh Shetty,",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  RichText(
                    text: const TextSpan(
                        text: 'Your Profile Performance',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                        children: [
                          TextSpan(
                              text: '(in last 30 days)',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12))
                        ]),
                    textScaleFactor: 1,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 100,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Container(
                            height: 50,
                            width: 110,
                            decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(14)),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "0",
                                    style: TextStyle(
                                        color: AppColors.black,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Text(stats[index],
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: AppColors.black))
                                ]),
                          ),
                        );
                      },
                      itemCount: stats.length,
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 10),
            child: Text(
              "For you",
              style: TextStyle(
                  color: AppColors.white,
                  fontSize: 23,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: SizedBox(
              height: 200,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: Container(
                      height: 50,
                      width: 170,
                      decoration: BoxDecoration(
                          color: color[index],
                          borderRadius: BorderRadius.circular(14)),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                "assets/social.png",
                                height: 35,
                              ),
                              SizedBox(
                                height: 100,
                              ),
                              Text(
                                "Senior UX/UI Designer",
                                style: TextStyle(
                                    color: AppColors.black,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold),
                              ),
                              RichText(
                                text: const TextSpan(
                                    text: 'Full-Time',
                                    style: TextStyle(
                                        color: AppColors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13),
                                    children: [
                                      TextSpan(
                                          text: ' • ',
                                          style: TextStyle(
                                              color: AppColors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13)),
                                      TextSpan(
                                          text: 'Contract',
                                          style: TextStyle(
                                              color: AppColors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13))
                                    ]),
                                textScaleFactor: 1,
                              ),
                            ]),
                      ),
                    ),
                  );
                },
                itemCount: stats.length,
              ),
            ),
          ),

          // MyGraphWidget(
          //   seriesList: [
          //     charts.Series(
          //       id: 'Your skills',
          //       data: [
          //         Data(0, 5, 'A'),
          //         Data(1, 25, 'B'),
          //         Data(2, 100, 'C'),
          //         Data(3, 75, 'D'),
          //         Data(4, 20, 'E'),
          //       ],
          //       domainFn: (data, index) => (data as Data).x,
          //       measureFn: (data, index) => (data as Data).y,
          //       colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
          //       labelAccessorFn: (data, index) => (data as Data).label,
          //     ),
          //     charts.Series(
          //       id: 'Average Skills',
          //       data: [
          //         Data(0, 50, 'A'),
          //         Data(1, 100, 'b'),
          //         Data(2, 200, 'C'),
          //         Data(3, 150, 'D'),
          //         Data(4, 80, 'E'),
          //       ],
          //       domainFn: (data, index) => (data as Data).x,
          //       measureFn: (data, index) => (data as Data).y,
          //       colorFn: (_, __) => charts.MaterialPalette.white,
          //       labelAccessorFn: (data, index) => (data as Data).label,
          //     ),
          //   ],
          //   animate: true,
          // ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Container(
          //     width: 150,
          //     height: 200,
          //     decoration: BoxDecoration(
          //         color: Colors.white, borderRadius: BorderRadius.circular(15)),
          //     child: Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         // Container(
          //         //   height: 100,
          //         //   decoration: BoxDecoration(
          //         //       color: Colors.amber,
          //         //       borderRadius: BorderRadius.only(
          //         //           topLeft: Radius.circular(15),
          //         //           topRight: Radius.circular(15))),
          //         //   child: Container(
          //         //     child: ListView(
          //         //       scrollDirection: Axis.vertical,
          //         //       shrinkWrap: true,
          //         //       children: [
          //         //         BarChartGraph(
          //         //           data: data,
          //         //         ),
          //         //       ],
          //         //     ),
          //         //   ),
          //         // ),
          //         // Container(
          //         //   height: 100,
          //         //   decoration: BoxDecoration(
          //         //       color: Colors.amber,
          //         //       borderRadius: BorderRadius.only(
          //         //           bottomLeft: Radius.circular(15),
          //         //           bottomRight: Radius.circular(15))),
          //         // )
          //       ],
          //     ),
          //   ),
          // ),
          // Container(
          //   child: ListView(
          //     scrollDirection: Axis.vertical,
          //     shrinkWrap: true,
          //     children: [
          //       BarChartGraph(
          //         data: data,
          //       ),
          //     ],
          //   ),
          // ),
        ]),
      )),
    );
  }
}
