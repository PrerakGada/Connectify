import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/typography.dart';
import '../../widgets/company_card.dart';
import 'package:delayed_display/delayed_display.dart';

class CompCard {
  String title;
  String company;
  String experience;
  String location;
  String pay;
  String description;
  String companyPhoto;
  List<String> tags;

  CompCard(this.title, this.company, this.experience, this.pay, this.location,
      this.description, this.companyPhoto, this.tags);
}

List allCards = [
  CompCard(
    "Flutter dev",
    "Alphabet",
    "7-8 year",
    "10 lpa",
    "Mumbai",
    "Work on cutting edge tech with the best technologists out there",
    "https://cdn-icons-png.flaticon.com/512/281/281764.png",
    ["Android dev", "Flutter", "React native"],
  ),
  CompCard(
    "Flutter dev",
    "Alphabet",
    "7-8 year",
    "10 lpa",
    "Mumbai",
    "Work on cutting edge tech with the best technologists out there",
    "https://cdn-icons-png.flaticon.com/512/281/281764.png",
    ["Android dev", "Flutter"],
  ),
  CompCard(
    "Flutter dev",
    "Alphabet",
    "7-8 year",
    "10 lpa",
    "Mumbai",
    "Work on cutting edge tech with the best technologists out there",
    "https://cdn-icons-png.flaticon.com/512/281/281764.png",
    ["Android dev", "Flutter"],
  ),
  CompCard(
    "Flutter dev",
    "Alphabet",
    "7-8 year",
    "10 lpa",
    "Mumbai",
    "Work on cutting edge tech with the best technologists out there",
    "https://cdn-icons-png.flaticon.com/512/281/281764.png",
    ["Android dev", "Flutter"],
  ),
];

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.black,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 92,
                padding: EdgeInsets.all(16),
                // width: MediaQuery.of(context).size.width * 0.9,
                child: TextField(
                  autofocus: true,
                  textAlignVertical: TextAlignVertical.bottom,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    // fontFamily: 'EuclidCircular',
                    fontWeight: FontWeight.w400,
                  ),
                  decoration: InputDecoration(
                    labelText: "Search",
                    labelStyle: TextStyle(),
                    contentPadding: const EdgeInsets.all(25),
                    hintText: 'Search here',
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: AppColors.primary,
                        width: 2.5,
                      ),
                    ),
                    // prefixIcon: IconButton(
                    //   onPressed: () {
                    //     // Routemaster.of(context).pop();
                    //   },
                    //   icon: const Icon(Icons.arrow_back),
                    // ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: screenHeight * 0.73,
                  child: Scrollbar(
                    child: ListView.builder(
                      itemCount: allCards.length,
                      // children: <Widget>[
                      // for (Card card in allCards)
                      itemBuilder: (ctx, index) {
                        return CompanyCard(
                          details: allCards[index],
                          // company: allCards[index].company,
                          // companyPhoto: allCards[index].companyPhoto,
                          // experience: allCards[index].experience,
                          // location: allCards[index].location,
                          // title: allCards[index].title,
                          // description: allCards[index].description,
                          // tags: allCards[index].tags,
                          // pay: allCards[index].pay,
                        );
                      },
                      // ],
                    ),
                  ),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: SingleChildScrollView(
              //     child: Column(
              //       children: [
              //         CompanyCard(
              //           company: "Alphabet",
              //           experience: "7-8 year",
              //           location: "Mumbai",
              //           title: "Flutter dev",
              //           description:
              //               "Work on cutting edge tech with the best technologists out there",
              //           tags: ["Android dev", "Flutter"],
              //         ),
              //         CompanyCard(
              //           company: "Alphabet",
              //           experience: "7-8 year",
              //           location: "Mumbai",
              //           description:
              //               "Work on cutting edge tech with the best technologists out there",
              //           title: "Flutter dev",
              //           tags: ["Android dev", "Flutter"],
              //         ),
              //         CompanyCard(
              //           company: "Facebook",
              //           experience: "7-8 year",
              //           location: "Mumbai",
              //           title: "Flutter dev",
              //           description:
              //               "Work on cutting edge tech with the best technologists out there",
              //           tags: ["Android dev", "Flutter"],
              //         ),
              //         CompanyCard(
              //           company: "Alphabet",
              //           experience: "7-8 year",
              //           location: "Mumbai",
              //           title: "Flutter dev",
              //           description:
              //               "Work on cutting edge tech with the best technologists out there",
              //           tags: ["Android dev", "Flutter"],
              //         ),
              //       ],
              //     ),
              //   ),
              // )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.primary,
          onPressed: () {},
          tooltip: 'Increment',
          child: const Icon(
            Icons.filter_alt_outlined,
            // color: AppColors.secondary,
          ),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
