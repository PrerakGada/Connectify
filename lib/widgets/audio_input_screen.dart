import 'dart:async';
import 'dart:io';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:connectify/logic/state_management/user_store.dart';
import 'package:connectify/pages/VideoConferencing/video_conferencing.dart';
import 'package:connectify/theme/typography.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class AudioInputScreen extends StatefulWidget {
  const AudioInputScreen({super.key});

  @override
  State<AudioInputScreen> createState() => _AudioInputScreenState();
}

class _AudioInputScreenState extends State<AudioInputScreen> {
  late final RecorderController aRecorderController;
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
    aRecorderController = RecorderController()
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
    aRecorderController.dispose();
    super.dispose();
  }

  void _startOrStopRecording() async {
    try {
      if (isRecording) {
        aRecorderController.reset();

        final path = await aRecorderController.stop(false);

        if (path != null) {
          isRecordingCompleted = true;
          debugPrint("recorded file path :$path");
          debugPrint("Recorded file size: ${File(path).lengthSync()}");
        }
      } else {
        await aRecorderController.record(path: path!);
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        isRecording = !isRecording;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : SafeArea(
                    child: Column(
                      children: [
                        Text(
                          "What makes you the best fit for this job",
                          style: textTheme.headlineMedium,
                        ),
                        const SizedBox(height: 10),
                        IconButton(
                          onPressed: _startOrStopRecording,
                          icon: Icon(isRecording ? Icons.stop : Icons.mic),
                          color: Colors.white,
                          iconSize: 28,
                        ),
                        isRecording
                            ? AudioWaveforms(
                                enableGesture: true,
                                size: Size(
                                    MediaQuery.of(context).size.width / 2, 50),
                                recorderController: aRecorderController,
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
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 15),
                              )
                            : Container(),
                        if (isRecordingCompleted)
                          WaveBubble(
                            path: path,
                            isSender: true,
                            appDirectory: appDirectory,
                          ),
                      ],
                    ),
                  ),
            SizedBox(height: 20),
            Text(
              "Where are you looking yourself in 5 years?",
              style: textTheme.headlineMedium,
            ),
            const SizedBox(height: 10),
            IconButton(
              onPressed: () {},
              icon: Icon(isRecording ? Icons.stop : Icons.mic),
              color: Colors.white,
              iconSize: 28,
            ),
            const SizedBox(height: 10),
            Text(
              "What are your strengths and weaknesses?",
              style: textTheme.headlineMedium,
            ),
            const SizedBox(height: 10),
            IconButton(
              onPressed: () {},
              icon: Icon(isRecording ? Icons.stop : Icons.mic),
              color: Colors.white,
              iconSize: 28,
            ),
            // Spacer(),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) => const VideoConferencing()),
                  // );
                  Navigator.pop(context);
                  bookedAppointment = true;
                },
                child: Text(
                  "Submit",
                  style: textTheme.headlineMedium,
                ),
              ),
            ),
          ],
        ),
      ),
    );
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
                top: 16,
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
