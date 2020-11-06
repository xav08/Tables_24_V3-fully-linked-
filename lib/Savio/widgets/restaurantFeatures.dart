import 'package:flutter/material.dart';

class RestaurantFeatures extends StatelessWidget {
  List<dynamic> snap;
  RestaurantFeatures(List<dynamic> this.snap);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20.0, left: 60, right: 60),
      child: Container(
        alignment: Alignment(-1, -1),
        height: 200,
        width: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(
                  Icons.local_dining,
                  size: 30,
                ),
                SizedBox(width: 10),
                Text("Multi cuisine",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    )),
              ],
            ),
            Row(
              children: <Widget>[
                Icon(
                  Icons.local_cafe,
                  size: 30,
                ),
                SizedBox(width: 10),
                Text("Cafe",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    )),
              ],
            ),Row(
              children: <Widget>[
                Icon(
                  Icons.local_parking,
                  size: 30,
                ),
                SizedBox(width: 10),
                Text("Parking",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    )),
              ],
            ),Row(
              children: <Widget>[
                Icon(
                  Icons.fastfood,
                  size: 30,
                ),
                SizedBox(width: 10),
                Text("Fast Food",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    )),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
