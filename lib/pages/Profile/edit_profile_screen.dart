import 'dart:io';

import 'package:connectify/pages/AudioVideo/video_recording_page.dart';
import 'package:connectify/pages/AudioVideo/video_playing_page.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class EditProfile extends StatefulWidget {
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
        child: Column(
          children: [
            link == null
                ? TextButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.red)),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VideoRecordingPage(
                            videoRecorded: (String location) {
                              setState(() {
                                _videoPlayerController =
                                    VideoPlayerController.file(File(location));
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
                  )
                : Row(children: [
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
    );
  }
}
