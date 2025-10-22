
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            spacing: 10,
            children: [
          
          
              //! TEXT BUTTON
              SizedBox(
                width: double.infinity,
                height: 50,
                child: TextButton(
                    onPressed: () {
                
                  }, child: Icon(Icons.photo_camera_outlined, size: 35,),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(24)
                    )
                  ),
                ),
              ),
              
              
              
              
              
              
              
          
          
            ],
          ),
        ),
      ),
    );
  }
}




