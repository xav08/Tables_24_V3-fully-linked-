import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:tables24_v3/Savio/screens/allReservations.dart';
import 'dart:convert';

import 'package:tables24_v3/Savio/screens/homePage.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  @override
  getRestaurants() async {
    String theUrl =
        'https://tables24.000webhostapp.com/Savio/getRestaurants.php';
    var res = await http
        .get(Uri.encodeFull(theUrl), headers: {"Accept": "application/json"});
    var responsBody = json.decode(res.body);
    print(responsBody);
    return responsBody;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        title: Text("Restaurants list"),
      ),*/
      body: Container(
        child: FutureBuilder(
          future: getRestaurants(),
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

            return ListView.builder(
              itemCount: snap.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    String temp = snap[index]['res_name'];
                    String temp1 = snap[index]['restaurant_id'];
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage1(temp, temp1)),
                    );
                  },
                  child: Card(
                    child: ListTile(
                      leading: FlutterLogo(size: 72),
                      title: Text(
                          "restaurant_id: ${snap[index]['restaurant_id']}"),
                      subtitle: Text("res_name ${snap[index]['res_name']}\n "),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
