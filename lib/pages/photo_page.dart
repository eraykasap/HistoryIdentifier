import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:history_identifier/pages/gecis_sayfas%C4%B1.dart';

class PhotoScannerPage extends StatefulWidget {
  const PhotoScannerPage({super.key});

  @override
  State<PhotoScannerPage> createState() => _PhotoScannerPageState();
}

class _PhotoScannerPageState extends State<PhotoScannerPage> {
  CameraController? _controller;
  bool _isCameraInitialized = false;
  FlashMode _currentFlashMode = FlashMode.off;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initializedCamera();
  }

  Future<void> _initializedCamera() async {
    final camera = await availableCameras();
    final firstCamera = camera.last;

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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          
          TopArea(),

          /* Expanded(
            child: AspectRatio(
              aspectRatio: 3/4,
              child: _isCameraInitialized
                  ? CameraPreview(_controller!)
                  : const Center(child: Text("Kamera Başlatma Hatası", style: TextStyle(color: Colors.white, fontSize: 24),)),
            ),
          ), */

          Expanded(
            child: AspectRatio(
              aspectRatio: _controller != null
                  ? _controller!.value.aspectRatio
                  : 3 / 4,
              child: _isCameraInitialized
                  ? CameraPreview(_controller!)
                  : const Center(
                      child: Text(
                        "Kamera Başlatma Hatası",
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                    ),
            ),
          ),

          //! BOTTOM AREA
          BottomArea(),

        ],
      ),
    );
  }

  //! TOP AREA
  Widget TopArea() {
    return Container(
      width: double.maxFinite,
      height: 55,
      color: Colors.black,
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back, size: 36, color: Colors.white),
          ),

          IconButton(
            onPressed: () {
              _toggleFlash();
            },
            icon: _currentFlashMode == FlashMode.off
                ? Icon(Icons.flash_off, color: Colors.white)
                : Icon(Icons.flash_on, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget BottomArea() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(40),
            ),
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.photo_library,
                color: Colors.transparent,
                size: 40,
              ),
            ),
          ),

          SizedBox(width: 30),

          Container(
            //color: Colors.amber,
            margin: EdgeInsets.symmetric(vertical: 35),
            child: Stack(
              alignment: AlignmentGeometry.center,
              children: [
                SizedBox(
                  width: 100,
                  height: 100,
                  child: CircularProgressIndicator(
                    value: 1,
                    color: Colors.white,
                    strokeWidth: 5,
                  ),
                ),

                SizedBox(
                  width: 80,
                  height: 80,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_isCameraInitialized) {
                        await _takePicture();
                      }
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

          SizedBox(width: 30),

          //! PHOTO LİBRARY BUTTON
          Container(
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(40),
            ),
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.photo_library, color: Colors.white, size: 40),
            ),
          ),
        ],
      ),
    );
  }


  Future<void> _takePicture() async {
    final image = await _controller!.takePicture();
    File imageFile = File(image.path);

    await _controller!.pausePreview();

    Navigator.of(context).pushReplacement(
      CupertinoPageRoute(
        builder: (context) => PhotoAIanalizPage(Myimage: imageFile),
      ),
    );

    _controller!.resumePreview();
  }

  Future<void> _toggleFlash() async {
    FlashMode newFlashMode;

    if (_currentFlashMode == FlashMode.off) {
      newFlashMode = FlashMode.torch;
    } else if (_currentFlashMode == FlashMode.torch) {
      newFlashMode = FlashMode.off;
    } else {
      newFlashMode = FlashMode.off;
    }

    if (_controller != null) {
      await _controller!.setFlashMode(newFlashMode);
      setState(() {
        _currentFlashMode = newFlashMode;
      });
    }
  }
}
