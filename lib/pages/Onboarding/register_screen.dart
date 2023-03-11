import 'dart:convert';
import 'dart:io';

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
  // Text Editing Controllers
  final TextEditingController _nameController = TextEditingController(text: "");
  final TextEditingController _userNameController =
      TextEditingController(text: "");
  final TextEditingController _emailController =
      TextEditingController(text: "");
  final TextEditingController _passwordController =
      TextEditingController(text: "");
  final TextEditingController _confirmPasswordController =
      TextEditingController(text: "");
  final TextEditingController _mobileNumber = TextEditingController(text: "");
  // final TextEditingController _confirmPasswordController =
  // TextEditingController();

  File? file;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.4),
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
                height: 8,
              ),
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(color: Colors.black),
                child: Padding(
                  padding: const EdgeInsets.all(10),
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
                            text: 'Enter Username',
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
                        controller: _userNameController,
                        placeholderText: "Enter User Name",
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      RichText(
                        text: const TextSpan(
                            text: 'Email ID',
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
                        controller: _emailController,
                        placeholderText: "Enter Email ID",
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      RichText(
                        text: const TextSpan(
                            text: 'Password',
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
                        controller: _passwordController,
                        placeholderText: "Enter Password",
                        textinput: TextInputType.number,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      RichText(
                        text: const TextSpan(
                            text: ' Confirm Password',
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
                        controller: _confirmPasswordController,
                        textinput: TextInputType.number,
                        placeholderText: "Enter Confirm Password",
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
                        style: TextStyle(color: Colors.white),
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
                      InputField(
                        placeholderText: "Add the city you are living in",
                        condition: true,
                        onTap: () {},
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
                        controller: _emailController,
                        condition: true,
                        placeholderText: "Specify your total experience",
                        onTap: () {},
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
                      InputField(
                        controller: _emailController,
                        condition: true,
                        placeholderText: "Enter or select your key skills",
                        onTap: () {},
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
                      InputField(
                        controller: _emailController,
                        condition: true,
                        placeholderText: "Maximum 2 industries can be selected",
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
                      InputField(
                        controller: _confirmPasswordController,
                        condition: true,
                        placeholderText: "Maximum 2 functions can be selected",
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(color: Colors.black),
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
                height: 10,
              ),
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(color: Colors.black),
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
                          value: true,
                          onChanged: (value) {
                            // setState(() {
                            //   forSale = value;
                            //   _pagingController.refresh();
                            // });
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
                height: 10,
              ),
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(color: Colors.black),
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
                height: 10,
              ),
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(color: Colors.black),
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
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        const Color.fromARGB(255, 111, 0, 190)),
                              ),
                              child: const Text(
                                "Next: Verification >",
                                style: TextStyle(color: Colors.white),
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
