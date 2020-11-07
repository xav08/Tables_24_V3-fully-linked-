import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tables24_v3/Rahul/dataStoring.dart';
import 'dart:convert';

import 'package:tables24_v3/Savio/functions/getRestaurantDetails.dart';
import 'package:tables24_v3/Savio/screens/mainScreen.dart';

class ShowTables extends StatelessWidget {
  Map<String, String> requirements;

  ShowTables(Map<String, String> this.requirements);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getTables(requirements),
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
        print(requirements['date']);
        print(requirements['time']);
        print(requirements['noOfSeats']);

        return ListView.builder(
          itemCount: snap.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                reserveTable(
                  currentUserAndRestaurantDetails['custId'],
                    "${snap[index]['tableId']}",
                    requirements['date'],
                    requirements['time'],
                    reservationRequiredDetails['duration'],
                    reservationRequiredDetails['noOfSeats'],
                );
              },
              child: Column(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height / 3,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: Colors.black,
                      ),
                      image: DecorationImage(
                          image: NetworkImage("${snap[index]['image']}"),
                          fit: BoxFit.cover),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
}
