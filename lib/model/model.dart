

import 'dart:io';
import 'package:flutter/cupertino.dart';

class ContentModel {
  
  final String title;
  final String content;

  ContentModel({
    required this.title, 
    required this.content
  });

  factory ContentModel.fromMap(Map<String, dynamic> json) => ContentModel(
    title: json["Title"], 
    content: json["Explanation"]
  );

}



