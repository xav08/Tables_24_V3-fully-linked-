import 'package:flutter/material.dart';
import 'package:tables24_v3/Savio/functions/getRestaurantDetails.dart';

class RestaurantFeaturesCard extends StatelessWidget {
  String features;
  List featuresList;
  TextStyle style1 = TextStyle(
    fontSize: 40,
    fontFamily:'Itim',
    fontWeight: FontWeight.bold,
    color: Colors.red,
  );

  RestaurantFeaturesCard(String this.features) {
    features = features.replaceAll('[', '');
    features = features.replaceAll(']', '');
    features = features.replaceAll('\'', '');
    this.featuresList = features.split(', ');
    print("the features are" + featuresList.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
      Column(
        children: <Widget>[
          Text("F", style: style1),
          Text("E", style: style1),
          Text("A", style: style1),
          Text("T", style: style1),
          Text("U", style: style1),
          Text("R", style: style1),
          Text("E", style: style1),
          Text("S", style: style1),
        ],
      ),
      Container(
        height: 300,
        width: 200,
        child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: featuresList.length,
            itemBuilder: (context, index) {
              IconData iconName = getIcon(featuresList[index]);
              return Padding(
                padding: EdgeInsets.all(10.0),
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      colors: [
                        Colors.red[800],
                        Colors.red[500],
                      ]

                  ),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        iconName,
                        size: 30,
                      ),
                      SizedBox(width: 10),
                      Text(featuresList[index].toUpperCase(),
                          style: TextStyle(
                            fontFamily:'Itim',
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          )),
                    ],
                  ),
                ),
              );
            }),
      ),
    ]);
  }
}
