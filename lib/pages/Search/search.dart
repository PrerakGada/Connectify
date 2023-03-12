import 'package:connectify/logic/state_management/user_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:provider/provider.dart';
import 'package:shake/shake.dart';
import '../../theme/app_colors.dart';
import '../../theme/typography.dart';
import '../../widgets/company_card.dart';
import '../../widgets/filters_dialog.dart';
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

class SearchScreen extends StatefulWidget {
  static const id = '/searchJob';
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

FlutterTts ftts = FlutterTts();

class _SearchScreenState extends State<SearchScreen> {
  ShakeDetector? detector;
  bool _shaking = false;
  TextEditingController editingController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    detector = ShakeDetector.autoStart(
      onPhoneShake: _onShake,
    );
    super.initState();
  }

  Future<void> _onShake() async {
    // Don't send the API request multiple times while the device is shaking
    // if (_shaking) {
    //   return;
    // }

    // setState(() {
    //   _shaking = true;
    // });
    await ftts.setLanguage('en-US');
    await ftts.setPitch(1.0);
    await ftts.setVolume(1.0);
    await ftts.speak(
        "I found 10 job related to ${editingController.text} near your area");

    // await UserStore().sendSOS(lat: 73.6277, long: 17.9639);
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        toolbarHeight: 86,
        flexibleSpace: Column(
          children: [
            SizedBox(height: 36),
            Container(
              height: 82,
              padding: EdgeInsets.all(16),
              // width: MediaQuery.of(context).size.width * 0.9,
              child: TextField(
                onChanged: (value) async {
                  editingController.text = value;
                  print("searching for $value");
                  await UserStore().searchJob(query: value);
                },
                autofocus: true,
                textAlignVertical: TextAlignVertical.bottom,
                style: const TextStyle(
                  // color: Colors.black,
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
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: screenHeight * 0.75,
                child: Scrollbar(
                  child: Consumer<UserStore>(builder: (_, userStore, __) {
                    final allResults = userStore.searchResults;

                    return (allResults.isEmpty)
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "No results found",
                                  style: TextStyle(
                                    fontSize: 40,
                                  ),
                                ),
                                Text(
                                  "Try searching for something else",
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : ListView.builder(
                            itemCount: allResults.length,
                            // children: <Widget>[
                            // for (Card card in allResults)
                            itemBuilder: (ctx, index) {
                              final result = allResults[index];
                              return CompanyCard(
                                details: result,
                                // company: allResults[index].company,
                                // companyPhoto: allResults[index].companyPhoto,
                                // experience: allResults[index].experience,
                                // location: allResults[index].location,
                                // title: allResults[index].title,
                                // description: allResults[index].description,
                                // tags: allResults[index].tags,
                                // pay: allResults[index].pay,
                              );
                            },
                            // ],
                          );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () {
          showGeneralDialog(
            //! select filter dialog box
            context: context,
            barrierDismissible: true,
            barrierLabel: "Choose filters",
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) {
              return Container();
            },
            transitionBuilder: (ctx, a1, a2, child) {
              var curve = Curves.easeInOut.transform(a1.value);
              return FiltersDialog(
                curve: curve,
              );
            },
            transitionDuration: const Duration(milliseconds: 300),
          );
        },
        tooltip: 'Increment',
        child: const Icon(
          Icons.filter_alt_outlined,
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
