import 'dart:io';

import 'package:connectify/pages/AudioVideo/video_recording_page.dart';
import 'package:connectify/pages/AudioVideo/video_playing_page.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:file_picker/file_picker.dart';

class EditProfile extends StatefulWidget {
  static const String id = '/edit_profile';

  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String? link;
  VideoPlayerController? _videoPlayerController;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    if (link != null) {
      // VideoPlayerController _videoPlayerController =
      //     VideoPlayerController.file(File(link!));
    }
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("video location $link");
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              link == null
                  ? Column(
                      children: [
                        TextButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.red)),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => VideoRecordingPage(
                                  videoRecorded: (String location) {
                                    setState(() {
                                      _videoPlayerController =
                                          VideoPlayerController.file(
                                              File(location));
                                      _initializeVideoPlayerFuture =
                                          _videoPlayerController!.initialize();
                                      link = location;
                                      debugPrint(link);
                                    });
                                  },
                                ),
                              ),
                            );
                          },
                          child: Text(
                            "Add Video Resume",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        TextButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.red)),
                          onPressed: () async {
                            FilePickerResult? result = await FilePicker.platform
                                .pickFiles(
                                    type: FileType.custom,
                                    allowedExtensions: ['mp4']);
                            PlatformFile file1 = result!.files.first;
                            debugPrint("this is file $file1");

                            setState(() {
                              _videoPlayerController =
                                  VideoPlayerController.file(File(file1.path!));
                              _initializeVideoPlayerFuture =
                                  _videoPlayerController!.initialize();
                              link = file1.path;
                              debugPrint(link);
                            });
                          },
                          child: Text(
                            "Choose video",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    )
                  : Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      InkWell(
                        child: Text("your_video_resume.mp4"),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VideoPlayingPage(
                                videoPlayerController: _videoPlayerController,
                                initializeVideoPlayerFuture:
                                    _initializeVideoPlayerFuture,
                              ),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _videoPlayerController = null;
                            // _initializeVideoPlayerFuture =
                            //     _videoPlayerController!.initialize();
                            link = null;
                          });
                        },
                        icon: Icon(Icons.delete),
                      )
                    ]),
            ],
          ),
        ),
      ),
    );
  }
}
