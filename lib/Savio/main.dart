import 'package:flutter/material.dart';
import 'package:tables24_v3/Savio/screens/allReservations.dart';
import 'package:tables24_v3/Savio/screens/firstScreen.dart';
import 'package:tables24_v3/Savio/screens/homePage.dart';
import 'package:tables24_v3/Savio/screens/mainScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: FirstScreen()/*MainScreen(),AllReservationsPage(),*/
      ),
    );
  }
}

/*Text((() {
if(true){
return "tis true";}

return "anything but true";
})());*/  //how to write conditionals inside a widget widgetName, put an unnamed () inside paranthasis and put another paranthasis