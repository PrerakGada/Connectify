import 'package:flutter/material.dart';
import '../logic/state_management/user_store.dart';
import '../theme/app_colors.dart';
import './Search/search.dart';
import 'AudioVideo/audio_recording_page.dart';
import 'AudioVideo/video_recording_page.dart';
import 'Profile/profile_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const id = "/home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int bottomSelectedIndex = 0;

  void openModalSheet() async {
    return showModalBottomSheet(
      backgroundColor: const Color.fromRGBO(35, 48, 56, 1),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
      ),
      isScrollControlled: true,
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (BuildContext context,
            StateSetter setModalState /*You can rename this!*/) {
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
                  child: InkWell(
                    onTap: () {
                      // Navigator.popAndPushNamed(context, FindTravelerScreen.id);
                    },
                    child: Row(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromRGBO(70, 90, 101, 1),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              "assets/user.png",
                              height: 20,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          "Find Travel Partner",
                          style: TextStyle(
                              color: AppColors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
                const Divider(
                  color: AppColors.grey,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
                  child: InkWell(
                    onTap: () {
                      // Navigator.popAndPushNamed(context, CreateTripScreen.id);
                    },
                    child: Row(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromRGBO(70, 90, 101, 1),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              "assets/destination.png",
                              height: 20,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          "Create Trip Plan",
                          style: TextStyle(
                              color: AppColors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
                const Divider(
                  color: AppColors.grey,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
                  child: InkWell(
                    onTap: () {
                      // Navigator.popAndPushNamed(context, AskQuestionScreen.id);
                    },
                    child: Row(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromRGBO(70, 90, 101, 1),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              "assets/askq.png",
                              height: 17,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          "Ask A Question?",
                          style:
                              TextStyle(color: AppColors.white, fontSize: 18),
                        )
                      ],
                    ),
                  ),
                ),
                const Divider(
                  color: AppColors.grey,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
                  child: InkWell(
                    onTap: () {
                      // Navigator.popAndPushNamed(context, SoSScreen.id);
                    },
                    child: Row(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromRGBO(70, 90, 101, 1),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              "assets/sos.png",
                              height: 19,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          "SoS Page",
                          style:
                              TextStyle(color: AppColors.white, fontSize: 18),
                        )
                      ],
                    ),
                  ),
                ),
                const Divider(
                  color: AppColors.grey,
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
                  child: InkWell(
                    onTap: () {
                      // Navigator.popAndPushNamed(context, CreatePostScreen.id);
                    },
                    child: Row(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromRGBO(70, 90, 101, 1),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              "assets/travel.png",
                              height: 20,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          "Create Travel Post",
                          style:
                              TextStyle(color: AppColors.white, fontSize: 18),
                        )
                      ],
                    ),
                  ),
                ),
                const Divider(
                  color: AppColors.grey,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.10,
                ),
                // Padding(padding: MediaQuery.of(context).viewInsets)
              ],
            ),
          );
        },
      ),
    );
  }

  List<BottomNavigationBarItem> buildBottomNavBarItems() {
    return [
      const BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Red',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.search),
        label: 'Blue',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.info_outline),
        label: 'Yellow',
      )
    ];
  }

  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  Widget buildPageView() {
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: pageController,
      onPageChanged: (index) {
        pageChanged(index);
      },
      children: <Widget>[
        SearchScreen(),
        AudioRecordingPage(),
        VideoRecordingPage(),
        // const ChatScreen(),
        // Container(),
        // const ViewActivity(),
        // const MapsScreen(),
      ],
    );
  }

  Widget buildNavBarItem(IconData icon, int index) {
    return GestureDetector(
      onTap: () {
        // print(index);
        // print(bottomSelectedIndex);
        // if (index == 2) {
        //   openModalSheet();
        //   bottomSelectedIndex = index;
        // } else {
        setState(() {
          bottomSelectedIndex = index;
          pageController.animateToPage(bottomSelectedIndex,
              duration: const Duration(milliseconds: 500), curve: Curves.ease);
        });
        // }
      },
      child: SizedBox(
        height: 48,
        width: MediaQuery.of(context).size.width / 5,
        child: Column(
          children: [
            Icon(
              icon,
              color: index == bottomSelectedIndex
                  ? bottomSelectedIndex == 1
                      ? Colors.blue
                      : bottomSelectedIndex == 0
                          ? Colors.green
                          : bottomSelectedIndex == 2
                              ? Colors.yellow
                              : bottomSelectedIndex == 3
                                  ? Colors.purple
                                  : bottomSelectedIndex == 4
                                      ? Colors.red
                                      : Colors.grey
                  : Colors.grey,
            ),
            index == bottomSelectedIndex
                ? Icon(Icons.arrow_drop_up,
                    color: index == bottomSelectedIndex
                        ? bottomSelectedIndex == 1
                            ? Colors.blue
                            : bottomSelectedIndex == 0
                                ? Colors.green
                                : bottomSelectedIndex == 2
                                    ? Colors.yellow
                                    : bottomSelectedIndex == 3
                                        ? Colors.purple
                                        : bottomSelectedIndex == 4
                                            ? Colors.red
                                            : Colors.grey
                        : Colors.grey)
                : Container()
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  void pageChanged(int index) {
    setState(() {
      bottomSelectedIndex = index;
    });
  }

  void bottomTapped(int index) {
    setState(() {
      bottomSelectedIndex = index;
      pageController.animateToPage(index,
          duration: const Duration(milliseconds: 500), curve: Curves.ease);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   elevation: 0,
      //   backgroundColor: Colors.transparent,
      //   // title: Text("Welcome ${UserStore().tokenData["username"]}!",
      //   //     style: const TextStyle(fontSize: 24)),
      //   actions: [
      //     // Builder( builder: (context) => MaterialButton(
      //     //     child: CircleAvatar(
      //     //       radius: 30,
      //     //       backgroundImage: NetworkImage(
      //     //         "https://tourmate.mustansirg.in/static/${UserStore().tokenData['profile_photo']}",
      //     //       ),
      //     //     ),
      //     //     onPressed: () => Scaffold.of(context).openEndDrawer(),
      //     //     // tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
      //     //   ),
      //     // ),
      //   ],
      // ),
      body: buildPageView(),
      endDrawer: const ProfileDrawer(),
      bottomNavigationBar: SafeArea(
        child: Stack(
          children: [
            Container(
              // color: Colors.black,
              decoration: const BoxDecoration(
                color: AppColors.black,
              ),
              padding: const EdgeInsets.only(top: 14),
              child: Row(
                children: <Widget>[
                  buildNavBarItem(Icons.dashboard_outlined, 0),
                  buildNavBarItem(Icons.chat_outlined, 1),
                  buildNavBarItem(Icons.add_box_outlined, 2),
                  buildNavBarItem(Icons.notifications_none_rounded, 3),
                  buildNavBarItem(Icons.location_on_outlined, 4),
                ],
              ),
            ),
          ],
        ),
      ),
      // BottomNavigationBar(
      //   currentIndex: bottomSelectedIndex,
      //   onTap: (index) {
      //     bottomTapped(index);
      //   },
      //   items: buildBottomNavBarItems(),
      // ),
    );
  }
}
