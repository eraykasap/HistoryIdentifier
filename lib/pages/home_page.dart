
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 100,
        height: 100,
        //color: Colors.amber,
        child: Text("Home Page"),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: Colors.amber
        ),
      ),
    );
  }
}




