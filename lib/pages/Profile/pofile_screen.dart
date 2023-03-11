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
              // Container(
              //   height: 200,
              //   width: double.infinity,
              //   decoration: BoxDecoration(
              //     color: Colors.white,
              //     borderRadius: BorderRadius.circular(10),
              //   ),
              //   child: Stack(
              //     clipBehavior: Clip.none,
              //     children: const [
              //       // Positioned(
              //       //   top: -40,
              //       //   left: 0,
              //       //   right: 0,
              //       //   child: CircleAvatar(
              //       //     radius: 50,
              //       //     backgroundImage: NetworkImage(
              //       //       'https://picsum.photos/250?image=9',
              //       //     ),
              //       //   ),
              //       // ),
              //       Text(
              //         "Siddesh Shetty",
              //         style: TextStyle(color: Colors.black),
              //       )
              //     ],
              //   ),
              // ),
              Container(
                height: 250,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
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
              )

              // * 3 user Name
              // buildUserInfo(),

              // //* 4 total no. of posts, followers, following (Row Widget)
              // buildUserActivity(),

              // // * 5 follow and message button (Row widget)
              // buildUserEvents(size),

              // // *
              // _pages[_selectedEvent],
            ],
          ),
        ),
      ),
    );
  }

  Container buildUserEvents(Size size) {
    return Container(
      // color: Colors.grey.shade100,
      child: Row(
        children: [
          Expanded(
            child: Container(
              width: size.width / 1.8,
              padding: EdgeInsets.all(8),
              child: MaterialButton(
                elevation: 0.5,
                shape: RoundedRectangleBorder(
                    // borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.blue.shade700)),
                color: Colors.blue.shade700,
                onPressed: () {
                  setState(() {});
                },
                child: Text("Gallery",
                    style: TextStyle(
                      color: Colors.white,
                    )),
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: size.width / 1.8,
              padding: EdgeInsets.all(8),
              child: MaterialButton(
                elevation: 0.5,
                shape: RoundedRectangleBorder(
                    // borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.blue.shade700)),
                color: Colors.blue.shade700,
                onPressed: () {
                  setState(() {});
                },
                child: Text("Posts",
                    style: TextStyle(
                      color: Colors.white,
                    )),
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: size.width / 1.8,
              padding: EdgeInsets.all(8),
              child: MaterialButton(
                elevation: 0.5,
                shape: RoundedRectangleBorder(
                    // borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.blue.shade700)),
                color: Colors.blue.shade700,
                onPressed: () {
                  setState(() {});
                },
                child: Text("Articles",
                    style: TextStyle(
                      color: Colors.white,
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
