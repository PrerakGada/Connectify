import 'package:connectify/Theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../widgets/progress_bar.dart';

class Profile extends StatefulWidget {
  static const id = '/profileid';
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 50,
              ),
              Container(
                height: 275,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        // padding: EdgeInsets.only(top: 100),
                        height: 250,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 50,
                                  ),
                                  const Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Siddesh Shetty",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: const [
                                      Icon(Icons.location_on),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "Mumbai",
                                        style: TextStyle(color: Colors.black),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: const [
                                      Icon(Icons.work),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "0 Years 6 Months",
                                        style: TextStyle(color: Colors.black),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: const [
                                      Icon(Icons.phone),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "+91 9004137508",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      SizedBox(
                                        width: 3,
                                      ),
                                      Icon(
                                        Icons.verified,
                                        color: AppColors.primary,
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: const [
                                      Icon(Icons.email),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "siddushetty30@gmail.com",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      SizedBox(
                                        width: 3,
                                      ),
                                      Icon(
                                        Icons.verified,
                                        color: AppColors.primary,
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Image.asset(
                        "assets/whatsapp.png",
                        height: 60,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Text(
                          "Your Profile Score (73% complete)",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                        Spacer(),
                        Icon(Icons.arrow_forward_ios)
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                      "Recruiters Notice You From 70%",
                      style: TextStyle(fontSize: 14),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 5, right: 10, top: 15),
                      child: ProgressBar(
                        progress: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                height: 80,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Resume",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            color: AppColors.black),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Skills",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                                color: AppColors.black),
                          ),
                          SizedBox(
                            width: 7,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 240, 246, 236),
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Row(children: [
                                Text(
                                  "8%",
                                  style: TextStyle(color: AppColors.black),
                                ),
                                Image.asset(
                                  "assets/growth.png",
                                  height: 15,
                                  color: Colors.green,
                                )
                              ]),
                            ),
                          ),
                          Spacer(),
                          Icon(
                            Icons.add_circle_outline,
                            color: AppColors.primary,
                          )
                        ],
                      ),
                      Text(
                        "Recruiters search via skills.Add your skills to appear in maximum recruiter searches",
                        style: TextStyle(color: AppColors.black),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 80,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "IT Skills",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                                color: AppColors.black),
                          ),
                          SizedBox(
                            width: 7,
                          ),
                          Spacer(),
                          Icon(
                            Icons.add_circle_outline,
                            color: AppColors.primary,
                          )
                        ],
                      ),
                      Text(
                        "Recruiters search via skills.Add your skills to appear in maximum recruiter searches",
                        style: TextStyle(color: AppColors.black),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 80,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Resume",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            color: AppColors.black),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
