import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 40.0),
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(10.0),
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                children: [
                  Column(
                    children: const [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage:
                            NetworkImage("https://placeimg.com/640/480/people"),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        "John Doe",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 30.0,
                  ),
                  Row(
                    children: [
                      Row(
                        children: [
                          // Column(children: [
                          //   SizedBox(height: 5.0),
                          //   Text('Journey',
                          //       style: TextStyle(fontSize: 18.0)),
                          //   SizedBox(height: 5.0),
                          //   Text('10', style: TextStyle(fontSize: 16.0)),
                          //   SizedBox(height: 5.0),
                          // ]),
                          Column(
                            children: const [
                              SizedBox(height: 5.0),
                              Text('Followers', style: TextStyle(fontSize: 16)),
                              SizedBox(height: 5.0),
                              Text('123', style: TextStyle(fontSize: 14)),
                              SizedBox(height: 5.0),
                            ],
                          ),
                          Column(
                            children: const [
                              SizedBox(height: 5.0),
                              Text('Followings',
                                  style: TextStyle(fontSize: 16)),
                              SizedBox(height: 5.0),
                              Text('456', style: TextStyle(fontSize: 14)),
                              SizedBox(height: 5.0),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                ElevatedButton(
                  onPressed: () {},
                  child: const Text("Follow"),
                ),
                ElevatedButton(
                    onPressed: () {}, child: const Text("Share Profile")),
              ]),
              const SizedBox(
                width: 25.0,
              ),
              const Divider(
                color: Colors.white24,
                thickness: 2.0,
              ),

              //chips here
              // SizedBox(
              //   height: 20.0,
              // ),
              Column(
                children: const [
                  Text(
                    "Intrests",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),
              Column(
                children: [
                  const Text("What type of traveler are you?"),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        Chip(
                          backgroundColor: Colors.white12,
                          label: Text("Adventure seeker"),
                        ),
                        Chip(
                          backgroundColor: Colors.white12,
                          label: Text("Budget traveler"),
                        ),
                        Chip(
                          backgroundColor: Colors.white12,
                          label: Text("Nature lover"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),
              Column(
                children: [
                  const Text("Which destinations are you interested in?"),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        Chip(
                          backgroundColor: Colors.white12,
                          label: Text("Beaches"),
                        ),
                        Chip(
                          backgroundColor: Colors.white12,
                          label: Text("Mountains"),
                        ),
                        Chip(
                          backgroundColor: Colors.white12,
                          label: Text("National Parks"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),
              Column(
                children: [
                  const Text("What is your preferred accommodation type?"),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        Chip(
                          backgroundColor: Colors.white12,
                          label: Text("Hostel"),
                        ),
                        Chip(
                          backgroundColor: Colors.white12,
                          label: Text("Vacation rental"),
                        ),
                        Chip(
                          backgroundColor: Colors.white12,
                          label: Text("Camping"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const Divider(
                color: Colors.white24,
                thickness: 2.0,
              ),

              //previous trips
              Column(
                children: const [
                  Text(
                    "Previous Trips(4)",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              Container(
                margin: const EdgeInsets.all(10.0),
                padding: const EdgeInsets.all(10.0),
                width: MediaQuery.of(context).size.width,
                height: 200.0,
                color: Colors.amber,
              ),
              Container(
                margin: const EdgeInsets.all(10.0),
                padding: const EdgeInsets.all(10.0),
                width: MediaQuery.of(context).size.width,
                height: 200.0,
                color: Colors.amber,
              ),
              Container(
                margin: const EdgeInsets.all(10.0),
                padding: const EdgeInsets.all(10.0),
                width: MediaQuery.of(context).size.width,
                height: 200.0,
                color: Colors.amber,
              ),
              Container(
                margin: const EdgeInsets.all(10.0),
                padding: const EdgeInsets.all(10.0),
                width: MediaQuery.of(context).size.width,
                height: 200.0,
                color: Colors.amber,
              ),

              const Divider(
                color: Colors.white24,
                thickness: 2.0,
              ),

              //socials

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: const Icon(
                      FontAwesomeIcons.instagram,
                      size: 25,
                    ),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(
                      FontAwesomeIcons.facebook,
                      size: 25,
                    ),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(
                      FontAwesomeIcons.twitter,
                      size: 25,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
