import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayingPage extends StatefulWidget {
  VideoPlayerController? videoPlayerController;
  Future<void> initializeVideoPlayerFuture;
  VideoPlayingPage({
    super.key,
    required this.videoPlayerController,
    required this.initializeVideoPlayerFuture,
  });

  @override
  State<VideoPlayingPage> createState() => _VideoPlayingPageState();
}

class _VideoPlayingPageState extends State<VideoPlayingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            // If the video is playing, pause it.
            if (widget.videoPlayerController!.value.isPlaying) {
              widget.videoPlayerController!.pause();
            } else {
              // If the video is paused, play it.
              widget.videoPlayerController!.play();
            }
          });
        },
        // Display the correct icon depending on the state of the player.
        child: Icon(
          widget.videoPlayerController!.value.isPlaying
              ? Icons.pause
              : Icons.play_arrow,
        ),
      ),
      body: FutureBuilder(
        future: widget.initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the VideoPlayerController has finished initialization, use
            // the data it provides to limit the aspect ratio of the video.
            return AspectRatio(
              aspectRatio: widget.videoPlayerController!.value.aspectRatio,
              // Use the VideoPlayer widget to display the video.
              child: VideoPlayer(widget.videoPlayerController!),
            );
          } else {
            // If the VideoPlayerController is still initializing, show a
            // loading spinner.
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
