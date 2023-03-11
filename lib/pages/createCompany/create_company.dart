import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:connectify/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import 'package:provider/provider.dart';

class CreateBusinessScreen extends StatefulWidget {
  static const id = '/id';

  const CreateBusinessScreen(
      {super.key,
      this.businessName,
      this.update,
      this.addressId,
      this.contactDet,
      this.kitchenId});

  final Map<dynamic, dynamic>? businessName;
  final bool? update;

  final String? addressId;
  final List? contactDet;

  final String? kitchenId;

  @override
  State<CreateBusinessScreen> createState() => _CreateBusinessScreenState();
}

class _CreateBusinessScreenState extends State<CreateBusinessScreen> {
  File? cover;
  File? profile;
  List categories = [];
  var categoryId = '';
  var categoryTitle = '';
  var establishmentId = '';
  var establishmentTitle = '';
  var role = '';
  var roleId = '';
  String contactIdWhatsapp = "";
  bool loading = true;
  String contactIdMobile = "";
  String contactIdEmail = "";
  Map<dynamic, dynamic> profileData = {};

  // String contactIdPhone = "";
  final categoryController = TextEditingController();
  final roleController = TextEditingController();
  final establishmentController = TextEditingController();
  final businessNameController = TextEditingController();
  final businessDescController = TextEditingController();
  final mobileNumberController = TextEditingController();
  final emailAddressController = TextEditingController();
  final roomController = TextEditingController();
  final localityController = TextEditingController();
  final whatsappController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
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
      cover = File(tempImage.path);
    });
  }

  void onPickProfileButtonClicked() async {
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
      profile = File(tempImage.path);
    });
  }

  bool checkId() {
    if (categoryId == '') {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please Select the category first'),
      ));

      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            child: (cover != null)
                ? Image.file(
                    cover!.absolute,
                    width: double.infinity,
                    height: 220,
                    fit: BoxFit.fill,
                  )
                : InkWell(
                    onTap: () async {
                      onPickImageButtonClicked();
                    },
                    child: Image.network(
                      "https://www.deccanherald.com/sites/dh/files/article_images/2018/06/04/file70frsj22cw4i6zyeaed.jpg",
                      width: double.infinity,
                      height: 220,
                      fit: BoxFit.fill,
                    ),
                  ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 170),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 60),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: const BoxDecoration(
                          color: AppColors.black,
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
                        child: SafeArea(
                          child: Column(
                            children: [
                              const Text('Microsoft', style: TextStyle(fontSize: 36),),
                              const SizedBox(height: 20),
                              TextField(
                                controller: businessNameController,
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Enter Company Name',
                                    hintText: 'Enter Your Company Name'),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextField(
                                controller: businessDescController,
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Enter Description',
                                    hintText: 'Enter Your Description'),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextField(
                                readOnly: true,
                                controller: categoryController,
                                onTap: () {},
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  prefixIcon: Icon(Icons.search),
                                  labelText: 'Enter Category',
                                  hintText: 'Enter Your Category',
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextField(
                                controller: establishmentController,
                                readOnly: true,
                                onTap: () {
                                  var status = checkId();
                                },
                                // onChanged: (value) {},
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  prefixIcon: Icon(Icons.search),
                                  labelText: 'Enter Establishment',
                                  hintText:
                                      'Enter Your Establishment Type',
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextField(
                                controller: mobileNumberController,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  prefixIcon: Icon(Icons.phone),
                                  labelText: 'Enter Number',
                                  hintText: 'Enter Your Mobile Number',
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextField(
                                controller: whatsappController,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Enter Whatsapp Number',
                                  hintText: 'Whatsapp',
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextField(
                                controller: emailAddressController,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  prefixIcon: Icon(Icons.email),
                                  labelText: 'Enter Email',
                                  hintText: 'Enter Your Email',
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextField(
                                controller: roomController,
                                maxLines: 1,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Room/House No.',
                                  hintText: 'Enter Your Room/House No.',
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextField(
                                controller: localityController,
                                maxLines: 1,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Locality',
                                  hintText: 'Enter Your Locality',
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              if (widget.update == false)
                                TextField(
                                  readOnly: true,
                                  controller: roleController,
                                  onTap: () {
                                    // showDialog(
                                    //     context: context,
                                    //     builder: (context) =>
                                    //         getProfileRole(userdetails));
                                  },
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    prefixIcon: Icon(Icons.search),
                                    labelText: 'Enter Role',
                                    hintText: 'Enter Your Role',
                                  ),
                                ),
                              const SizedBox(
                                height: 80,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Stack(
                        alignment: Alignment.center,
                        clipBehavior: Clip.none,
                        children: [
                          const CircleAvatar(
                            radius: 60,
                            backgroundColor: AppColors.greyDarker,
                          ),
                          (profile != null)
                              ? CircleAvatar(
                                  radius: 55,
                                  backgroundColor: Colors.white,
                                  backgroundImage: FileImage(
                                    profile!.absolute,
                                  ),
                                )
                              : InkWell(
                                  onTap: () async {
                                    onPickProfileButtonClicked();
                                  },
                                  child: const CircleAvatar(
                                    radius: 50,
                                    backgroundColor: Colors.white,
                                    backgroundImage: AssetImage(
                                      "assets/user.png",
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
