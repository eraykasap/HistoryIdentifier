import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:history_identifier/main.dart';

class PhotoScannerPage extends StatefulWidget {
  const PhotoScannerPage({super.key});

  @override
  State<PhotoScannerPage> createState() => _PhotoScannerPageState();
}

class _PhotoScannerPageState extends State<PhotoScannerPage> {
  CameraController? _controller;
  bool _isCameraInitialized = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initializedCamera();
  }

  Future<void> _initializedCamera() async {
    final camera = await availableCameras();
    final firstCamera = camera.first;

    _controller = CameraController(firstCamera, ResolutionPreset.high);

    await _controller!.initialize();

    if (mounted) {
      setState(() {
        _isCameraInitialized = true;
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Expanded(
              child: _isCameraInitialized
                  ? CameraPreview(_controller!)
                  : const Center(child: CircularProgressIndicator()),
            ),
          ],
        ),

        SafeArea(
          child: IconButton(
            onPressed: () {
              Navigator.of(
                context,
              ).push(CupertinoPageRoute(builder: (context) => MyApp()));
            },
            icon: Icon(Icons.arrow_back, size: 36, color: Colors.grey),
          ),
        ),

        //! PHOTO BUTTON
        SafeArea(
          child: Align(
            alignment: AlignmentGeometry.bottomCenter,
            child: Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Stack(
                alignment: AlignmentGeometry.center,
                children: [
                  SizedBox(
                    width: 115,
                    height: 115,
                    child: CircularProgressIndicator(
                      value: 1,
                      color: Colors.white,
                      strokeWidth: 5,
                    ),
                  ),
              
                  SizedBox(
                    width: 95,
                    height: 95,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Container(),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            
          ),
        ),


      ],
    );
  }

  Future<void> _takePicture() async {}
}
