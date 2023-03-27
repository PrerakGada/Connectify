import 'package:connectify/theme/palette.dart';
import 'package:connectify/theme/typography.dart';
import 'package:flutter/material.dart';

class FiltersDialog extends StatefulWidget {
  final double curve;
  // final reloadTodos;
  // bool tasksPage;
  // String timeType;

  FiltersDialog({
    Key? key,
    required this.curve,
    // required this.reloadTodos,
    // required this.tasksPage,
    // required this.timeType,
  }) : super(key: key);

  @override
  State<FiltersDialog> createState() => _FiltersDialogState();
}

class _FiltersDialogState extends State<FiltersDialog> {
  // LabelDAO labelsDB = GetIt.I.get();
  // SelectedFilters selectedFilters = GetIt.I.get();

  Map<String, bool> labelsSelectedVal = {};
  bool currentFirst = true;
  bool ascending = false;
  double turns = 0.0;
  List<String> list = <String>['3', '7', '15', '30'];
  @override
  void initState() {
    super.initState();
  }

  RangeValues salaryRangeValues = const RangeValues(40, 80);
  RangeValues workRangeValues = const RangeValues(0, 20);

  bool permanentSelected = true;
  bool workFromHomeSelected = true;
  bool freelanceSelected = true;

  bool three = true;
  bool seven = true;
  bool fifteen = true;
  bool thirty = true;
  String dropdownValue = "7";

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Transform.scale(
        scale: widget.curve,
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SimpleDialog(
                  contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 5),
                  titlePadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  title: Text("Select filters"),
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Salary",
                      style: textTheme.headlineMedium!
                          .copyWith(color: AppColors.greyLight),
                    ),
                    SliderTheme(
                      data: SliderThemeData(
                        trackHeight: 2.0,
                      ),
                      child: RangeSlider(
                        values: salaryRangeValues,
                        activeColor: AppColors.primary,
                        max: 100,
                        divisions: 5,
                        labels: RangeLabels(
                          salaryRangeValues.start.round().toString(),
                          salaryRangeValues.end.round().toString(),
                        ),
                        onChanged: (RangeValues values) {
                          setState(() {
                            salaryRangeValues = values;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Work Experience",
                      style: textTheme.headlineMedium!
                          .copyWith(color: AppColors.greyLight),
                    ),
                    SliderTheme(
                      data: SliderThemeData(
                        trackHeight: 2.0,
                      ),
                      child: RangeSlider(
                        values: workRangeValues,
                        max: 25,
                        divisions: 10,
                        activeColor: AppColors.primary,
                        labels: RangeLabels(
                          workRangeValues.start.round().toString(),
                          workRangeValues.end.round().toString(),
                        ),
                        onChanged: (RangeValues values) {
                          setState(() {
                            workRangeValues = values;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Job Type",
                      style: textTheme.headlineMedium!
                          .copyWith(color: AppColors.greyLight),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(children: [
                        FilterChip(
                          backgroundColor: AppColors.greyDark,
                          label: Text(
                            "Permanent Job",
                            style: TextStyle(color: Colors.white),
                          ),
                          selected: permanentSelected,
                          selectedColor: Colors.black,
                          onSelected: (bool selected) {
                            setState(() {
                              permanentSelected = !permanentSelected;
                              debugPrint(permanentSelected.toString());
                            });
                          },
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        FilterChip(
                          backgroundColor: AppColors.greyDark,
                          label: Text(
                            "Work from Home",
                            style: TextStyle(color: Colors.white),
                          ),
                          selected: workFromHomeSelected,
                          selectedColor: Colors.black,
                          onSelected: (bool selected) {
                            setState(() {
                              workFromHomeSelected = !workFromHomeSelected;
                            });
                          },
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        FilterChip(
                          backgroundColor: AppColors.greyDark,
                          label: Text(
                            "Freelance Jobs",
                            style: TextStyle(color: Colors.white),
                          ),
                          selected: freelanceSelected,
                          selectedColor: Colors.black,
                          onSelected: (bool selected) {
                            setState(() {
                              freelanceSelected = !freelanceSelected;
                            });
                          },
                        ),
                      ]),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Applications within",
                      style: textTheme.headlineMedium!
                          .copyWith(color: AppColors.greyLight),
                    ),
                    Row(
                      children: [
                        DropdownButton<String>(
                          value: dropdownValue,
                          style: textTheme.headlineMedium!
                              .copyWith(color: AppColors.greyLight),
                          elevation: 16,
                          onChanged: (String? value) {
                            setState(() {
                              dropdownValue = value!;
                            });
                          },
                          items: list
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                        Text(
                          "days",
                          style: textTheme.headlineMedium!
                              .copyWith(color: AppColors.greyLight),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
