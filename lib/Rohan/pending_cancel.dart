import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:tables24_v3/Rahul/dataStoring.dart';

class PendingCancel extends StatefulWidget {
  @override
  _PendingCancelState createState() => _PendingCancelState();
}

class _PendingCancelState extends State<PendingCancel> {
  pendingCancel(String mang_id) async {
    String theUrl =
        'https://tables24.000webhostapp.com/Rohan/pendingCancel.php';
    var res = await http.post(Uri.encodeFull(theUrl),
        headers: {"Accept": "application/json"}, body: {"mang_id": mang_id});
    var responsBody = json.decode(res.body);
    print(responsBody);
    return responsBody;
  }

  seenCancel(String resr_id) async {
    String theUrl = 'https://tables24.000webhostapp.com/Rohan/seenCancel.php';
    var res = await http.post(Uri.encodeFull(theUrl),
        headers: {"Accept": "application/json"}, body: {"resr_id": resr_id});
    var responsBody = json.decode(res.body);
    print(responsBody);
    return responsBody;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: FutureBuilder(
        future: pendingCancel(
            currentUserAndRestaurantDetails['mangId']), //TODO: Change hardcoded value to mang_id received from login
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(
                "Error fetching Data",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            );
          }
          List snap = snapshot.data;
          if (snap.length == 0) {
            return Center(
              child: Text(
                'No Recent Cancellations',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            );
          }
          return ListView.builder(
            itemCount: snap.length,
            itemBuilder: (context, index) {
              var dateTime = snap[index]['booked_date_time'].split(' ');
              var date = dateTime[0];
              var time = dateTime[1];
              return Container(
                alignment: Alignment.center,
                margin: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text(
                            'Reservation ID: ${snap[index]['resr_id']}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                            ),
                          ),
                          Text('Table ID : ${snap[index]['table_id']}'),
                          Text('Date: $date'),
                          Text('Time: $time'),
                        ],
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      Column(
                        children: [
                          FlatButton.icon(
                            onPressed: () {
                              setState(() {
                                seenCancel('${snap[index]['resr_id']}');
                              });
                            },
                            icon: Icon(
                              Icons.check_circle,
                              color: Colors.lightGreen,
                            ),
                            label: Text(
                              'Seen',
                              style: TextStyle(color: Colors.lightGreen),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
