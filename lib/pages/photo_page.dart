import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:history_identifier/main.dart';
import 'package:history_identifier/pages/gecis_sayfas%C4%B1.dart';
import 'package:history_identifier/pages/profile_page.dart';

class PhotoScannerPage extends StatefulWidget {
  const PhotoScannerPage({super.key});

  @override
  State<PhotoScannerPage> createState() => _PhotoScannerPageState();
}

class _PhotoScannerPageState extends State<PhotoScannerPage> {
  CameraController? _controller;
  bool _isCameraInitialized = false;
  bool _isCapturing = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initializedCamera();
  }

  Future<void> _initializedCamera() async {
    final camera = await availableCameras();
    final firstCamera = camera.first;

    _controller = CameraController(
      firstCamera,
      ResolutionPreset.high,
      enableAudio: false,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );

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

    return SafeArea(
      child: Stack(
        children: [
          Column(
            children: [
      
              //SafeArea(child: SizedBox(height: 35,)),
      
              Expanded(
                child: AspectRatio(
                  aspectRatio: 4 / 3,
                  child: _isCameraInitialized
                      ? CameraPreview(_controller!)
                      : const Center(child: CircularProgressIndicator()),
                ),
              ),
      
              //! PHOTO BUTTON
              Align(
                alignment: AlignmentGeometry.bottomCenter,
                child: Container(
                  //color: Colors.amber,
                  margin: EdgeInsets.symmetric(vertical: 35),
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
                          onPressed: () async {
                            await _takePicture();
                            //Navigator.of(context).push(CupertinoPageRoute(builder: (context) => MyApp()));
                          },
                          child: Container(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
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
        ],
      ),
    );
  }

  Future<void> _takePicture() async {
    print("ÇALIŞTI");

    /* if (_isCapturing) {
      print("❌ Zaten çekim yapılıyor, atlanıyor...");
      return; // Burada metot sonlanır
    } */

    /* setState(() {+
      _isCapturing = true;
    }); */

    final image = await _controller!.takePicture();
    File imageFile = File(image.path);

    await _controller!.pausePreview();

    Navigator.of(context).push(
      CupertinoPageRoute(builder: (context) => PhotoPage(Myimage: imageFile)),
    );
  }
}
