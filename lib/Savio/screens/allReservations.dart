import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tables24_v3/Rahul/dataStoring.dart';
import 'package:tables24_v3/Savio/functions/getRestaurantDetails.dart';
import 'package:tables24_v3/Savio/widgets/starRating.dart';

class AllReservationsPage extends StatefulWidget {
  @override
  _AllReservationsPageState createState() => _AllReservationsPageState();
}

class _AllReservationsPageState extends State<AllReservationsPage> {
  Widget currentPage;
  int currentPageNo;
  ShowReservationsCard showReservationsCard;
  @override
  void initState(){
    super.initState();
    currentPage = ShowReservationsCard("upcoming");
    currentPageNo = 2;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text("Your Reservations")),
      body: Column(
        children: <Widget>[
          SizedBox(height: 30,),
          Container(
            height: 50,
            width: MediaQuery.of(context).size.width - 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: Colors.black),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  InkWell(
                    onTap: (){
                      setState(() {
                        currentPage = ShowReservationsCard("past");
                        currentPageNo = 1;
                      });
                    },
                    child: Container(
                      alignment: Alignment(0,0),
                      height: 30,
                      width: MediaQuery.of(context).size.width/4,

                      child: Text("Past", style: TextStyle(color:
                          currentPageNo == 1?  Colors.red :  Colors.black
                      ),),
                    ),
                  ),
                  VerticalDivider(color: Colors.black,),
                  InkWell(
                    onTap: (){
                      setState(() {
                        currentPage = ShowReservationsCard("upcoming");
                        currentPageNo = 2;
                      });
                    },
                    child: Container(
                      alignment: Alignment(0, 0),
                      height: 30,
                      width: MediaQuery.of(context).size.width/4,

                      child: Text("Upcoming", style: TextStyle(color: currentPageNo == 2?  Colors.red :  Colors.black),),

                    ),
                  ),
                  VerticalDivider(color: Colors.black,),
                  InkWell(
                    onTap: (){
                      setState(() {
                        currentPage = ShowReservationsCard("cancelled");
                        currentPageNo = 3;
                      });
                    },
                    child: Container(
                      alignment: Alignment(0, 0),
                      height: 30,
                      width: MediaQuery.of(context).size.width/4,

                      child: Text("Cancelled", style: TextStyle(color: currentPageNo == 3?  Colors.red :  Colors.black),),
                    ),
                  ),

                ],
              ),
            ),
          ),
          Expanded(child: currentPage),
        ],
      ),
    );
  }
}



class ShowReservationsCard extends StatelessWidget {
  String str1;
  ShowReservationsCard(String this.str1);
  @override
  Widget build(BuildContext context) {

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    int rating;
    print(str1);
    return FutureBuilder(
        future: getReservations(currentUserAndRestaurantDetails["custId"], str1),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          List snap = snapshot.data;

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
        return BuildingReservationCard(snap);
        });
  }
}


class BuildingReservationCard extends StatefulWidget {
  List snap1;
  BuildingReservationCard(List this.snap1);
  @override
  _BuildingReservationCardState createState() => _BuildingReservationCardState();
}

class _BuildingReservationCardState extends State<BuildingReservationCard> {
  @override
  Widget build(BuildContext context) {
    List snap = widget.snap1;
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    int rating;
    return ListView.builder(
        itemCount: snap.length,
        itemBuilder: (context, index) {
          return Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10),
                height: screenHeight / 2.5,
                width: screenWidth - 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey),
                  gradient: LinearGradient(
                    colors: [Colors.red[600], Colors.white],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(10),
                      height: screenHeight / 10,
                      width: screenWidth,
                      child: Row(
                        children: <Widget>[
                          Image(
                              image: NetworkImage(
                                "${snap[index]['image']}",
                              )),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "${snap[index]['resName']}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                              Text(
                                "${snap[index]['address']}",
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Divider(
                      height: 10,
                      thickness: 1,
                      indent: 10,
                      endIndent: 10,
                      color: Colors.grey,
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      height: screenHeight / 8 + 42,
                      width: screenWidth,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "BOOKING ID",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                          ),
                          Text(
                            "${snap[index]['resrId']}",
                            style: TextStyle(fontSize: 14),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "BOOKED ON",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),
                                    ),
                                    Text(
                                      "${snap[index]['bookedOn']}",
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "NO OF PEOPLE",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),
                                    ),
                                    Text(
                                      "${snap[index]['noOfSeats']}",
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "BOOKED DATE",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),
                                    ),
                                    Text(
                                      "${snap[index]['bookedDateTime']}",
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "STATUS",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),
                                    ),
                                    Text(
                                      "${snap[index]['status']}",
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                              ]),
                        ],
                      ),
                    ),
                    Divider(
                      height: 5,
                      thickness: 1,
                      indent: 10,
                      endIndent: 10,
                      color: Colors.grey,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ('${snap[index]['bookedDateTime']}'.substring(0, 10).compareTo(DateTime.now().toString().substring(0, 10)) > 0
                            && ["pending", "cancelled"].contains('${snap[index]['status']}')
                            )?
                            Text("Rating",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ) : Text("Enter Your Rating",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                            (["cancelled", "rejected", "pending"].contains('${snap[index]['status']}'))?

                            StarRatingBuilder(int.parse('${snap[index]['ratingTotal']}')):
                            StarRatingButtonBuilder(int.parse('${snap[index]['ratingCustomer']}'), '${snap[index]['resrId']}','${snap[index]['resId']}' ),
                          ],
                        ),
                        ('${snap[index]['status']}' != 'cancelled'
                            && '${snap[index]['status']}' != 'rejected'
                            && '${snap[index]['bookedDateTime']}'.substring(0, 10).compareTo(DateTime.now().toString().substring(0, 10)) > 0 ) ? InkWell(
                          onTap: () {
                            setState(() {
                              print('removing snap of index' + snap[index].toString());
                              cancelReservation(snap[index]['resrId']);
                              snap.removeAt(index);


                              print(snap);
                            });
                          },
                          child: Container(

                            height:  30,
                            width: 80,
                            alignment: Alignment(0, 0),
                            decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(40),
                                border: Border.all(
                                    color: Colors.black)),
                            child: Text("Cancel"),
                          ),
                        )
                            : Container()
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20,),
            ],
          );
        });
  }
}



