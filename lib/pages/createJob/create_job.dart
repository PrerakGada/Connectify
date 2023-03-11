import 'package:connectify/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../logic/state_management/user_store.dart';

class CreateJob extends StatefulWidget {
  static const id = '/createJob';
  const CreateJob({super.key});

  @override
  State<CreateJob> createState() => _CreateJobState();
}

class _CreateJobState extends State<CreateJob> {
  final TextEditingController _jobTitle = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final List<String> _chips = [];
  final List<String> _skills = [];
  final TextEditingController _textEditingController = TextEditingController();
  final TextEditingController _hiringController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  void _addChip(String text) {
    setState(() {
      _chips.add(text);
    });
  }

  void _addChipSkills(String text) {
    setState(() {
      _skills.add(text);
    });
  }

  void _removeChip(String text) {
    setState(() {
      _chips.remove(text);
    });
  }

  void _removeChipSkills(String text) {
    setState(() {
      _skills.remove(text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Job Details",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Job Title",
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(
                  height: 8,
                ),
                InputField(
                  controller: _jobTitle,
                  placeholderText: "Enter Job Title",
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Department",
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(
                  height: 8,
                ),
                InputField(
                  controller: _jobTitle,
                  placeholderText: "Enter Department",
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Job Type",
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(
                  height: 8,
                ),
                InputField(
                  controller: _jobTitle,
                  placeholderText: "Job Type",
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Recruitement Quota",
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(
                  height: 8,
                ),
                InputField(
                  controller: _jobTitle,
                  placeholderText: "Enter Recruitement Quota",
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Recruitement Period",
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(
                  height: 8,
                ),
                InputField(
                  controller: _jobTitle,
                  onTap: () async {
                    print("wait");
                    final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: selectedDate,
                        firstDate: DateTime(2015, 8),
                        lastDate: DateTime(2101));
                    if (picked != null && picked != selectedDate) {
                      setState(() {
                        selectedDate = picked;
                      });
                    }
                  },
                  placeholderText: selectedDate.toString().split(' ')[0],
                  date: true,
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  "Expected Salary",
                  style: TextStyle(color: Colors.white),
                ),
                const SizedBox(
                  height: 8,
                ),
                InputField(
                  controller: _jobTitle,
                  placeholderText: "Enter amount",
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  "Experience in Years",
                  style: TextStyle(color: Colors.white),
                ),
                const SizedBox(
                  height: 8,
                ),
                InputField(
                  controller: _jobTitle,
                  placeholderText: "Enter experience",
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Location",
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(
                  height: 8,
                ),
                InputField(
                  controller: _jobTitle,
                  placeholderText: "Enter location",
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Hiring Manager",
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: _hiringController,
                  decoration: InputDecoration(
                    labelText: "Enter hiring manager",
                    suffixIcon: IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        String text = _hiringController.text.trim();
                        if (text.isNotEmpty) {
                          _addChip(text);
                          _hiringController.clear();
                        }
                      },
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(
                        color: Colors.grey[400]!,
                        width: 1.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(
                        color: Colors.blue,
                        width: 1.0,
                      ),
                    ),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Wrap(
                        spacing: 8.0,
                        runSpacing: 4.0,
                        children: _chips.map((chipText) {
                          return Chip(
                            label: Text(chipText),
                            onDeleted: () => _removeChip(chipText),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Skill Sets",
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: _textEditingController,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        String text = _textEditingController.text.trim();
                        if (text.isNotEmpty) {
                          _addChipSkills(text);
                          _textEditingController.clear();
                        }
                      },
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(
                        color: Colors.grey[400]!,
                        width: 1.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(
                        color: Colors.blue,
                        width: 1.0,
                      ),
                    ),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Wrap(
                        spacing: 8.0,
                        runSpacing: 4.0,
                        children: _skills.map((chipText) {
                          return Chip(
                            label: Text(chipText),
                            onDeleted: () => _removeChipSkills(chipText),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: 300,
                    height: 50,
                    child: ElevatedButton(
                        onPressed: () async {
                          final status = await UserStore().createJob(
                              companyId: 1,
                              address: "hi",
                              description: "bye",
                              domain: "Video Editing",
                              duration: "2 years",
                              emotional_requirements: "work-life balance",
                              experience: "2 years",
                              lat: 20.55,
                              lon: 56.33,
                              payscale: "34",
                              title: "ui ux",
                              sponsored: "true",
                              skills: "Final cut pro",
                              timings: "9-5",
                              worklife_culture: "gender-neutral");
                          if (status) {
                            print("done");
                            // Navigator.popAndPushNamed(context, SplashScreen.id);
                          }
                          // print("pressed");
                          // if (demo != null) {
                          //   var request = http.MultipartRequest(
                          //       'POST',
                          //       Uri.parse(
                          //           'https://innovative-minds.mustansirg.in/api/companies/'));

                          //   request.files.add(
                          //       await http.MultipartFile.fromPath(
                          //           'headquarters', demo!.path));
                          //   request.files.add(
                          //       await http.MultipartFile.fromPath(
                          //           'logo', demo!.path));
                          //   request.fields.addAll(
                          //       {'name': 'Amazon', 'admins': '1'});
                          //   var response = await request.send();
                          //   await http.Response.fromStream(response)
                          //       .then((value) {
                          //     var body = jsonDecode(value.body);
                          //   });
                          // }
                        },
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all(0),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color.fromARGB(255, 111, 0, 190)),
                        ),
                        child: const Text(
                          "Create Job",
                          style: TextStyle(color: Colors.white),
                        )),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
