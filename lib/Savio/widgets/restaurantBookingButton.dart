import 'package:flutter/material.dart';
import 'package:tables24_v3/Savio/screens/bookingPage.dart';
import 'package:tables24_v3/Savio/screens/bookingPage1.dart';
import 'package:tables24_v3/Savio/screens/bookingPage3.dart';
class RestaurantBookingButton extends StatelessWidget {
  List <dynamic> snap;
  RestaurantBookingButton(List <dynamic> this.snap);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        String temp = snap[0]['res_name'];
        String temp1 = snap[0]['restaurant_id'];
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage2(temp, temp1)),
        );
      },
      child: Container(
        alignment: Alignment(0, -1),
        width: 300,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                colors: [
                  Colors.red[800],
                  Colors.red[500],
                  Colors.red[400]
                ]

            )
        ),
        child: Center(
          child: Text(
            'Book Now',
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ),
      ),
    );
  }
}
