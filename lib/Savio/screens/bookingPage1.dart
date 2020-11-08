import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:tables24_v3/Rahul/dataStoring.dart';
import 'package:tables24_v3/Savio/functions/getRestaurantDetails.dart';
import 'package:tables24_v3/Savio/screens/firstScreen.dart';
import 'package:tables24_v3/Savio/widgets/showTables.dart';

import 'mainScreen.dart';

class BookingPage1 extends StatefulWidget {
  String resName;
  String resId;

  BookingPage1(String this.resName, String this.resId);

  @override
  _BookingPage1State createState() => _BookingPage1State();
}

class _BookingPage1State extends State<BookingPage1> {
  DateTime _dateTime;
  TimeOfDay _timeOfDay;
  int _noOfSeats;
  int _duration;
  Map<String, String> requirements;

  @override
  void initState() {
    super.initState();
    _dateTime = DateTime.now();
    _timeOfDay = TimeOfDay.now();
    _noOfSeats = 2;
    _duration = 1;
    reservationRequiredDetails['date'] = _dateTime.toString().substring(0, 10);
    reservationRequiredDetails['time'] =
        _timeOfDay.toString().substring(10, 15);
    reservationRequiredDetails['noOfSeats'] = _noOfSeats;
    reservationRequiredDetails['duration'] = _duration;
  }

  @override
  Widget build(BuildContext context) {
    print("the current selected restaurant is " +
        currentUserAndRestaurantDetails['resId'].toString());

    return Material(
        child: Scaffold(
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
            child: Container(
              height: MediaQuery.of(context).size.height / 2.6,
              width: MediaQuery.of(context).size.width - 10,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.black,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                  ),
                ],
                image: DecorationImage(
                  image: NetworkImage(
                      currentUserAndRestaurantDetails["resLayout"]),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    RaisedButton(
                      child: Text('Pick a date'),
                      onPressed: () {
                        showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2020),
                                lastDate: DateTime(2222))
                            .then((date) {
                          setState(() {
                            _dateTime = date;
                            reservationRequiredDetails['date'] =
                                date.toString().substring(0, 10);
                          });
                        });
                      },
                    ),
                    Text(reservationRequiredDetails['date']),
                  ],
                ),
                Column(
                  children: <Widget>[
                    RaisedButton(
                      child: Text('Pick a time'),
                      onPressed: () {
                        showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        ).then((time) {
                          setState(() {
                            _timeOfDay = time;
                            reservationRequiredDetails['time'] =
                                time.toString().substring(10, 15);
                          });
                        });
                      },
                    ),
                    Text(reservationRequiredDetails['time']),
                  ],
                ),
                Column(
                  children: <Widget>[
                    DropdownButton<int>(
                      value: reservationRequiredDetails['noOfSeats'],
                      items: <int>[1, 2, 3, 4]
                          .map<DropdownMenuItem<int>>((int value) {
                        return DropdownMenuItem<int>(
                          value: value,
                          child: Text(value.toString()),
                        );
                      }).toList(),
                      onChanged: (int value) {
                        setState(() {
                          _noOfSeats = value;
                          reservationRequiredDetails['noOfSeats'] = _noOfSeats;
                        });
                      },
                    ),
                    Text("no of seats"),
                  ],
                ),
                Column(
                  children: <Widget>[
                    DropdownButton<int>(
                      value: reservationRequiredDetails['duration'],
                      items: <int>[1, 2, 3, 4]
                          .map<DropdownMenuItem<int>>((int value) {
                        return DropdownMenuItem<int>(
                          value: value,
                          child: Text(value.toString()),
                        );
                      }).toList(),
                      onChanged: (int value) {
                        setState(() {
                          _duration = value;
                          reservationRequiredDetails['duration'] = _duration;
                        });
                      },
                    ),
                    Text("duration"),
                  ],
                ),
              ]),
          Expanded(
              child: Container(
            height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.width - 20,
            child: ShowTables1(),
          )),
        ],
      ),
    ));
  }
}

class ShowTables1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getTables(reservationRequiredDetails),
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
                reserveTable(
                  currentUserAndRestaurantDetails["custId"],
                  "${snap[index]['tableId']}",
                  reservationRequiredDetails['date'],
                  reservationRequiredDetails['time'],
                  reservationRequiredDetails['duration'],
                  reservationRequiredDetails['noOfSeats'],
                );
                Navigator.pop(context);
                Navigator.pop(context);
                /*Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FirstScreen()),
                );*/
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
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
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        bottom: 0,
                        left: 0,
                        child: Container(
                          alignment: Alignment(0, 0),
                          height: MediaQuery.of(context).size.height / 7,
                          width: MediaQuery.of(context).size.width - 35,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            gradient: LinearGradient(
                              colors: [
                                Colors.black54,
                                Colors.black45,
                                Colors.black38
                              ],
                            ),
                          ),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "Table Id : " + "${snap[index]['tableId']}",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'Itim',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  "No of Seats : " +
                                      "${snap[index]['noOfSeats']}",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'Itim',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                )
                              ]),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
