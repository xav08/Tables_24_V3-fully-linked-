import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ManagerAccount extends StatefulWidget {
  @override
  _ManagerAccountState createState() => _ManagerAccountState();
}

class _ManagerAccountState extends State<ManagerAccount> {
  getManagerData(String mang_id) async {
    String theUrl =
        'https://tables24.000webhostapp.com/Rohan/getManagerData.php';
    var res = await http.post(Uri.encodeFull(theUrl),
        headers: {"Accept": "application/json"}, body: {"mang_id": mang_id});
    var responsBody = json.decode(res.body);
    print(responsBody);
    return responsBody;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange[500],
        title: Text("Account Details"),
      ),
      body: FutureBuilder(
        future: getManagerData('400001'), //TODO: Accept value from loginpage
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
              return Column(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.orange, Colors.red],
                      ),
                    ),
                    child: Container(
                      width: double.infinity,
                      height: 400.0,
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.account_box,
                              size: 150.0,
                              color: Colors.white,
                            ),
                            Text(
                              "${snap[index]['mang_name']}",
                              style: TextStyle(
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 30.0),
                            Card(
                              margin: EdgeInsets.symmetric(
                                horizontal: 20.0,
                                vertical: 5.0,
                              ),
                              clipBehavior: Clip.antiAlias,
                              color: Colors.white,
                              elevation: 5.0,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 22.0),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Column(
                                        children: <Widget>[
                                          Text(
                                            "Manager ID",
                                            style: TextStyle(
                                              color: Colors.redAccent,
                                              fontSize: 22.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                          Text(
                                            '${snap[index]['mang_id']}',
                                            style: TextStyle(
                                              fontSize: 20.0,
                                              color: Colors.pinkAccent,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: <Widget>[
                                          Text(
                                            "Restaurant ID",
                                            style: TextStyle(
                                              color: Colors.redAccent,
                                              fontSize: 22.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                          Text(
                                            "${snap[index]['res_id']}",
                                            style: TextStyle(
                                              fontSize: 20.0,
                                              color: Colors.pinkAccent,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50.0,
                  ),
                  Container(
                    width: 300,
                    child: RaisedButton(
                      onPressed: () {}, //TODO: Navigate to homescreen
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(80.0),
                      ),
                      elevation: 0.0,
                      padding: EdgeInsets.all(0.0),
                      child: Ink(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.centerRight,
                            end: Alignment.centerLeft,
                            colors: [
                              Colors.orange,
                              Colors.red,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: Container(
                          constraints: BoxConstraints(
                            maxWidth: 300.0,
                            maxHeight: 50.0,
                          ),
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.power_settings_new,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 15.0,
                              ),
                              Text(
                                'LOGOUT',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

//Column(
//children: <Widget>[
//Icon(
//Icons.account_box,
//size: 100.0,
//color: Colors.black54,
//),
//SizedBox(
//height: 20.0,
//),
//Text(
//'Name: ${snap[index]['mang_name']}',
//style: TextStyle(
//fontSize: 30.0,
//),
//),
//Text('Manager ID: ${snap[index]['mang_id']}'),
//Text('Restaurant ID: ${snap[index]['res_id']}'),
//FlatButton.icon(
//onPressed: null, //TODO: Navigate to login page
//icon: Icon(
//Icons.power_settings_new,
//color: Colors.red,
//),
//label: Text(
//'Logout',
//style: TextStyle(color: Colors.red),
//),
//),
//],
//),
