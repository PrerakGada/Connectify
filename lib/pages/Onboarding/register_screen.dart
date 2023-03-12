import 'dart:convert';
import 'dart:io';

import 'package:connectify/widgets/location_screen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../theme/app_colors.dart';
import '../../logic/state_management/user_store.dart';
import '../../widgets/LabeledTextFormField.dart';
import '../../widgets/input_field.dart';
import 'splash_screen.dart';
import 'package:http/http.dart' as http;

class RegisterScreen extends StatefulWidget {
  static const String id = '/register';

  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  File? demo;
  final List<String> _chips = [];
  final List<String> _skills = [];
  final List<String> _department = [];
  var exp = "";

  // Text Editing Controllers
  final TextEditingController _nameController = TextEditingController(text: "Dummy");
  final TextEditingController _userNameController =
      TextEditingController(text: "");
  final TextEditingController _emailController =
      TextEditingController(text: "");
  final TextEditingController _expController = TextEditingController(text: "");
  final TextEditingController _hiringController =
      TextEditingController(text: "");
  final TextEditingController _skillsController =
      TextEditingController(text: "");
  final TextEditingController _deptController = TextEditingController(text: "");
  final TextEditingController _passwordController =
      TextEditingController(text: "");
  final TextEditingController _confirmPasswordController =
      TextEditingController(text: "");

  final TextEditingController _mobileNumber = TextEditingController(text: "9821349823");
  late bool toggle = true;

  // final TextEditingController _confirmPasswordController =
  // TextEditingController();

  File? file;

  void _addChip(String text) {
    setState(() {
      _chips.add(text);
    });
  }

  void _removeChip(String text) {
    setState(() {
      _chips.remove(text);
    });
  }

  void _addChipSkills(String text) {
    setState(() {
      _skills.add(text);
    });
  }

  void _removeChipSkills(String text) {
    setState(() {
      _skills.remove(text);
    });
  }

  void _addChipDepartment(String text) {
    setState(() {
      _department.add(text);
    });
  }

  void _removeChipDepartment(String text) {
    setState(() {
      _department.remove(text);
    });
  }

