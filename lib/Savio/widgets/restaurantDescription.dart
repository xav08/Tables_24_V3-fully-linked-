import 'package:flutter/material.dart';

class RestaurantDescription extends StatelessWidget {
  List <dynamic> snap;
  RestaurantDescription(List <dynamic> this.snap);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: 400,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              child: Text(
                "Description",
                style: TextStyle(
                  fontSize: 40,
                  fontFamily:'Itim',
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ),
            Positioned(
              top: 50,
              left: 20,
              child: Container(
                width: 360,
                child: Text(
                    "${snap[0]['description']}",
                    style: TextStyle(
                    color: Colors.black, fontFamily:'Itim',fontWeight:FontWeight.bold,fontSize: 20,
                        /*fontWeight: FontWeight.normal,
                        fontSize: 20,
                        color: Colors.black)*/),
              ),
            ),
            ),],
        ),
      ),
    );
  }
}
