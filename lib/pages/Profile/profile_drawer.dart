import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../logic/state_management/user_store.dart';
import '../../theme/palette.dart';
import '../Settings/settings.dart';
// import 'edit_profile.dart';

class ProfileDrawer extends StatelessWidget {
  const ProfileDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.greyDarker,
      padding: const EdgeInsets.only(top: 40.0),
      width: MediaQuery.of(context).size.width,
      child: Drawer(
        elevation: 3.0,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.chevron_left),
                    ),
                    Text(
                      "Welcome Prerak!",
                      // "Welcome ${UserStore().tokenData["username"]}!",
                      style: const TextStyle(fontSize: 24),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(Settings.id);
                      },
                      icon: const Icon(Icons.settings),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Column(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(
                            // "https://innovate-minds.mustansirg.in/static/${UserStore().tokenData['profile_photo']}",
                            "https://cdn-icons-png.flaticon.com/512/2111/2111463.png",
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          // UserStore().tokenData["username"],
                          "Prerak",
                          style: const TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 30.0,
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: const [
                              SizedBox(height: 5.0),
                              Text('Tours', style: TextStyle(fontSize: 18.0)),
                              SizedBox(height: 5.0),
                              Text('10', style: TextStyle(fontSize: 16.0)),
                              SizedBox(height: 5.0),
                            ],
                          ),
                          Column(
                            children: const [
                              SizedBox(height: 5.0),
                              Text('Follwers',
                                  style: TextStyle(fontSize: 18.0)),
                              SizedBox(height: 5.0),
                              Text('123', style: TextStyle(fontSize: 16.0)),
                              SizedBox(height: 5.0),
                            ],
                          ),
                          Column(
                            children: const [
                              SizedBox(height: 5.0),
                              Text('Following',
                                  style: TextStyle(fontSize: 18.0)),
                              SizedBox(height: 5.0),
                              Text('456', style: TextStyle(fontSize: 16.0)),
                              SizedBox(height: 5.0),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: ElevatedButton(
                            onPressed: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) =>
                              //             const EditProfile()));
                            },
                            child: const Text("Edit Profile")),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: ElevatedButton(
                            onPressed: () {},
                            child: const Text("Share Profile")),
                      ),
                    ]),
                const SizedBox(
                  width: 25.0,
                ),
                const Divider(
                  thickness: 2.0,
                ),

                const Text(
                  "Your Interests",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 20.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "What type of traveler are you?",
                          style: TextStyle(fontSize: 18),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: const [
                              Chip(
                                backgroundColor: Colors.white12,
                                label: Text("Adventure seeker"),
                              ),
                              SizedBox(width: 12),
                              Chip(
                                backgroundColor: Colors.white12,
                                label: Text("Budget traveler"),
                              ),
                              SizedBox(width: 12),
                              Chip(
                                backgroundColor: Colors.white12,
                                label: Text("Nature lover"),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Which destinations are you interested in?",
                          style: TextStyle(fontSize: 18),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: const [
                              Chip(
                                backgroundColor: Colors.white12,
                                label: Text("Beaches"),
                              ),
                              SizedBox(width: 12.0),
                              Chip(
                                backgroundColor: Colors.white12,
                                label: Text("Mountains"),
                              ),
                              SizedBox(width: 12),
                              Chip(
                                backgroundColor: Colors.white12,
                                label: Text("National Parks"),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "What is your preferred accommodation type?",
                          style: TextStyle(fontSize: 18),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: const [
                              Chip(
                                backgroundColor: Colors.white12,
                                label: Text("Hostel"),
                              ),
                              SizedBox(width: 12),
                              Chip(
                                backgroundColor: Colors.white12,
                                label: Text("Vacation rental"),
                              ),
                              SizedBox(width: 12),
                              Chip(
                                backgroundColor: Colors.white12,
                                label: Text("Camping"),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const Divider(
                  thickness: 2.0,
                ),

                //previous trips
                Column(
                  children: const [
                    Text(
                      "Previous Trips(4)",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
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
      ),
    );
  }
}
