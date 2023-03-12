import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/services.dart';

import 'package:path_provider/path_provider.dart';
import 'package:file_picker/file_picker.dart';

class AudioRecordingPage extends StatefulWidget {
  static const String id = "/audio_recording_page";

  const AudioRecordingPage({Key? key}) : super(key: key);

  @override
  State<AudioRecordingPage> createState() => _AudioRecordingPageState();
}

class _AudioRecordingPageState extends State<AudioRecordingPage> {
  late final RecorderController recorderController;

  String? path;
  String? musicFile;
  bool isRecording = false;
  bool isRecordingCompleted = false;
  bool isLoading = true;
  late Directory appDirectory;

  @override
  void initState() {
    super.initState();
    _getDir();
    _initialiseControllers();
  }

  void _getDir() async {
    appDirectory = await getApplicationDocumentsDirectory();
    path = "${appDirectory.path}/recording.m4a";
    isLoading = false;
    setState(() {});
  }

  void _initialiseControllers() {
    recorderController = RecorderController()
      ..androidEncoder = AndroidEncoder.aac
      ..androidOutputFormat = AndroidOutputFormat.mpeg4
      ..iosEncoder = IosEncoder.kAudioFormatMPEG4AAC
      ..sampleRate = 44100;
  }

  // void _pickFile() async {
  //   FilePickerResult? result = await FilePicker.platform.pickFiles();
  //   if (result != null) {
  //     musicFile = result.files.single.path;
  //     setState(() {});
  //   } else {
  //     debugPrint("File not picked");
  //   }
  // }

  @override
  void dispose() {
    recorderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color(0xFF252331),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: Column(
                children: [
                  const SizedBox(height: 20),

                  // IconButton(
                  //   onPressed: _pickFile,
                  //   icon: Icon(Icons.adaptive.share),
                  //   color: Colors.white54,
                  // ),

                  IconButton(
                    onPressed: _startOrStopRecording,
                    icon: Icon(isRecording ? Icons.stop : Icons.mic),
                    color: Colors.white,
                    iconSize: 28,
                  ),
                  isRecording
                      ? AudioWaveforms(
                          enableGesture: true,
                          size: Size(MediaQuery.of(context).size.width / 2, 50),
                          recorderController: recorderController,
                          waveStyle: const WaveStyle(
                            waveColor: Colors.white,
                            extendWaveform: true,
                            showMiddleLine: false,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            color: const Color(0xFF1E1B26),
                          ),
                          padding: const EdgeInsets.only(left: 18),
                          margin: const EdgeInsets.symmetric(horizontal: 15),
                        )
                      : Container(),
                  if (isRecordingCompleted)
                    WaveBubble(
                      path: path,
                      isSender: true,
                      appDirectory: appDirectory,
                    ),
                  // if (musicFile != null)
                  //   WaveBubble(
                  //     path: musicFile,
                  //     isSender: true,
                  //     appDirectory: appDirectory,
                  //   ),
                  //       SafeArea(
                  //         child: Row(
                  //           children: [
                  //             AnimatedSwitcher(
                  //               duration: const Duration(milliseconds: 200),
                  //               child: isRecording
                  //                   ? AudioWaveforms(
                  //                       enableGesture: true,
                  //                       size: Size(
                  //                           MediaQuery.of(context).size.width / 2,
                  //                           50),
                  //                       recorderController: recorderController,
                  //                       waveStyle: const WaveStyle(
                  //                         waveColor: Colors.white,
                  //                         extendWaveform: true,
                  //                         showMiddleLine: false,
                  //                       ),
                  //                       decoration: BoxDecoration(
                  //                         borderRadius: BorderRadius.circular(12.0),
                  //                         color: const Color(0xFF1E1B26),
                  //                       ),
                  //                       padding: const EdgeInsets.only(left: 18),
                  //                       margin: const EdgeInsets.symmetric(
                  //                           horizontal: 15),
                  //                     )
                  //                   : Container(
                  //                       width:
                  //                           MediaQuery.of(context).size.width / 1.7,
                  //                       height: 50,
                  //                       decoration: BoxDecoration(
                  //                         color: const Color(0xFF1E1B26),
                  //                         borderRadius: BorderRadius.circular(12.0),
                  //                       ),
                  //                       padding: const EdgeInsets.only(left: 18),
                  //                       margin: const EdgeInsets.symmetric(
                  //                           horizontal: 15),
                  //                       child: TextField(
                  //                         readOnly: true,
                  //                         decoration: InputDecoration(
                  //                           hintText: "Type Something...",
                  //                           hintStyle: const TextStyle(
                  //                               color: Colors.white54),
                  //                           contentPadding:
                  //                               const EdgeInsets.only(top: 16),
                  //                           border: InputBorder.none,
                  //                           suffixIcon: IconButton(
                  //                             onPressed: _pickFile,
                  //                             icon: Icon(Icons.adaptive.share),
                  //                             color: Colors.white54,
                  //                           ),
                  //                         ),
                  //                       ),
                  //                     ),
                  //             ),
                  //             IconButton(
                  //               onPressed: _refreshWave,
                  //               icon: Icon(
                  //                 isRecording ? Icons.refresh : Icons.send,
                  //                 color: Colors.white,
                  //               ),
                  //             ),
                  //             const SizedBox(width: 16),
                  //             IconButton(
                  //               onPressed: _startOrStopRecording,
                  //               icon: Icon(isRecording ? Icons.stop : Icons.mic),
                  //               color: Colors.white,
                  //               iconSize: 28,
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                ],
              ),
            ),
    );
  }

  void _startOrStopRecording() async {
    try {
      if (isRecording) {
        recorderController.reset();

        final path = await recorderController.stop(false);

        if (path != null) {
          isRecordingCompleted = true;
          debugPrint("recorded file path :$path");
          debugPrint("Recorded file size: ${File(path).lengthSync()}");
        }
      } else {
        await recorderController.record(path: path!);
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        isRecording = !isRecording;
      });
    }
  }

  void _refreshWave() {
    if (isRecording) recorderController.refresh();
  }
}

