import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:tables24_v3/Rahul/dataStoring.dart';
import 'package:tables24_v3/Savio/functions/getRestaurantDetails.dart';
import 'package:tables24_v3/Savio/widgets/restaurantBookingButton.dart';
import 'package:tables24_v3/Savio/widgets/restaurantDescription.dart';
import 'package:tables24_v3/Savio/widgets/restaurantFeatures.dart';
import 'package:tables24_v3/Savio/widgets/restaurantFeaturesCard.dart';
import 'package:tables24_v3/Savio/widgets/restaurantImage.dart';

class HomePage1 extends StatefulWidget {
  String resName;
  String resId;
  HomePage1(String this.resName, String this.resId);

  @override
  _HomePage1State createState() => _HomePage1State();
}

class _HomePage1State extends State<HomePage1> {
  @override
  Widget build(BuildContext context) {
    print("the current selected restaurant is " + currentUserAndRestaurantDetails['resId'].toString());
    print("the current selected customer is " + currentUserAndRestaurantDetails['custId'].toString());

    return Scaffold(
      
      body: FutureBuilder(
        future: getRestaurantDetails(widget.resId),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          List snap1 = snapshot.data;

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text("Error fetching Data"),
            );
          }
          print(snap1);
          return Material(
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                      left: 5.0, right: 5.0, bottom: 5.0),
                  child: Column(
                    children: <Widget>[
                      RestaurantImage(snap1),
                      SizedBox(
                        height: 20.0,
                      ),
                     // RestaurantFeatures(snap1),
                      RestaurantFeaturesCard("${snap1[0]['features']}"),
                      SizedBox(height: 20.0),
                      RestaurantDescription(snap1),
                      RestaurantBookingButton(snap1),
                    ],
                  ),
                ),

              ],
            ),
          );
        }
        ,
      ),
    );
  }
}