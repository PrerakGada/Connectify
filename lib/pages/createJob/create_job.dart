import 'package:connectify/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

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
                Row(
                  children: [
                    Icon(Icons.photo_sharp),
                    Text(
                      "Add Header Image",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
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
                  placeholderText: "Enter Recruitement Period",
                  date: true,
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Expected Salary",
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(
                  height: 8,
                ),
                InputField(
                  controller: _jobTitle,
                  placeholderText: "Enter amount",
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Experience in Years",
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
