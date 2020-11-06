import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

getRestaurantDetails1(String resName) async{
  print(resName);
  String theUrl = "https://tables24.000webhostapp.com/Savio/getRestaurantDetails1.php";
  var res = await http.post(Uri.encodeFull(theUrl),headers: {"Accept":"application/json"},
      body: {
        "resName": resName
      }
  );

  print(resName);
  var respBody = json.decode(res.body);
  print(respBody);
  return respBody;
}

getRestaurantDetails(String resId) async{
  print(resId);
  String theUrl = "https://tables24.000webhostapp.com/Savio/getRestaurantDetails.php";
  var res = await http.post(Uri.encodeFull(theUrl),headers: {"Accept":"application/json"},
      body: {
        "resId": resId
      }
  );
  var respBody = json.decode(res.body);
  print(respBody);
  return respBody;
}


getRestaurants()async{
  String theUrl = 'https://tables24.000webhostapp.com/Savio/getRestaurants.php';
  var res = await http.get(Uri.encodeFull(theUrl),headers: {"Accept":"application/json"});
  var responsBody = json.decode(res.body);
  print(responsBody);
  return responsBody;

}


getIcon(String str1){
  if(str1 == 'parking'){ return Icons.local_parking;}
  else if(str1 == 'fastfood'){ return Icons.fastfood;}
  else if(str1 == 'multicuisine'){return Icons.local_dining;}
  else if(str1 == 'cafe'){return Icons.local_cafe;}
  else return Icons.donut_large;
}


getTables(Map<String, dynamic> requirements) async{
  String theUrl = 'https://tables24.000webhostapp.com/Savio/getTables.php';
  print(requirements['date'] + ' ' + requirements['time']);
  var res = await http.post(Uri.encodeFull(theUrl),headers: {"Accept":"application/json"},
      body: {
        "dateTime": requirements['date'] + ' ' + requirements['time'],
        "noOfSeats": '2',
        "duration": '1',
      }
  );
  var responsBody = json.decode(res.body);
  print(responsBody);
  return responsBody;

}

getReservations(String custId, String type) async{
  print(custId);
  String condition;
  String today = DateTime.now().toString().substring(0, 10);

  if(type == 'past'){condition = "booked_date_time < '$today' and status in ('confirmed', 'pending')";}
  else if(type == 'upcoming'){condition = "booked_date_time > '$today' and status in ('confirmed', 'pending')";}
  else {condition = "status = 'cancelled'";}

  String theUrl = "https://tables24.000webhostapp.com/Savio/getReservations.php";
  var res = await http.post(Uri.encodeFull(theUrl),headers: {"Accept":"application/json"},
      body: {
        "custId": custId,
        "condition": condition,

      }
  );
  var respBody = json.decode(res.body);
  print(respBody);
  return respBody;
}


reserveTable(String custId, String tableId, String date, String time, int duration, int noOfSeats)async{
  String dateTime = date+ ' ' + time;
  String bookedDateTime = DateTime.now().toString().substring(0, 10) + " " + TimeOfDay.now().toString().substring(10, 15);
  print(bookedDateTime);
  print(dateTime);
  String theUrl = "https://tables24.000webhostapp.com/Savio/reserveTable.php";
  var res = await http.post(Uri.encodeFull(theUrl),headers: {"Accept":"application/json"},
      body: {
        "custId": custId,
        "tableId": tableId,
        "dateTime": dateTime,
        "duration": duration.toString(),
        "bookedDateTime": bookedDateTime.toString(),
      }
  );
  var respBody = json.decode(res.body);
  print(respBody);
}


cancelReservation(String resrId) async{
  print(resrId);
  String theUrl = "https://tables24.000webhostapp.com/Savio/cancelReservation.php";
  var res = await http.post(Uri.encodeFull(theUrl),headers: {"Accept":"application/json"},
      body: {
        "resrId": resrId,
      }
  );
  var respBody = json.decode(res.body);
  print(respBody);
}

Map <String, dynamic> reservationRequiredDetails = {
  "date" : '2020-10-29',
  "time" : '10:30:00',
  'duration' : 1,
  'noOfSeats' : 2,
};

addRating(String resrId, String rating, String resId) async{
  print(resrId);
  String theUrl = "https://tables24.000webhostapp.com/Savio/addRating.php";
  var res = await http.post(Uri.encodeFull(theUrl),headers: {"Accept":"application/json"},
      body: {
        "resrId": resrId,
        "rating": rating,
        "resId": resId,
      }
  );
  var respBody = json.decode(res.body);
  print(respBody);
}


