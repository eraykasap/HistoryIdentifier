import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'package:history_identifier/pages/home_page.dart';
import 'package:history_identifier/pages/photo_page.dart';
import 'package:history_identifier/pages/profile_page.dart';





void main() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: BottomNavBarCustom(),
    );
  }
}

class BottomNavBarCustom extends StatefulWidget {
  const BottomNavBarCustom({super.key});

  @override
  State<BottomNavBarCustom> createState() => _BottomNavBarCustomState();
}

class _BottomNavBarCustomState extends State<BottomNavBarCustom> {

  int selectedIndex = 0;
  

  late PhotoScannerPage photoScannerPage;
  late HomePage homePage;
  late ProfilePage profilePage;
  late List<Widget> allPages;

  @override
  void initState() {
    super.initState();

    photoScannerPage = PhotoScannerPage();
    homePage = HomePage();
    profilePage = ProfilePage();
    allPages = [homePage, profilePage];
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.grey.shade200,

      body: allPages[selectedIndex],

      bottomNavigationBar: bottomNavgationBar(
        selectedIndex, 
        context,
        (index) {
          setState(() {
            selectedIndex = index;
          });
        }
      ),

    );
  }
}



Widget bottomNavgationBar(int selectindex, BuildContext context, Function(int) onSelect) {
  
  return SafeArea(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 95,
          
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: Colors.white,
          ),
          child: GNav(
            
            selectedIndex: selectindex,
            tabBackgroundColor: Colors.black,
            color: Colors.black,
            activeColor: Colors.white,
            
            iconSize: 34,
            tabBorderRadius: 24,
            gap: 8,
            tabMargin: const EdgeInsetsGeometry.symmetric(
              vertical: 6,
              horizontal: 6,
            ),
            tabs: [
              GButton(icon: Icons.home_outlined, text: "Home"), 
              GButton(icon: Icons.person_outline, text: "Profile"),
            ],
            
            onTabChange: (value) {
              onSelect(value);
            },
          ),
        ),

        SizedBox(
          width: 15,
        ),

        SizedBox(
          height: 95,
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(CupertinoPageRoute(builder: (context) => PhotoScannerPage()));
            }, 
            child: Row(children: [
              Icon(Icons.photo_camera_outlined, size: 34, color: Colors.black,),
              SizedBox(width: 8,),
              Text("Scan", style: TextStyle(color: Colors.black),)
            ],),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(24)),
              shadowColor: Colors.transparent,
              backgroundColor: Colors.white,
              overlayColor: Colors.grey.shade800
            ),
          ),
        )



      ],
    ),
  );
}