  void onPickImageButtonClicked() async {
    final tempImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (tempImage == null) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('An error occurred. Failed to pick image!'),
      ));
      return;
    }

    setState(() {
      demo = File(tempImage.path);
    });
  }

  void onPickFileButtonClicked() async {
    FilePickerResult? tempImage = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (tempImage == null) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('An error occurred. Failed to pick image!'),
      ));
      return;
    }

    setState(() {
      file = File(tempImage.files.single.path!);
    });
  }

  showAlertDialog(BuildContext context) {
    // Create button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Select Experience"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            // width: 200,
            // height: 50,
            decoration: BoxDecoration(
                color: Colors.black, borderRadius: BorderRadius.circular(15)),
            child: InkWell(
              onTap: () {
                setState(() {
                  _expController.text = "Fresher";
                  Navigator.of(context).pop();
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text("Fresher"),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              setState(() {
                _expController.text = "Experienced";
                Navigator.of(context).pop();
              });
            },
            child: Container(
              // width: 200,
              // height: 50,
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text("Experienced"),
              ),
            ),
          )
        ],
      ),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey.withOpacity(0.4),
      appBar: AppBar(
        backgroundColor: AppColors.black,
        elevation: 1,
        title: Text(
          "Create your Account",
          style: TextStyle(color: AppColors.white),
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 0,
              ),
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(color: AppColors.black),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: const TextSpan(
                            text: 'Full Name',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                            children: [
                              TextSpan(
                                  text: ' *',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12))
                            ]),
                        textScaleFactor: 1,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      InputField(

                        controller: _nameController,
                        placeholderText: "Enter Full Name",
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      RichText(
                        text: const TextSpan(
                            text: 'Mobile Number',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                            children: [
                              TextSpan(
                                  text: ' *',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12))
                            ]),
                        textScaleFactor: 1,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      InputField(
                        controller: _mobileNumber,
                        prefix: true,
                        placeholderText: "Enter Mobile Number",
                        textinput: TextInputType.number,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        "Recruiters will contact you on this number",
                        style: TextStyle(color: AppColors.greyDark),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      RichText(
                        text: const TextSpan(
                            text: 'Current  Location',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                            children: [
                              TextSpan(
                                  text: ' *',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12))
                            ]),
                        textScaleFactor: 1,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.greyDark),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: LocationScreen(),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      RichText(
                        text: const TextSpan(
                            text: 'Total Experience',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                            children: [
                              TextSpan(
                                  text: ' *',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12))
                            ]),
                        textScaleFactor: 1,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      InputField(
                        controller: _expController,
                        // exp: false,
                        placeholderText: "Specify your total experience",
                        onTap: () {
                          showAlertDialog(context);
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      RichText(
                        text: const TextSpan(
                            text: 'Key Skills',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                            children: [
                              TextSpan(
                                  text: ' *',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12))
                            ]),
                        textScaleFactor: 1,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        controller: _skillsController,
                        decoration: InputDecoration(
                          hintText:
                              _skills.isNotEmpty ? "" : 'Enter your skills',
                          // labelText: "Enter hiring manager",
                          suffixIcon: IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () {
                              String text = _skillsController.text.trim();
                              if (text.isNotEmpty) {
                                _addChipSkills(text);
                                _skillsController.clear();
                              }
                            },
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 8.0),
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
                          prefixIcon: _skills.isNotEmpty
                              ? Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: Wrap(
                                    spacing: 8.0,
                                    runSpacing: 4.0,
                                    children: _skills.map((chipText) {
                                      return Chip(
                                        label: Text(chipText),
                                        onDeleted: () =>
                                            _removeChipSkills(chipText),
                                      );
                                    }).toList(),
                                  ),
                                )
                              : null,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      RichText(
                        text: const TextSpan(
                            text: 'Preferred Industry',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                            children: [
                              TextSpan(
                                  text: ' *',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12))
                            ]),
                        textScaleFactor: 1,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        controller: _hiringController,
                        decoration: InputDecoration(
                          hintText:
                              _chips.isNotEmpty ? "" : 'Enter hiring manager',
                          // labelText: "Enter hiring manager",
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
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 16.0),
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
                          prefixIcon: _chips.isNotEmpty
                              ? Padding(
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
                                )
                              : null,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      RichText(
                        text: const TextSpan(
                            text: 'Preferred Department/Function',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                            children: [
                              TextSpan(
                                  text: ' *',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12))
                            ]),
                        textScaleFactor: 1,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        controller: _deptController,
                        decoration: InputDecoration(
                          hintText: _department.isNotEmpty
                              ? ""
                              : 'Maximum two functions can be selected',
                          // labelText: "Enter hiring manager",
                          suffixIcon: IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () {
                              String text = _deptController.text.trim();
                              if (text.isNotEmpty) {
                                _addChipDepartment(text);
                                _deptController.clear();
                              }
                            },
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 8.0),
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
                          prefixIcon: _department.isNotEmpty
                              ? Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: Wrap(
                                    spacing: 8.0,
                                    runSpacing: 4.0,
                                    children: _department.map((chipText) {
                                      return Chip(
                                        label: Text(chipText),
                                        onDeleted: () =>
                                            _removeChipDepartment(chipText),
                                      );
                                    }).toList(),
                                  ),
                                )
                              : null,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 0,
              ),
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(color: AppColors.black),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          width: 300,
                          height: 60,
                          child: ElevatedButton.icon(
                              onPressed: () async {
                                // onPickImageButtonClicked();
                                onPickFileButtonClicked();
                              },
                              icon: file != null
                                  ? const Icon(
                                      Icons.done,
                                      color: Colors.purple,
                                    )
                                  : const Icon(
                                      Icons.upload,
                                      color: Colors.purple,
                                    ),
                              style: ButtonStyle(
                                elevation: MaterialStateProperty.all(0),
                                backgroundColor: MaterialStateProperty.all<
                                        Color>(
                                    const Color.fromARGB(255, 243, 229, 254)),
                              ),
                              label: Text(
                                file != null ? "Uploaded" : "Upload Resume",
                                style: TextStyle(color: Colors.purple),
                              )),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Doc, PDF(Max file size- 6MB)",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Profiles with resumes are 3x more likely to be\nnoticed by recruiters.",
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 0,
              ),
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(color: AppColors.black),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Switch.adaptive(
                          thumbColor: MaterialStateProperty.all(Colors.purple),
                          activeTrackColor:
                              Colors.purpleAccent.withOpacity(0.6),
                          inactiveTrackColor: Colors.grey,
                          inactiveThumbColor: Colors.grey,
                          value: toggle,
                          onChanged: (value) {
                            setState(() {
                              toggle = value;
                            });
                          }),
                      const Text("I want to receive updates on "),
                      Image.asset(
                        "assets/whatsapp.png",
                        height: 20,
                        width: 20,
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      const Text("whatsapp")
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 0,
              ),
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(color: AppColors.black),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                          "By Registering, you agree to our Terms and Conditions,\nPrivacy Policy and default mailer and communictions\nsettings governing the use of connectify.in"),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 0,
              ),
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(color: AppColors.black),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          width: 300,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () async {
                              final status = await UserStore().register(
                                  email: _emailController.text,
                                  lat: 46.22,
                                  lon: 34.22,
                                  macId: "2344554",
                                  password1: _passwordController.text,
                                  password2: _confirmPasswordController.text,
                                  resume: file,
                                  preferredDepartment: "It/Software",
                                  domainPreference: "Software Developement",
                                  username: "Sid@31");
                              if (status) {
                                print("done");
                                Navigator.popAndPushNamed(
                                    context, SplashScreen.id);
                              }
                              Navigator.popAndPushNamed(
                                  context, SplashScreen.id);
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
                              "Next: Verification >",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
