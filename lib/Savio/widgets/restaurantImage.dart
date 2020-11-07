import 'package:flutter/material.dart';
import 'package:tables24_v3/Savio/widgets/restaurantImageCarousal.dart';
import 'package:tables24_v3/Savio/widgets/starRating.dart';

class RestaurantImage extends StatelessWidget {
  List<dynamic> snap;

  RestaurantImage(List<dynamic> this.snap);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 430,
      width: 430,

      child: Stack(
        children: <Widget>[
          RestaurantImageCarousal(snap[0]["images"]),
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              height: 150,
              width: 400,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40.0),
                gradient: LinearGradient(
                  colors: [Colors.black, Colors.black12],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
          ),

          Positioned(
            top: 300.0,
            left: 20.0,
            child: Text("${snap[0]['res_name']}",
                style: TextStyle(
                    fontSize: 30,
                    fontFamily:'Itim',
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
          ),
          Positioned(
            top: 340,
            left: 20.0,
            child: Container(
              width: 200,
              child: Text(
                "${snap[0]['address']}",
                style: TextStyle(
                    fontFamily:'Itim',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
          Positioned(
              top: 365,
              left: 20,
              child: Row(children: <Widget>[
                StarRatingBuilder(int.parse("${snap[0]['rating']}")),
                Text(
                  "(22 Reviews)",
                  style: TextStyle(
                      fontFamily:'Itim',
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ])),
          Positioned(
              bottom: 30,
              right: 20,
              child: InkWell(
                child: Icon(
                  Icons.favorite,
                  color: Colors.red,
                  size: 40,
                ),
                onTap: () {},
              )),
        ],
      ),
    );
  }
}
