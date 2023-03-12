import 'package:connectify/theme/app_colors.dart';
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
      body: Stack(
        children: [
          Container(
            child: Image.network(
              "https://www.deccanherald.com/sites/dh/files/article_images/2018/06/04/file70frsj22cw4i6zyeaed.jpg",
              width: double.infinity,
              height: 220,
              fit: BoxFit.fill,
            ),
          ),
          SafeArea(
            top: false,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 50),
                      Container(
                        height: 275,
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                // padding: EdgeInsets.only(top: 100),
                                // height: 250,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: AppColors.greyDarker,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(
                                            height: 50,
                                          ),
                                          const Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              "Siddesh Shetty",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Text(
                                            "Cross Platform Flutter Developer",
                                          ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Text("LOC 4.0 hackathon winner"),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Row(
                                            children: const [
                                              Icon(Icons.location_on),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                "Mumbai",
                                                style: TextStyle(
                                                    //  ,
                                                    ),
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
                                                style: TextStyle(
                                                    //  ,
                                                    ),
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
                                                style: TextStyle(
                                                    //  ,
                                                    ),
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
                                                style: TextStyle(),
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
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              MaterialButton(
                                                onPressed: () {},
                                                child: Image.asset(
                                                  "assets/whatsapp.png",
                                                  height: 30,
                                                  width: 30,
                                                ),
                                              ),
                                              MaterialButton(
                                                onPressed: () {},
                                                child: Image.asset(
                                                  "assets/whatsapp.png",
                                                  height: 30,
                                                  width: 30,
                                                ),
                                              ),
                                              MaterialButton(
                                                onPressed: () {},
                                                child: Image.asset(
                                                  "assets/whatsapp.png",
                                                  height: 30,
                                                  width: 30,
                                                ),
                                              ),
                                              MaterialButton(
                                                onPressed: () {},
                                                child: Image.asset(
                                                  "assets/whatsapp.png",
                                                  height: 30,
                                                  width: 30,
                                                ),
                                              ),
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
                      Divider(
                        thickness: 1,
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
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
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
                              padding: const EdgeInsets.only(
                                  left: 5, right: 10, top: 15),
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
                      Divider(
                        thickness: 1,
                      ),
                      Container(
                        // height: 80,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.black,
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
                                  color: AppColors.white,
                                ),
                              ),
                              // Image.asset(
                              //   "assets/resume1.png",
                              //   height: 200,
                              //   color: AppColors.white,
                              // ),
                              // Image.asset(
                              //   "assets/resume2.png",
                              //   height: 20,
                              //   color: AppColors.white,
                              // )
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ElevatedButton(
                                    child: Text("View Resume"),
                                    onPressed: () {},
                                  ),
                                  ElevatedButton(
                                    child: Text("Video Resume"),
                                    onPressed: () {},
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      // Container(
                      //   width: double.infinity,
                      //   decoration: const BoxDecoration(
                      //     color: AppColors.black,
                      //   ),
                      //   child: Padding(
                      //     padding: const EdgeInsets.all(10.0),
                      //     child: Column(
                      //       crossAxisAlignment: CrossAxisAlignment.start,
                      //       children: [
                      //         Row(
                      //           children: [
                      //             Text(
                      //               "Skills",
                      //               style: TextStyle(
                      //                 fontWeight: FontWeight.bold,
                      //                 fontSize: 17,
                      //               ),
                      //             ),
                      //             SizedBox(
                      //               width: 7,
                      //             ),
                      //             Container(
                      //               decoration: BoxDecoration(
                      //                   color:
                      //                       Color.fromARGB(255, 240, 246, 236),
                      //                   borderRadius:
                      //                       BorderRadius.circular(10)),
                      //               child: Padding(
                      //                 padding: const EdgeInsets.all(5.0),
                      //                 child: Row(children: [
                      //                   Text(
                      //                     "8%",
                      //                     style:
                      //                         TextStyle(color: AppColors.black),
                      //                   ),
                      //                   Image.asset(
                      //                     "assets/growth.png",
                      //                     height: 15,
                      //                     color: Colors.green,
                      //                   )
                      //                 ]),
                      //               ),
                      //             ),
                      //             Spacer(),
                      //             Icon(
                      //               Icons.add_circle_outline,
                      //               color: AppColors.primary,
                      //             )
                      //           ],
                      //         ),
                      //         Text(
                      //           "Recruiters search via skills.Add your skills to appear in maximum recruiter searches",
                      //           style: TextStyle(color: AppColors.white),
                      //         )
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 80,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: AppColors.black,
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
                                        color: AppColors.white),
                                  ),
                                ],
                              ),
                              Wrap(
                                spacing: 7,
                                children: [
                                  Chip(
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15))),
                                    label: SizedBox(
                                      width: 80,
                                      child: Center(
                                        child: Text(
                                          "Swing",
                                          style: const TextStyle(
                                              color: AppColors.black),
                                        ),
                                      ),
                                    ),
                                    backgroundColor: AppColors.secondary,
                                    // side: BorderSide(
                                    //   width: 1,
                                    //   color: Color.fromARGB(255, 73, 255, 82),
                                    // ),
                                    elevation: 6.0,
                                    shadowColor: Colors.grey[60],
                                    padding: const EdgeInsets.all(5),
                                  ),
                                  Chip(
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15))),
                                    label: SizedBox(
                                      width: 80,
                                      child: Center(
                                        child: Text(
                                          "Photoshop",
                                          style: const TextStyle(
                                              color: AppColors.black),
                                        ),
                                      ),
                                    ),
                                    backgroundColor: AppColors.secondary,
                                    // side: BorderSide(
                                    //   width: 1,
                                    //   color: Color.fromARGB(255, 73, 255, 82),
                                    // ),
                                    elevation: 6.0,
                                    shadowColor: Colors.grey[60],
                                    padding: const EdgeInsets.all(5),
                                  ),
                                  Chip(
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15))),
                                    label: SizedBox(
                                      width: 80,
                                      child: Center(
                                        child: Text(
                                          "Flutter",
                                          style: const TextStyle(
                                              color: AppColors.black),
                                        ),
                                      ),
                                    ),
                                    backgroundColor: AppColors.secondary,
                                    // side: BorderSide(
                                    //   width: 1,
                                    //   color: Color.fromARGB(255, 73, 255, 82),
                                    // ),
                                    elevation: 6.0,
                                    shadowColor: Colors.grey[60],
                                    padding: const EdgeInsets.all(5),
                                  ),
                                  Chip(
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15))),
                                    label: SizedBox(
                                      width: 80,
                                      child: Center(
                                        child: Text(
                                          "Java",
                                          style: const TextStyle(
                                              color: AppColors.black),
                                        ),
                                      ),
                                    ),
                                    backgroundColor: AppColors.secondary,
                                    // side: BorderSide(
                                    //   width: 1,
                                    //   color: Color.fromARGB(255, 73, 255, 82),
                                    // ),
                                    elevation: 6.0,
                                    shadowColor: Colors.grey[60],
                                    padding: const EdgeInsets.all(5),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      // Container(
                      //   height: 80,
                      //   width: double.infinity,
                      //   decoration: BoxDecoration(
                      //     color: AppColors.black,
                      //   ),
                      //   child: Padding(
                      //     padding: const EdgeInsets.all(10.0),
                      //     child: Column(
                      //       crossAxisAlignment: CrossAxisAlignment.start,
                      //       children: [
                      //         const Text(
                      //           "Resume",
                      //           style: TextStyle(
                      //               fontWeight: FontWeight.bold,
                      //               fontSize: 17,
                      //               color: AppColors.white),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
