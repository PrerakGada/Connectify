import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class VideoRecordingPage extends StatefulWidget {
  static const String id = "/video_recording_page";
  final videoRecorded;
  const VideoRecordingPage({super.key, required this.videoRecorded});

  @override
  State<VideoRecordingPage> createState() => _VideoRecordingPageState();
}

class _VideoRecordingPageState extends State<VideoRecordingPage> {
  bool _isLoading = true;
  late CameraController _cameraController;
  bool _isRecording = false;
  bool openCamera = false;

  _initCamera() async {
    final cameras = await availableCameras();
    final front = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front);
    _cameraController = CameraController(front, ResolutionPreset.max);
    await _cameraController.initialize();
    setState(() => _isLoading = false);
  }

  _recordVideo() async {
    if (_isRecording) {
      final file = await _cameraController.stopVideoRecording();
      debugPrint("file is ${file.path}");

      setState(() {
        _isRecording = false;
        openCamera = false;
      });
      widget.videoRecorded(file.path);
      Navigator.of(context).pop();
    } else {
      await _cameraController.prepareForVideoRecording();
      await _cameraController.startVideoRecording();
      setState(() => _isRecording = true);
    }
  }

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _isLoading
                ? Container(
                    // color: Colors.white,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : Center(
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        CameraPreview(_cameraController),
                        Padding(
                          padding: const EdgeInsets.all(25),
                          child: FloatingActionButton(
                            backgroundColor: Colors.red,
                            child:
                                Icon(_isRecording ? Icons.stop : Icons.circle),
                            onPressed: () => _recordVideo(),
                          ),
                        ),
                      ],
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
