
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PhotoPage extends StatelessWidget {

  final File Myimage;


  const PhotoPage({
    super.key,
    required this.Myimage
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          //color: Colors.amber,
          width: 400,
          height: 400,
          child: Image.file(Myimage, ),
        ),
      ),
    );
  }
}