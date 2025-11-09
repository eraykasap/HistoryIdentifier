

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:history_identifier/providers/providers.dart';
import 'package:history_identifier/widgets/widgets.dart';

class DetaySayfasi extends ConsumerWidget {

  DetaySayfasi({super.key,});

  

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    var contentList = ref.watch(contentProvider);
    var image = ref.read(photoTakenProvider);


    return Scaffold(
      body: Column(
        children: [

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 15, 0, 0),
              child: Align(
                alignment: AlignmentGeometry.centerLeft,
                child: IconButton(onPressed: () {
                  Navigator.of(context).pop();
                }, icon: Icon(Icons.arrow_back, size: 36,))
              ),
            )
          ),

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
              
                  image != null ? 
                  Image.file(image, height: 600, width: double.maxFinite, fit: BoxFit.cover,) : 
                  CircularProgressIndicator(),
              
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: contentList.length,
                    itemBuilder: (context, index) {
                  
                      var item = contentList[index];
                  
                      return Container(
                        child: ContentModelWidget(title: item.title, content: item.content),
                      );
                    
                    }
                  ),
            
            
                ],
              ),
            ),
          ),
        ],
      ),
      
      floatingActionButton: FloatingActionButton(onPressed: () {}),

      
    );
  }
}