
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PhotoAIanalizPage extends StatelessWidget {

  final File Myimage;


  const PhotoAIanalizPage({
    super.key,
    required this.Myimage
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.amber,
          child: AspectRatio(
            aspectRatio: 4/5 ,
            child: ClipRect(child: Image.file(Myimage, fit: BoxFit.cover,))
          ),
        ),
      ),
    );
  }
}