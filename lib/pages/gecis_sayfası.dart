
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:history_identifier/config/data.dart';
import 'package:history_identifier/main.dart';
import 'package:history_identifier/model/model.dart';
import 'package:history_identifier/pages/detay_page.dart';
import 'package:history_identifier/providers/providers.dart';


class PhotoAIanalizPage extends ConsumerStatefulWidget {

  final File Myimage;

  PhotoAIanalizPage({
    super.key,
    required this.Myimage
  });

  @override
  ConsumerState<PhotoAIanalizPage> createState() => _PhotoAIanalizPageState();
}

class _PhotoAIanalizPageState extends ConsumerState<PhotoAIanalizPage> {

  String result = "";
  bool analizEdiliyor = true;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _startAnalysis();
    //sendImageAndGetJson(widget.Myimage, ref);
    Future.microtask(() {
      ref.read(photoTakenProvider.notifier).state = widget.Myimage;
    });
    
  }

  

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      
      backgroundColor: Colors.black,
      body: Stack(
        children: [ 
          Center(
            child: Expanded(
              child: AspectRatio(
                aspectRatio: 9/16,
                child:Image.file(widget.Myimage)
                 /*ClipRect(child: Image.file(widget.Myimage, fit: BoxFit.cover,))*/
              ),
            ),
          ),

          Container(
            width: double.maxFinite,
            height: double.maxFinite,
            color: Colors.black.withAlpha(80),
            child: Center(
              child: analizEdiliyor ? CircularProgressIndicator() : Container(),
            ),
          )

        ]
      ),
    );

  }



  Future<void> _startAnalysis () async {

    try {
      List<ContentModel> icerikListesi = [];
      icerikListesi = await ref.read(apiOperationsController).sendImageAndGetJson(widget.Myimage);
      if (icerikListesi.isNotEmpty) {
        ref.read(contentProvider.notifier).state = icerikListesi;
        Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (context) => DetaySayfasi()));
      }
      else {
        print("--------- LİSTE HATASI ---------");
        setState(() {
          analizEdiliyor = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(duration: Duration(seconds: 2), content: Text("Bir sorun oluştu. Lütfen tekrar deneyin"))).closed.then((_) {
          Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (context) => MyApp()));
        });
        
      }
    } catch (e) {
      print("--------- CACHE HATASI ---------");
      setState(() {
        analizEdiliyor = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(duration: Duration(seconds: 2), content: Text("Bir sorun oluştu. Lütfen tekrar deneyin"))).closed.then((_) {
        Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (context) => MyApp()));
      });
      
    }
    

  }


  

}