import 'package:flutter/material.dart';
import 'package:tables24_v3/Rahul/home.dart';
import 'package:tables24_v3/Savio/screens/allReservations.dart';

Map<String, dynamic> dataRequired = {
 "currentTabIndex" : 0,
  "pages" : [HomePage() ,AllReservationsPage()],
  "currentPage" : AllReservationsPage(),
};

Map<String, dynamic> currentUserAndRestaurantDetails ={
 "custId" : 100001,
 "resId"  : 200001,
};