class WaveBubble extends StatefulWidget {
  final bool isSender;
  final int? index;
  final String? path;
  final double? width;
  final Directory appDirectory;

  const WaveBubble({
    Key? key,
    required this.appDirectory,
    this.width,
    this.index,
    this.isSender = false,
    this.path,
  }) : super(key: key);

  @override
  State<WaveBubble> createState() => _WaveBubbleState();
}

class _WaveBubbleState extends State<WaveBubble> {
  File? file;

  late PlayerController controller;
  late StreamSubscription<PlayerState> playerStateSubscription;

  final playerWaveStyle = const PlayerWaveStyle(
    fixedWaveColor: Colors.white54,
    liveWaveColor: Colors.white,
    spacing: 6,
  );

  @override
  void initState() {
    super.initState();
    controller = PlayerController();
    _preparePlayer();
    playerStateSubscription = controller.onPlayerStateChanged.listen((_) {
      setState(() {});
    });
  }

  void _preparePlayer() async {
    if (widget.index == null && widget.path == null && file?.path == null) {
      return;
    }
    // Prepare player with extracting waveform if index is even.
    controller.preparePlayer(
      path: widget.path ?? file!.path,
      shouldExtractWaveform: widget.index?.isEven ?? true,
    );
    // Extracting waveform separately if index is odd.
    if (widget.index?.isOdd ?? false) {
      controller
          .extractWaveformData(
            path: widget.path ?? file!.path,
            noOfSamples:
                playerWaveStyle.getSamplesForWidth(widget.width ?? 200),
          )
          .then((waveformData) => debugPrint(waveformData.toString()));
    }
  }

  @override
  void dispose() {
    playerStateSubscription.cancel();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.path != null || file?.path != null
        ? Align(
            alignment:
                widget.isSender ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              padding: EdgeInsets.only(
                bottom: 6,
                right: widget.isSender ? 0 : 10,
                top: 6,
              ),
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: widget.isSender
                    ? const Color(0xFF276bfd)
                    : const Color(0xFF343145),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!controller.playerState.isStopped)
                    IconButton(
                      onPressed: () async {
                        controller.playerState.isPlaying
                            ? await controller.pausePlayer()
                            : await controller.startPlayer(
                                finishMode: FinishMode.loop,
                              );
                      },
                      icon: Icon(
                        controller.playerState.isPlaying
                            ? Icons.stop
                            : Icons.play_arrow,
                      ),
                      color: Colors.white,
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                    ),
                  AudioFileWaveforms(
                    size: Size(MediaQuery.of(context).size.width / 2, 70),
                    playerController: controller,
                    waveformType: widget.index?.isOdd ?? false
                        ? WaveformType.fitWidth
                        : WaveformType.long,
                    playerWaveStyle: playerWaveStyle,
                  ),
                  if (widget.isSender) const SizedBox(width: 10),
                ],
              ),
            ),
          )
        : const SizedBox.shrink();
  }
}

// class AudioRecordingPage extends StatefulWidget {
//   const AudioRecordingPage({super.key});

//   @override
//   State<AudioRecordingPage> createState() => _AudioRecordingPageState();
// }

// class _AudioRecordingPageState extends State<AudioRecordingPage> {
//   @override
//   Widget build(BuildContext context) {
    // if (_isLoading) {
    //   return Container(
    //     color: Colors.white,
    //     child: const Center(
    //       child: CircularProgressIndicator(),
    //     ),
    //   );
    // } else {
    //   return openCamera
    //       ? Center(
    //           child: Stack(
    //             alignment: Alignment.bottomCenter,
    //             children: [
    //               CameraPreview(_cameraController),
    //               Padding(
    //                 padding: const EdgeInsets.all(25),
    //                 child: FloatingActionButton(
    //                   backgroundColor: Colors.red,
    //                   child: Icon(_isRecording ? Icons.stop : Icons.circle),
    //                   onPressed: () => _recordVideo(),
    //                 ),
    //               ),
    //             ],
    //           ),
    //         )
    //       : Column(
    //           children: [
    //             TextButton(
    //               onPressed: () {
    //                 setState(() {
    //                   openCamera = true;
    //                 });
    //               },
    //               child: Text("Open Camera"),
    //             ),
    //           ],
    //         );
    // }
//   }
// }
