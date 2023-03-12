import 'dart:io';

import 'package:connectify/pages/calendar/calendar_view.dart';
import 'package:connectify/theme/app_colors.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../../logic/state_management/user_store.dart';
import '../../widgets/progress_bar.dart';
import '../Onboarding/splash_screen.dart';
import 'edit_profile_screen.dart';

class Profile extends StatefulWidget {
  static const id = '/profileid';

  const Profile({super.key, this.user});

  final user;

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late bool x = false;

  var progress = 0.62;
  File? file;
  var uploaded = false;
  void onPickFileButtonClicked() async {
    FilePickerResult? tempImage = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (tempImage == null) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('An error occurred. Failed to pick image!'),
      ));
      return;
    }
    setState(() {
      file = File(tempImage.files.single.path!);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.user == null) {
      x = false;
    } else {
      x = true;
    }
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
                        // height: 275,
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                padding: EdgeInsets.only(top: 100),
                                // height: 250,
                                width: double.infinity,

                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.black,
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
                                            Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                x
                                                    ? widget.user["username"]
                                                    : "Siddesh Shetty",
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
                                              x
                                                  ? widget.user["keyskills"]
                                                  : "Cross Platform Flutter Developer",
                                            ),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            Text("LOC 4.0 hackathon winner"),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            Row(
                                              children: [
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
                                              children: [
                                                Icon(Icons.email),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  x
                                                      ? widget.user["email"]
                                                      : "siddushetty30@gmail.com",
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
                                                  child: Image.network(
                                                    "https://cdn-icons-png.flaticon.com/512/733/733579.png",
                                                    height: 30,
                                                    width: 30,
                                                  ),
                                                ),
                                                MaterialButton(
                                                  onPressed: () {},
                                                  child: Image.network(
                                                    "https://cdn-icons-png.flaticon.com/512/2111/2111463.png",
                                                    height: 30,
                                                    width: 30,
                                                  ),
                                                ),
                                                MaterialButton(
                                                  onPressed: () {},
                                                  child: Image.network(
                                                    "https://cdn-icons-png.flaticon.com/512/4945/4945973.png",
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
                            ),
                            Align(
                              alignment: Alignment.topCenter,
                              child: CircleAvatar(
                                radius: 60,
                                backgroundImage: AssetImage(
                                  "assets/img.png",
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
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
                                    onPressed: () {
                                        onPickFileButtonClicked();
                                        setState(() {
                                          progress = 0.8;
                                        });
                                    },
                                  ),
                                  ElevatedButton(
                                    child: uploaded
                                        ? Icon(Icons.done)
                                        : Text("Video Resume"),
                                    onPressed: () async {
                                      return showModalBottomSheet(
                                          context: context,
                                          isScrollControlled: true,
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10)),
                                          ),
                                          builder: (context) => StatefulBuilder(
                                              builder:
                                                  (BuildContext context,
                                                  StateSetter
                                                  setModalState) {
                                                return FractionallySizedBox(
                                                  heightFactor: 0.4,
                                                  child: EditProfile(),
                                                );
                                              })).then((value) {
                                        setState(() {
                                          progress = 0.90;
                                          uploaded = true;
                                        });
                                      });
                                    },
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        // height: 80,
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
          SafeArea(
            child: Align(
              alignment: Alignment.topRight,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, ShiftScheduler.id);
                    },
                    child: Container(
                      height: 30,
                      width: 30,
                      child: Text('.'),
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      await UserStore().logout();
                      Navigator.popAndPushNamed(context, SplashScreen.id);
                    },
                    icon: Icon(Icons.exit_to_app),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, EditProfile.id);
                    },
                    child: Container(
                      height: 30,
                      width: 30,
                      child: Text('.'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
