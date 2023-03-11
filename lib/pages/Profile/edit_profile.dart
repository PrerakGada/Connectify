import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../widgets/LabeledTextFormField.dart';

class EditProfile extends StatefulWidget {
  static const String id = '/edit-profile';
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  bool check11 = false;
  bool check12 = false;
  bool check13 = false;
  bool check14 = false;
  bool check16 = false;
  bool check17 = false;
  bool check18 = false;
  bool check19 = false;

  bool check21 = false;
  bool check22 = false;
  bool check23 = false;
  bool check24 = false;
  bool check26 = false;
  bool check27 = false;
  bool check28 = false;
  bool check29 = false;

  bool check31 = false;
  bool check32 = false;
  bool check33 = false;
  bool check34 = false;
  bool check36 = false;
  bool check37 = false;
  bool check38 = false;
  bool check39 = false;

  bool check41 = false;
  bool check42 = false;
  bool check43 = false;
  bool check44 = false;
  bool check46 = false;
  bool check47 = false;
  bool check48 = false;
  bool check49 = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  List<Widget> _widgets = [];
  File? image;
  List<File> images = [];

  void onPickImages() async {
    images = await pickImages();
    setState(() {
      _widgets.add(images.isNotEmpty
          ? CarouselSlider(
              items: images.map(
                (file) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 5,
                    ),
                    child: Image.file(
                      file,
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ).toList(),
              options: CarouselOptions(
                height: 300,
                enableInfiniteScroll: false,
              ),
            )
          : const SizedBox());
    });
  }

  void onPickImage() async {
    image = await pickImage();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Edit Profile",
            // style: (const TextStyle(color: AppColors.black)),
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Stack(
              children: [
                Center(
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage:
                            NetworkImage("https://placeimg.com/640/480/people"),
                      ),
                      SizedBox(height: 10.0),
                      ElevatedButton(
                        onPressed: () {
                          onPickImage();
                        },
                        child: Text("Edit Profile Image"),
                      ),
                      SizedBox(height: 10.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            LabeledTextFormField(
                                controller: _nameController,
                                title: 'Username',
                                hintTitle: UserStore()
                                    .tokenData['username']
                                    .toString()),
                            SizedBox(height: 20),
                            LabeledTextFormField(
                                controller: _emailController,
                                title: 'Email',
                                hintTitle:
                                    UserStore().tokenData['email'].toString()),
                          ],
                        ),
                      ),
                      Divider(
                        thickness: 2.0,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Column(
                        children: [
                          Text(
                            "Your Intrests",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20.0),
                            textAlign: TextAlign.left,
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height / 12.5,
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                  "What type of traveler are you? Select upto 5 options for options for each quesions"),
                            ),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 40,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    growableList.add("Adventure seeker");
                                    check11 = !check11;
                                    setState(() {});
                                  },
                                  child: Chipcard(
                                    text: "Adventure seeker",
                                    check: check11,
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    check12 = !check12;
                                    setState(() {});
                                    growableList.add("Luxury traveler");
                                  },
                                  child: Chipcard(
                                    text: " Luxury traveler",
                                    check: check12,
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    check13 = !check13;
                                    setState(() {});
                                    growableList.add("Budget traveler");
                                  },
                                  child: Chipcard(
                                    text: " Budget traveler",
                                    check: check13,
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 0,
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 40,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    check16 = !check16;
                                    setState(() {});
                                    growableList.add("Cultural enthusiast");
                                  },
                                  child: Chipcard(
                                    text: " Cultural enthusiast",
                                    check: check16,
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    check17 = !check17;
                                    setState(() {});
                                    growableList.add("Nature lover");
                                  },
                                  child: Chipcard(
                                      text: "Nature lover", check: check17),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    check14 = !check14;
                                    setState(() {});
                                    growableList.add("Cost Saving");
                                  },
                                  child: Chipcard(
                                    text: " Cost Saving",
                                    check: check14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          //done
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height / 15,
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                              child: Text(
                                  "Which destinations are you interested in?"),
                            ),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 20,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    check21 = !check21;
                                    setState(() {});
                                    growableList.add("Beaches");
                                  },
                                  child: Chipcard(
                                    text: " Beaches",
                                    check: check21,
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    check22 = !check22;
                                    setState(() {});
                                    growableList.add("Mountains");
                                  },
                                  child: Chipcard(
                                    text: " Mountains",
                                    check: check22,
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    check23 = !check23;
                                    setState(() {});
                                    growableList.add("National Parks");
                                  },
                                  child: Chipcard(
                                    text: "National Parks",
                                    check: check23,
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 0,
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 20,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    check26 = !check26;
                                    setState(() {});
                                    growableList.add("Historical Sites");
                                  },
                                  child: Chipcard(
                                    text: " Historical Sites",
                                    check: check26,
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    check27 = !check27;
                                    setState(() {});
                                    growableList.add("Cultural Sites");
                                  },
                                  child: Chipcard(
                                      text: "Cultural Sites", check: check27),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    check28 = !check28;
                                    setState(() {});
                                    growableList.add("Trekking");
                                  },
                                  child: Chipcard(
                                    text: "Trekking",
                                    check: check28,
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height / 15,
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                              child: Text(
                                  "What is your preferred accommodation type?"),
                            ),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 20,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    check31 = !check31;
                                    setState(() {});
                                    growableList.add("Hotel");
                                  },
                                  child: Chipcard(
                                    text: " Hotel",
                                    check: check31,
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    check32 = !check32;
                                    setState(() {});
                                    growableList.add("Hostel");
                                  },
                                  child: Chipcard(
                                    text: " Hostel",
                                    check: check32,
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    check33 = !check33;
                                    setState(() {});
                                    growableList.add("Vacation Rental");
                                  },
                                  child: Chipcard(
                                    text: "Vacation Rental",
                                    check: check33,
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 0,
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 20,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    check36 = !check36;
                                    setState(() {});
                                    growableList.add("Camping");
                                  },
                                  child: Chipcard(
                                    text: "Camping",
                                    check: check36,
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    check37 = !check37;
                                    setState(() {});
                                    growableList.add("Resort");
                                  },
                                  child:
                                      Chipcard(text: " Resort", check: check37),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Divider(thickness: 2.0),
                          ElevatedButton(
                            onPressed: () {},
                            child: Text("Save Changes"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
