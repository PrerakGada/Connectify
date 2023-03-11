import 'package:connectify/pages/Search/search.dart';
import 'package:connectify/theme/typography.dart';
import 'package:flutter/material.dart';

// import 'package:connectify/widgets/curved_shape.dart';
import 'package:connectify/theme/app_colors.dart';
import 'package:connectify/pages/VideoConferencing/video_conferencing.dart';
import 'package:connectify/theme/typography.dart';

class CompanyDetails extends StatefulWidget {
  CompCard details;

  CompanyDetails({super.key, required this.details});

  @override
  State<CompanyDetails> createState() => _CompanyDetailsState();
}

class _CompanyDetailsState extends State<CompanyDetails> {
  String bullet = "\u2022 ";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              child: Image.network(
                "https://www.deccanherald.com/sites/dh/files/article_images/2018/06/04/file70frsj22cw4i6zyeaed.jpg",
                width: double.infinity,
                height: 220,
                fit: BoxFit.fill,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 170),
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 60),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: const BoxDecoration(
                            color: AppColors.greyDarker,
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                          ),
                          child: SafeArea(
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Text(
                                    widget.details.title,
                                    style: textTheme.headlineLarge,
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Chip(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15))),
                                        label: Container(
                                          width: 90,
                                          child: Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.location_on,
                                                  color: Colors.black,
                                                ),
                                                Text(
                                                  widget.details.location,
                                                  style:
                                                      TextStyle(color: Colors.black),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        backgroundColor:
                                            Color.fromARGB(255, 160, 255, 164),
                                        // side: BorderSide(
                                        //   width: 1,
                                        //   color: Color.fromARGB(255, 73, 255, 82),
                                        // ),
                                        elevation: 6.0,
                                        shadowColor: Colors.grey[60],
                                        padding: const EdgeInsets.all(5),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Chip(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15))),
                                        label: Container(
                                          width: 90,
                                          child: Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.work,
                                                  color: Colors.black,
                                                ),
                                                Text(
                                                  widget.details.experience,
                                                  style:
                                                      TextStyle(color: Colors.black),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        backgroundColor:
                                            Color.fromARGB(255, 255, 156, 156),
                                        // side: BorderSide(
                                        //   width: 1,
                                        //   color: Color.fromARGB(255, 73, 255, 82),
                                        // ),
                                        elevation: 6.0,
                                        shadowColor: Colors.grey[60],
                                        padding: const EdgeInsets.all(5),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Chip(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15))),
                                        label: Container(
                                          width: 90,
                                          child: Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.currency_rupee,
                                                  color: Colors.black,
                                                ),
                                                Text(
                                                  widget.details.pay,
                                                  style:
                                                      TextStyle(color: Colors.black),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        backgroundColor:
                                            Color.fromARGB(255, 255, 243, 156),
                                        // side: BorderSide(
                                        //   width: 1,
                                        //   color: Color.fromARGB(255, 73, 255, 82),
                                        // ),
                                        elevation: 6.0,
                                        shadowColor: Colors.grey[60],
                                        padding: const EdgeInsets.all(5),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Wrap(
                                    spacing: 10.0,
                                    runSpacing: 2.0,
                                    children: List<Widget>.generate(
                                        widget.details.tags.length, (int index) {
                                      return Chip(
                                        side: BorderSide(
                                          width: 1,
                                          color: AppColors.secondary,
                                        ),
                                        label: Text(widget.details.tags[index],
                                            style: textTheme.bodyMedium),
                                      );
                                    }),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "  Posted 2 days ago",
                                  style: TextStyle(color: AppColors.grey, height: 2),
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                                Text("Description", style: textTheme.headlineMedium),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                                  style: textTheme.bodyLarge!.copyWith(
                                    color: Colors.grey,
                                    height: 1.5,
                                  ),
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                                Text("Skills required",
                                    style: textTheme.headlineMedium),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "${bullet} B.Tech. or any other degree\n$bullet Desinglakdjsfklasj fi2o3iwkjloweafksjd\n$bullet a woeo28iqwaeksd89233fausodiweajkdsf",
                                  style: TextStyle(
                                      color: AppColors.secondary, height: 2),
                                ),

                                // ListView.builder(
                                //   itemCount: widget.details.tags.length,
                                //   shrinkWrap: true,
                                //   itemBuilder: (ctx, index) {
                                //     return Padding(
                                //       padding: const EdgeInsets.all(8.0),
                                //       child: Text(
                                //         bullet + " " + widget.details.tags[index],
                                //         style: TextStyle(color: AppColors.secondary),
                                //       ),
                                //     );
                                //   },
                                // )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Stack(
                          alignment: Alignment.center,
                          clipBehavior: Clip.none,
                          children:  [
                            CircleAvatar(
                              radius: 60,
                              backgroundColor: AppColors.greyDarker,
                            ),
                            CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.white,
                              backgroundImage: NetworkImage(
                                // width: constraints.maxWidth,
                                widget.details.companyPhoto,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.arrow_back,
                  // color: Theme.of(context).colorScheme.primary,
                  color: Colors.white30,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.primary,
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => VideoConferencing(
                  )));
        },
        isExtended: true,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        label: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Apply', style: textTheme.headlineMedium!),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // CurvedShape(),
    );
  }
}
