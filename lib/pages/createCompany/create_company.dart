import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
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
  Map<dynamic, dynamic> profiledata = {};
  // String contactIdPhone = "";
  final categorycontroller = TextEditingController();
  final roleController = TextEditingController();
  final establishmentcontroller = TextEditingController();
  final businessNamecontroller = TextEditingController();
  final businessDesccontroller = TextEditingController();
  final mobileNumbercontroller = TextEditingController();
  final emailAddresscontroller = TextEditingController();
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
    return SafeArea(
      child: Scaffold(
          body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 50),
            child: Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                if (cover != null)
                  Image.file(
                    cover!.absolute,
                    width: double.infinity,
                    height: 220,
                    fit: BoxFit.fill,
                  ),
                if (cover == null)
                  InkWell(
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
                if (cover == null)
                  // InkWell(
                  //   onTap: () {
                  //     onPickImageButtonClicked();
                  //   },
                  //   child: Image.network(
                  //     widget.businessName!["media"]["mediaList"].length >= 1
                  //         ? "${widget.businessName!["media"]["mediaList"][0]["mediaUrls"][0]}"
                  //         : "https://as1.ftcdn.net/v2/jpg/03/57/21/96/1000_F_357219656_729YVCFiuzUTicH8m1ESxfEGELbQhUHe.jpg",
                  //     width: double.infinity,
                  //     height: 220,
                  //     fit: BoxFit.fitWidth,
                  //   ),
                  // ),
                  if (cover != null)
                    Image.file(
                      cover!.absolute,
                      width: double.infinity,
                      height: 220,
                      fit: BoxFit.fill,
                    ),
                Positioned(
                  bottom: -51,
                  child: CircleAvatar(
                    radius: 57,
                    backgroundColor: Colors.black,
                  ),
                ),
                if (profile != null)
                  Positioned(
                      bottom: -49,
                      child: CircleAvatar(
                        radius: 55,
                        backgroundColor: Colors.white,
                        backgroundImage: FileImage(
                          profile!.absolute,
                        ),
                      )),
                if (profile == null)
                  Positioned(
                      bottom: -49,
                      child: InkWell(
                        onTap: () async {
                          onPickProfileButtonClicked();
                        },
                        child: CircleAvatar(
                          radius: 55,
                          backgroundColor: Colors.white,
                          backgroundImage: AssetImage(
                            "assets/profile.png",
                          ),
                        ),
                      )),
                if (profile == null)
                  // Positioned(
                  //     bottom: -49,
                  //     child: InkWell(
                  //       onTap: () async {
                  //         // onPickProfileButtonClicked();
                  //       },
                  //       child: CircleAvatar(
                  //         radius: 55,
                  //         backgroundColor: Colors.white,
                  //         backgroundImage: NetworkImage(
                  //           widget.businessName!["media"]["mediaList"]
                  //                       .length >=
                  //                   2
                  //               ? "${widget.businessName!["media"]["mediaList"][1]["mediaUrls"][0]}"
                  //               : "https://as1.ftcdn.net/v2/jpg/03/57/21/96/1000_F_357219656_729YVCFiuzUTicH8m1ESxfEGELbQhUHe.jpg",
                  //         ),
                  //       ),
                  //     )),

                  if (profile != null)
                    Positioned(
                        bottom: -49,
                        child: CircleAvatar(
                          radius: 55,
                          backgroundColor: Colors.white,
                          backgroundImage: FileImage(
                            profile!.absolute,
                          ),
                        )),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: businessNamecontroller,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter Company Name',
                      hintText: 'Enter Your Company Name'),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: businessDesccontroller,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter Description',
                      hintText: 'Enter Your Description'),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  readOnly: true,
                  controller: categorycontroller,
                  onTap: () {},
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.search),
                    labelText: 'Enter Category',
                    hintText: 'Enter Your Category',
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: establishmentcontroller,
                  readOnly: true,
                  onTap: () {
                    var status = checkId();
                  },
                  // onChanged: (value) {},
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.search),
                    labelText: 'Enter Establishment',
                    hintText: 'Enter Your Establishment Type',
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: mobileNumbercontroller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.phone),
                    labelText: 'Enter Number',
                    hintText: 'Enter Your Mobile Number',
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: whatsappController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter Whatsapp Number',
                    hintText: 'Whatsapp',
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: emailAddresscontroller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
                    labelText: 'Enter Email',
                    hintText: 'Enter Your Email',
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: roomController,
                  maxLines: 1,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Room/House No.',
                    hintText: 'Enter Your Room/House No.',
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: localityController,
                  maxLines: 1,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Locality',
                    hintText: 'Enter Your Locality',
                  ),
                ),
                SizedBox(
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
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.search),
                      labelText: 'Enter Role',
                      hintText: 'Enter Your Role',
                    ),
                  ),
                SizedBox(
                  height: 80,
                ),
              ],
            ),
          )
        ],
      )),
    );
  }
}
