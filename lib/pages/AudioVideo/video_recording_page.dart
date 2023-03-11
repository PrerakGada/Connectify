import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class VideoRecordingPage extends StatefulWidget {
  const VideoRecordingPage({super.key});

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
      // file.saveTo("/storage/emulated/0/Download");
      debugPrint("file is ${file.path}");
      setState(() {
        _isRecording = false;
        openCamera = false;
      });
      // final route = MaterialPageRoute(
      //   fullscreenDialog: true,
      //   builder: (_) => VideoPage(filePath: file.path),
      // );
      // Navigator.push(context, route);
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
    if (_isLoading) {
      return Container(
        color: Colors.white,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return openCamera
          ? Center(
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  CameraPreview(_cameraController),
                  Padding(
                    padding: const EdgeInsets.all(25),
                    child: FloatingActionButton(
                      backgroundColor: Colors.red,
                      child: Icon(_isRecording ? Icons.stop : Icons.circle),
                      onPressed: () => _recordVideo(),
                    ),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      openCamera = true;
                    });
                  },
                  child: Text("Open Camera"),
                ),
              ],
            );
    }
  }
}
