import 'package:connectify/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

import '../../logic/state_management/user_store.dart';

class AtsView extends StatefulWidget {
  static const id = '/atsview';
  const AtsView({super.key});

  @override
  State<AtsView> createState() => _AtsViewState();
}

class _AtsViewState extends State<AtsView> {
  String dropdownvalue = 'New Applied';
  String rating = '0.0';

  // List of items in our dropdown menu
  var items = [
    'New Applied',
    'Screening',
    'Designing Challenge',
    'Interview',
    'Test',
    'Hire',
  ];
  void getapplications() async {
    await UserStore().getApplications();
  }

  showAlertDialog(BuildContext context) {
    // Create button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Give Rating"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () {
              setState(() {
                rating = "5.0";
              });
              Navigator.of(context).pop();
            },
            child: Row(
              children: [
                Icon(
                  Icons.star,
                  color: Colors.yellow,
                ),
                Icon(
                  Icons.star,
                  color: Colors.yellow,
                ),
                Icon(
                  Icons.star,
                  color: Colors.yellow,
                ),
                Icon(
                  Icons.star,
                  color: Colors.yellow,
                ),
                Icon(
                  Icons.star,
                  color: Colors.yellow,
                ),
                SizedBox(
                  width: 10,
                ),
                Text("Outstanding")
              ],
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                rating = "4.0";
              });
              Navigator.of(context).pop();
            },
            child: Row(
              children: [
                Icon(
                  Icons.star,
                  color: Colors.yellow,
                ),
                Icon(
                  Icons.star,
                  color: Colors.yellow,
                ),
                Icon(
                  Icons.star,
                  color: Colors.yellow,
                ),
                Icon(
                  Icons.star,
                  color: Colors.yellow,
                ),
                SizedBox(
                  width: 10,
                ),
                Text("Excellent")
              ],
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                rating = "3.0";
              });
              Navigator.of(context).pop();
            },
            child: Row(
              children: [
                Icon(
                  Icons.star,
                  color: Colors.yellow,
                ),
                Icon(
                  Icons.star,
                  color: Colors.yellow,
                ),
                Icon(
                  Icons.star,
                  color: Colors.yellow,
                ),
                SizedBox(
                  width: 10,
                ),
                Text("Good")
              ],
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                rating = "2.0";
              });
              Navigator.of(context).pop();
            },
            child: Row(
              children: [
                Icon(
                  Icons.star,
                  color: Colors.yellow,
                ),
                Icon(
                  Icons.star,
                  color: Colors.yellow,
                ),
                SizedBox(
                  width: 10,
                ),
                Text("Average")
              ],
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                rating = "1.0";
              });
              Navigator.of(context).pop();
            },
            child: Row(
              children: [
                Icon(
                  Icons.star,
                  color: Colors.yellow,
                ),
                SizedBox(
                  width: 10,
                ),
                Text("Poor")
              ],
            ),
          )
        ],
      ),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    getapplications();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 25,
            ),
            Consumer<UserStore>(builder: (_, userStore, __) {
              final allResults = userStore.allApplcations;
              return ListView.builder(
                shrinkWrap: true,
                itemCount: allResults.length,
                itemBuilder: (context, index) {
                  return Container(
                      child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(10)),
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Checkbox(
                                      value: true,
                                      onChanged: (value) {},
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    ClipOval(
                                      child: Image.network(
                                        'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=580&q=80',
                                        width: 50,
                                        height: 50,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${allResults[index]["user_username"]}",
                                          style: TextStyle(
                                              color: AppColors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Container(
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.work,
                                                color: Colors.green,
                                              ),
                                              Text(
                                                "UX/UI Designer",
                                                style: TextStyle(
                                                  color: AppColors.black,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            showAlertDialog(context);
                                          },
                                          child: Container(
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.star,
                                                  color: Colors.yellow,
                                                ),
                                                Text(
                                                  rating,
                                                  style: TextStyle(
                                                      color: AppColors.black,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        DropdownButton(
                                          // Initial Value
                                          value: dropdownvalue,

                                          // Down Arrow Icon
                                          icon: const Icon(
                                            Icons.keyboard_arrow_down,
                                            color: AppColors.black,
                                          ),

                                          // Array list of items
                                          items: items.map((String items) {
                                            return DropdownMenuItem(
                                              value: items,
                                              child: Row(
                                                children: [
                                                  const Icon(
                                                    Icons.done,
                                                    color: Colors.green,
                                                  ),
                                                  Text(
                                                    items,
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                ],
                                              ),
                                            );
                                          }).toList(),
                                          // After selecting the desired option,it will
                                          // change button value to selected value
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              dropdownvalue = newValue!;
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, bottom: 10),
                                  child: SizedBox(
                                    height: 30,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(right: 10),
                                          child: Container(
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                color: AppColors.green,
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Text(
                                                "1",
                                                style: TextStyle(
                                                    color: AppColors.white,
                                                    fontSize: 10,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount: 5,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ));
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}
