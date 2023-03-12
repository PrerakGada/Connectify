import 'package:connectify/logic/state_management/user_store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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

class _SearchScreenState extends State<SearchScreen> {
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
                  print("searching for $value");
                  await UserStore().searchJob(query: value);
                },
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
                    return ListView.builder(
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
