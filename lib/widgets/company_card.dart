import 'package:connectify/pages/Search/search.dart';
import 'package:connectify/theme/palette.dart';
import 'package:connectify/pages/CompanyDetails/companyDetails.dart';
import 'package:flutter/material.dart';
import '../../theme/typography.dart';
import 'package:delayed_display/delayed_display.dart';

class CompanyCard extends StatefulWidget {
  CompanyCard({
    super.key,
    required this.details,
  });

  final details;

  @override
  State<CompanyCard> createState() => _CompanyCardState();
}

class _CompanyCardState extends State<CompanyCard> {
  final List tags = ['Flutter', 'React', 'Node', 'Angular', 'Django'];

  @override
  Widget build(BuildContext context) {
    return DelayedDisplay(
      slidingBeginOffset: const Offset(0, 0.4),
      child: GestureDetector(
        onTap: () {
          // showModalBottomSheet(
          //     context: context,
          //     isScrollControlled: true,
          //     builder: (context) {
          //       return FractionallySizedBox(
          //         heightFactor: 1,
          //         child: CompanyDetails(details: widget.details),
          //       );
          //     });
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CompanyDetails(details: widget.details)),
          );
        },
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 6),
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            color: Color.fromARGB(255, 46, 46, 46),
            elevation: 2,
            child: Container(
              // padding: const EdgeInsets.all(8.0),
              // decoration: const BoxDecoration(
              //   borderRadius: BorderRadius.all(Radius.circular(40)),
              // ),
              width: MediaQuery.of(context).size.width * 0.85,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.details["title"],
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(
                                  'https://innovative-minds.mustansirg.in/' +
                                      widget.details['company_logo']
                                          .toString()),
                              radius: 14,
                            ),
                            SizedBox(width: 6),
                            Text(
                              widget.details['company_name'],
                              style: textTheme.headlineMedium!,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: Color.fromARGB(255, 160, 255, 164),
                            ),
                            Text(widget.details['address']),
                          ],
                        ),
                        // SizedBox(
                        //   width: 10,
                        // ),
                        Row(
                          children: [
                            Icon(
                              Icons.work,
                              color: Color.fromARGB(255, 255, 156, 156),
                            ),
                            Text(widget.details['experience']),
                          ],
                        ),
                        // SizedBox(
                        //   width: 7,
                        // ),
                        Row(
                          children: [
                            Icon(
                              Icons.currency_rupee,
                              color: Color.fromARGB(255, 255, 243, 156),
                            ),
                            Text(widget.details['payscale']),
                          ],
                        ),
                        // SizedBox(
                        //   width: 7,
                        // ),
                      ],
                    ),
                    SizedBox(height: 8),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Wrap(
                        spacing: 10.0,
                        runSpacing: 2.0,
                        children:
                            List<Widget>.generate(tags.length, (int index) {
                          return Chip(
                            side: BorderSide(
                              width: 1,
                              color: AppColors.secondary,
                            ),
                            label:
                                Text(tags[index], style: textTheme.bodyMedium),
                          );
                        }),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
