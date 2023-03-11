import 'package:connectify/pages/Search/search.dart';
import 'package:connectify/theme/typography.dart';
import 'package:flutter/material.dart';
// import 'package:connectify/widgets/curved_shape.dart';
import 'package:connectify/theme/app_colors.dart';
import 'package:connectify/theme/typography.dart';

class CompanyDetails extends StatefulWidget {
  CompCard details;
  CompanyDetails({super.key, required this.details});

  @override
  State<CompanyDetails> createState() => _CompanyDetailsState();
}

class _CompanyDetailsState extends State<CompanyDetails> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      //     child: Scaffold(
      //   // extendBodyBehindAppBar: true,
      //   body: SafeArea(
      //     top: false,
      //     bottom: false,
      //     child: Stack(
      //       children: [
      //         Container(
      //           decoration: const BoxDecoration(color: Colors.red),
      //           child: Image.network(
      //               'https://wallpapershome.com/images/pages/pic_v/11331.jpg'),
      //         ),
      //         Align(
      //           alignment: Alignment.bottomCenter,
      //           child: SingleChildScrollView(
      //             child: Container(
      //               width: MediaQuery.of(context).size.width,
      //               child: Padding(
      //                 padding: const EdgeInsets.all(20),
      //                 child: Column(
      //                   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                   crossAxisAlignment: CrossAxisAlignment.start,
      //                   children: [
      //                     Center(
      //                       child: Image.network(
      //                         height: 80,
      //                         width: 80,
      //                         // width: constraints.maxWidth,
      //                         fit: BoxFit.fitWidth,
      //                         widget.details.companyPhoto,
      //                       ),
      //                     ),
      //                     SizedBox(
      //                       height: 20,
      //                     ),
      //                     Center(
      //                       child: Text(
      //                         widget.details.title,
      //                         style: textTheme.headlineLarge,
      //                       ),
      //                     ),
      //                     SizedBox(
      //                       height: 40,
      //                     ),
      //                     Text("Description", style: textTheme.headlineMedium),
      //                     SizedBox(
      //                       height: 10,
      //                     ),
      //                     Text(
      //                       "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
      //                       style: textTheme.bodyLarge!.copyWith(
      //                         color: Colors.grey,
      //                         height: 1.5,
      //                       ),
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //             ),
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // )
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          // title: const Text("Back"),
          elevation: 0,
          leading: IconButton(
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
        backgroundColor: Color.fromARGB(255, 46, 46, 46),
        body: Container(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.network(
                    height: 80,
                    width: 80,
                    // width: constraints.maxWidth,
                    fit: BoxFit.fitWidth,
                    widget.details.companyPhoto,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        label: Container(
                          width: 90,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: Colors.black,
                                ),
                                Text(
                                  widget.details.location,
                                  style: TextStyle(color: Colors.black),
                                )
                              ],
                            ),
                          ),
                        ),
                        backgroundColor: Color.fromARGB(255, 160, 255, 164),
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        label: Container(
                          width: 90,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.work,
                                  color: Colors.black,
                                ),
                                Text(
                                  widget.details.experience,
                                  style: TextStyle(color: Colors.black),
                                )
                              ],
                            ),
                          ),
                        ),
                        backgroundColor: Color.fromARGB(255, 255, 156, 156),
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        label: Container(
                          width: 90,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.currency_rupee,
                                  color: Colors.black,
                                ),
                                Text(
                                  widget.details.pay,
                                  style: TextStyle(color: Colors.black),
                                )
                              ],
                            ),
                          ),
                        ),
                        backgroundColor: Color.fromARGB(255, 255, 243, 156),
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
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: AppColors.primary,
          onPressed: () {
            // Routemaster.of(context).push('/payment');
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
      ),
    );
  }
}
