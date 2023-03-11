import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// import '../pages/Profile/edit_profile.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 40.0),
      width: MediaQuery.of(context).size.width,
      child: Drawer(
        elevation: 3.0,
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(10.0),
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Column(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(
                              "https://placeimg.com/640/480/people"),
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
                    SizedBox(
                      width: 30.0,
                    ),
                    Row(
                      children: [
                        Table(
                          defaultColumnWidth: FixedColumnWidth(80.0),
                          children: [
                            TableRow(children: [
                              // Column(children: [
                              //   SizedBox(height: 5.0),
                              //   Text('Journey',
                              //       style: TextStyle(fontSize: 18.0)),
                              //   SizedBox(height: 5.0),
                              //   Text('10', style: TextStyle(fontSize: 16.0)),
                              //   SizedBox(height: 5.0),
                              // ]),
                              Column(children: [
                                SizedBox(height: 5.0),
                                Text('Follwers',
                                    style: TextStyle(fontSize: 18.0)),
                                SizedBox(height: 5.0),
                                Text('123', style: TextStyle(fontSize: 16.0)),
                                SizedBox(height: 5.0),
                              ]),
                              Column(children: [
                                SizedBox(height: 5.0),
                                Text('Following',
                                    style: TextStyle(fontSize: 18.0)),
                                SizedBox(height: 5.0),
                                Text('456', style: TextStyle(fontSize: 16.0)),
                                SizedBox(height: 5.0),
                              ]),
                            ]),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                // Table(
                //   defaultColumnWidth: FixedColumnWidth(200.0),
                //   border: TableBorder.all(
                //       color: Colors.white, style: BorderStyle.solid, width: 2),
                //   children: [
                //     TableRow(children: [
                //       Column(children: [
                //         SizedBox(height: 5.0),
                //         Text('Follwers', style: TextStyle(fontSize: 20.0)),
                //         SizedBox(height: 5.0),
                //         Text('123', style: TextStyle(fontSize: 15.0)),
                //         SizedBox(height: 5.0),
                //       ]),
                //       Column(children: [
                //         SizedBox(height: 5.0),
                //         Text('Following', style: TextStyle(fontSize: 20.0)),
                //         SizedBox(height: 5.0),
                //         Text('456', style: TextStyle(fontSize: 15.0)),
                //         SizedBox(height: 5.0),
                //       ]),
                //     ]),
                //   ],
                // ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            // Navigator.push( context,
                            //     MaterialPageRoute(
                            //         builder: (context) => EditProfile()));
                          },
                          child: Text("Edit Profile")),
                      ElevatedButton(
                          onPressed: () {}, child: Text("Share Profile")),
                    ]),
                SizedBox(
                  width: 25.0,
                ),
                Divider(
                  color: Colors.white24,
                  thickness: 2.0,
                ),

                //chips here
                // SizedBox(
                //   height: 20.0,
                // ),
                Column(
                  children: [
                    // Align(
                    //   alignment: Alignment.centerLeft,
                    //   child: Container(
                    //     child: Text(
                    //       "Your Preferences",
                    //       style: TextStyle(
                    //           fontWeight: FontWeight.bold, fontSize: 20.0),
                    //       textAlign: TextAlign.left,
                    //     ),
                    //   ),
                    // ),
                    Text(
                      "Your Intrests",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Column(
                  children: [
                    Text("What type of traveler are you?"),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
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
                SizedBox(
                  height: 20.0,
                ),
                Column(
                  children: [
                    Text("Which destinations are you interested in?"),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
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
                SizedBox(
                  height: 20.0,
                ),
                Column(
                  children: [
                    Text("What is your preferred accommodation type?"),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
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

                Divider(
                  color: Colors.white24,
                  thickness: 2.0,
                ),

                //previous trips
                Column(
                  children: [
                    Text(
                      "Previous Trips(4)",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
                Container(
                  margin: EdgeInsets.all(10.0),
                  padding: EdgeInsets.all(10.0),
                  width: MediaQuery.of(context).size.width,
                  height: 200.0,
                  color: Colors.amber,
                ),
                Container(
                  margin: EdgeInsets.all(10.0),
                  padding: EdgeInsets.all(10.0),
                  width: MediaQuery.of(context).size.width,
                  height: 200.0,
                  color: Colors.amber,
                ),
                Container(
                  margin: EdgeInsets.all(10.0),
                  padding: EdgeInsets.all(10.0),
                  width: MediaQuery.of(context).size.width,
                  height: 200.0,
                  color: Colors.amber,
                ),
                Container(
                  margin: EdgeInsets.all(10.0),
                  padding: EdgeInsets.all(10.0),
                  width: MediaQuery.of(context).size.width,
                  height: 200.0,
                  color: Colors.amber,
                ),

                Divider(
                  color: Colors.white24,
                  thickness: 2.0,
                ),

                //socials

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: Icon(
                        FontAwesomeIcons.instagram,
                        size: 25,
                      ),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(
                        FontAwesomeIcons.facebook,
                        size: 25,
                      ),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(
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
      ),
    );
  }
}
