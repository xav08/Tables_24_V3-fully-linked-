import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PendingList extends StatefulWidget {
  @override
  _PendingListState createState() => _PendingListState();
}

class _PendingListState extends State<PendingList> {
  pendingList(String mang_id) async {
    String theUrl = 'https://tables24.000webhostapp.com/Rohan/pendingList.php';
    var res = await http.post(Uri.encodeFull(theUrl),
        headers: {"Accept": "application/json"}, body: {"mang_id": mang_id});
    var responsBody = json.decode(res.body);
    print(responsBody);
    return responsBody;
  }

  confirmRes(String resr_id) async {
    String theUrl = 'https://tables24.000webhostapp.com/Rohan/confirmRes.php';
    var res = await http.post(Uri.encodeFull(theUrl),
        headers: {"Accept": "application/json"}, body: {"resr_id": resr_id});
    var responsBody = json.decode(res.body);
    print(responsBody);
    return responsBody;
  }

  denyRes(String resr_id) async {
    String theUrl = 'https://tables24.000webhostapp.com/Rohan/denyRes.php';
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
      appBar: AppBar(
        backgroundColor: Colors.orange[500],
        title: Text("Pending Reservations"),
      ),
      body: FutureBuilder(
        future: pendingList(
            '400001'), //TODO: Change hardcoded value to mang_id received from login
        builder: (BuildContext context, AsyncSnapshot snapshot) {
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
          List snap = snapshot.data;

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
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: <Widget>[
                          Text(
                            'Reservation ID:  ${snap[index]['resr_id']}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                            ),
                          ),
                          Text('Table ID :  ${snap[index]['table_id']}'),
                          Text('Date: $date'),
                          Text('Time:  $time'),
                        ],
                      ),
                      Column(
                        children: [
                          FlatButton.icon(
                            onPressed: () {
                              setState(() {
                                confirmRes('${snap[index]['resr_id']}');
                              });
                            },
                            icon: Icon(
                              Icons.check_circle,
                              color: Colors.lightGreen,
                            ),
                            label: Text(
                              'Accept',
                              style: TextStyle(color: Colors.lightGreen),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          FlatButton.icon(
                            onPressed: () {
                              setState(() {
                                denyRes('${snap[index]['resr_id']}');
                              });
                            },
                            icon: Icon(
                              Icons.close,
                              color: Colors.red[500],
                            ),
                            label: Text(
                              'Deny',
                              style: TextStyle(color: Colors.red[500]),
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

//setState(() {
//confirmRes('300002');
//});
