import 'package:connectify/logic/state_management/user_store.dart';
import 'package:connectify/pages/Search/search.dart';
import 'package:connectify/theme/typography.dart';
import 'package:connectify/widgets/audio_input_screen.dart';
import 'package:flutter/material.dart';

// import 'package:connectify/widgets/curved_shape.dart';
import 'package:connectify/theme/palette.dart';
import 'package:connectify/pages/VideoConferencing/video_conferencing.dart';
import 'package:connectify/theme/typography.dart';

class CompanyDetails extends StatefulWidget {
  final details;

  CompanyDetails({super.key, required this.details});

  @override
  State<CompanyDetails> createState() => _CompanyDetailsState();
}

class _CompanyDetailsState extends State<CompanyDetails> {
  String bullet = "\u2022 ";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            child: Image.network(
              'https://innovative-minds.mustansirg.in/${widget.details['company_headquarters']}',
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
                  padding: const EdgeInsets.only(top: 170),
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 60),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: const BoxDecoration(
                            color: AppColors.black,
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                          ),
                          child: SafeArea(
                            child: Column(
                              children: [
                                const SizedBox(height: 20),
                                Text(
                                  widget.details['company_name'],
                                  style: TextStyle(fontSize: 36),
                                ),
                                // const SizedBox(height: 20),
                                Divider(thickness: 1),
                                Column(
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Job Title: ${widget.details['title']}",
                                      style: textTheme.headlineLarge,
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Chip(
                                            shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(15))),
                                            label: Row(
                                              children: [
                                                const Icon(
                                                  Icons.location_on,
                                                  color: AppColors.black,
                                                ),
                                                Text(
                                                  widget.details['address'],
                                                  style: const TextStyle(
                                                      color: AppColors.black),
                                                ),
                                              ],
                                            ),
                                            backgroundColor:
                                                const Color.fromARGB(
                                                    255, 160, 255, 164),
                                            elevation: 6.0,
                                            shadowColor: Colors.grey[60],
                                            padding: const EdgeInsets.all(2),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Chip(
                                            shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(15))),
                                            label: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                const Icon(
                                                  Icons.work,
                                                  color: AppColors.black,
                                                ),
                                                Text(
                                                  widget.details['experience'],
                                                  style: const TextStyle(
                                                      color: AppColors.black),
                                                )
                                              ],
                                            ),
                                            backgroundColor:
                                                const Color.fromARGB(
                                                    255, 255, 156, 156),
                                            // side: BorderSide(
                                            //   width: 1,
                                            //   color: Color.fromARGB(255, 73, 255, 82),
                                            // ),
                                            elevation: 6.0,
                                            shadowColor: Colors.grey[60],
                                            padding: const EdgeInsets.all(5),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Chip(
                                            shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(15),
                                              ),
                                            ),
                                            label: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                const Icon(
                                                  Icons.currency_rupee,
                                                  color: Colors.black,
                                                ),
                                                Text(
                                                  widget.details['payscale'],
                                                  style: const TextStyle(
                                                      color: AppColors.black),
                                                )
                                              ],
                                            ),
                                            backgroundColor:
                                                const Color.fromARGB(
                                                    255, 255, 243, 156),
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
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    // SingleChildScrollView(
                                    //   scrollDirection: Axis.horizontal,
                                    //   child: Wrap(
                                    //     spacing: 10.0,
                                    //     runSpacing: 2.0,
                                    //     children: List<Widget>.generate(
                                    //       widget.details.tags.length,
                                    //       (int index) {
                                    //         return Chip(
                                    //           side: const BorderSide(
                                    //             width: 1,
                                    //             color: AppColors.secondary,
                                    //           ),
                                    //           label: Text(
                                    //               widget.details.tags[index],
                                    //               style: textTheme.bodyMedium),
                                    //         );
                                    //       },
                                    //     ),
                                    //   ),
                                    // ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    const Text(
                                      "  Posted 2 days ago",
                                      style: TextStyle(
                                          color: AppColors.grey, height: 2),
                                    ),
                                    const SizedBox(
                                      height: 40,
                                    ),
                                    Text("Description",
                                        style: textTheme.headlineMedium),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      widget.details['description'],
                                      style: textTheme.bodyLarge!.copyWith(
                                        color: Colors.grey,
                                        height: 1.5,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 40,
                                    ),
                                    Text("Skills required",
                                        style: textTheme.headlineMedium),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "${bullet} B.Tech. or any other degree\n$bullet Desinglakdjsfklasj fi2o3iwkjloweafksjd\n$bullet a woeo28iqwaeksd89233fausodiweajkdsf",
                                      style: const TextStyle(
                                          color: AppColors.secondary,
                                          height: 2),
                                    ),
                                    SizedBox(height: 100),

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
                          children: [
                            const CircleAvatar(
                              radius: 60,
                              backgroundColor: AppColors.greyDarker,
                            ),
                            CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.white,
                              backgroundImage: NetworkImage(
                                // width: constraints.maxWidth,
                                "https://innovative-minds.mustansirg.in/${widget.details['company_logo']}",
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
          SafeArea(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Stack(
                children: [
                  Container(
                    // width: MediaQuery.of(context).size.width,
                    height: 80,
                    decoration: const BoxDecoration(
                      color: AppColors.secondary,
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, AppColors.black],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: 50,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Center(
                          child: InkWell(
                            onTap: () async {
                              // var applying = await UserStore()
                              //     .applyJob(userId: "1", jobId: "26");
                              // if (applying) {
                              //   ScaffoldMessenger.of(context)
                              //       .showSnackBar(const SnackBar(
                              //     content: Text('Succesfull'),
                              //   ));
                              // }
                              return showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10)),
                                  ),
                                  builder: (context) =>
                                      StatefulBuilder(builder: (BuildContext
                                              context,
                                          StateSetter
                                              setModalState /*You can rename this!*/) {
                                        return FractionallySizedBox(
                                          heightFactor: 0.6,
                                          child: AudioInputScreen(),
                                        );
                                      }));
                            },
                            child: Text(
                              'Apply',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   backgroundColor: AppColors.primary,
      //   onPressed: () {
      //     Navigator.of(context).push(MaterialPageRoute(
      //         builder: (context) => const VideoConferencing()));
      //   },
      //   isExtended: true,
      //   materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      //   label: SizedBox(
      //     width: MediaQuery.of(context).size.width * 0.8,
      //     child: Text('Apply', style: textTheme.headlineMedium!),
      //   ),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
