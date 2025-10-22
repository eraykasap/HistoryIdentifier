import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:history_identifier/pages/home_page.dart';
import 'package:history_identifier/pages/photo_page.dart';
import 'package:history_identifier/pages/profile_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      
      
      home: const BottomNavBarCustom(),
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
    allPages = [homePage, photoScannerPage, profilePage];
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      
      backgroundColor: Colors.grey.shade200,

      body: Stack(
        children: [

          allPages[selectedIndex],
          
          //! BOTTOM NAV BAR
          Align(
            alignment: Alignment.bottomCenter,
            child: bottomNavgationBar((value) {
              setState(() {
                selectedIndex = value;
              });
            }),
          ),
          
        ],
      ),

      

    );
  }
}


Widget bottomNavgationBar (Function(int) onSelect) {
  return SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: Colors.white
            ),
            child: GNav(
              
              tabBackgroundColor: Colors.black,
              color: Colors.black,
              activeColor: Colors.white,
              //backgroundColor: Colors.white,
              iconSize: 34,
              tabBorderRadius: 24,
              gap: 8,
              //duration: Duration(microseconds: 1500),
              tabMargin: const EdgeInsetsGeometry.symmetric(vertical: 6, horizontal: 6),
              tabs: [
                GButton(
                  icon: Icons.home_outlined,
                  text: "Home",
                ),
                GButton(
                  icon: Icons.photo_camera_outlined,
                  text: "Scan",
                ),
                GButton(
                  icon: Icons.person_outline,
                  text: "Profile",
                )
              ],
                onTabChange: (value) {
                  onSelect(value);
                }
            ),
            
          ),
        ),
      );
}




