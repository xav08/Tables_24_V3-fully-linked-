import 'package:flutter/material.dart';
import 'package:tables24_v3/Savio/screens/mainScreen.dart';

import 'allReservations.dart';


class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  int currentTabIndex = 0;
  List<Widget> pages;
  Widget currentPage;

  AllReservationsPage allReservationsPage;
  MainScreen mainScreen;

  @override
  void initState(){
    super.initState();
    mainScreen = MainScreen();
    allReservationsPage = AllReservationsPage();
    pages = [mainScreen, allReservationsPage];

    currentPage = mainScreen;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int index){
          setState(() {
            currentTabIndex = index;
            currentPage = pages[index];
          });
        },
        currentIndex: currentTabIndex,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem> [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("Home"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            title: Text("Orders"),
          ),
        ],
      ),
      body: currentPage,
      appBar: currentTabIndex == 0 ?  AppBar(
        title: Text("Your Home Screen", style: TextStyle(color: Colors.black),),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
      ) : null ,
    );
  }
}
