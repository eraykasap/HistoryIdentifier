
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContentModelWidget extends StatelessWidget {

  //final File takenImage;
  final String title;
  final String content;

  ContentModelWidget({
    super.key,
    //required this.takenImage,
    required this.title,
    required this.content
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SelectionArea(
        child: Column(
          children: [
            //Image.file(takenImage),
            SizedBox(height: 10,),
            Text(title),
            SizedBox(height: 10,),
            Text(content),
            SizedBox(height: 35,)
          ],
        ),
      ),
    );
  }
}