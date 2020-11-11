import 'package:flutter/material.dart';
import 'package:tables24_v3/Savio/functions/getRestaurantDetails.dart';

class StarRating extends StatelessWidget {
  int rating;

  StarRating(int this.rating);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(
          Icons.star,
          color: Colors.yellowAccent,
          size: 20.0,
        ),
        Icon(
          Icons.star,
          color: Colors.yellowAccent,
          size: 20.0,
        ),
        Icon(
          Icons.star,
          color: Colors.yellowAccent,
          size: 20.0,
        ),
        Icon(
          Icons.star,
          color: Colors.yellowAccent,
          size: 20.0,
        ),
        rating > 4
            ? Icon(
                Icons.star,
                color: Colors.yellowAccent,
                size: 20.0,
              )
            : Icon(
                Icons.star,
                color: Colors.grey,
                size: 20.0,
              ),
        SizedBox(width: 5.0),
        Text(
          "(22 Reviews)",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}

class StarRatingBuilder extends StatelessWidget {
  int rating;
  StarRatingBuilder(int this.rating);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.0,
      height: 24.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
          itemCount: 5,
          itemBuilder: (context, index) {
            return Container(
                child: rating > index
                ? Icon(
                    Icons.star,
                    color: Colors.orange,
                    size: 20.0,
                  )
                : Icon(
                    Icons.star,
                    color: Colors.grey,
                    size: 20.0,
                  )
            );

          }),
    );
  }
}


class StarRatingButtonBuilder extends StatefulWidget {
  int rating1;
  String resrId;
  String resId;
  StarRatingButtonBuilder(int this.rating1, String this.resrId, this.resId);
  @override
  _StarRatingButtonBuilderState createState() => _StarRatingButtonBuilderState();
}

class _StarRatingButtonBuilderState extends State<StarRatingButtonBuilder> {

  @override
  Widget build(BuildContext context) {
    int rating = widget.rating1;
    return Container(
      width: 100.0,
      height: 24.0,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 5,
          itemBuilder: (context, index) {
            return Container(
                child: InkWell(
                  onTap: (){
                    setState(() {
                      widget.rating1 = index + 1;
                      print("your rating is " + widget.rating1.toString());
                    });
                    addRating(widget.resrId, widget.rating1.toString(), widget.resId);

                  },

                child: Icon(
                  Icons.star,
                  color: (widget.rating1 > index) ? Colors.yellowAccent: Colors.grey,
                  size: 20.0,
                )
                )
            );

          }),

    );
  }
}

