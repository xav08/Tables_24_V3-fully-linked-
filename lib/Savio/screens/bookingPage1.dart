import 'package:flutter/material.dart';
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
  int _chosenValue;
  int _duration;
  Map<String, String> requirements;

  @override
  void initState(){
    super.initState();
    _dateTime = DateTime.now();
    _timeOfDay = TimeOfDay.now();
    _chosenValue = 2;
    _duration = 1;
    reservationRequiredDetails['date'] = _dateTime.toString().substring(0, 10);
    reservationRequiredDetails['time'] = _timeOfDay.toString().substring(10, 15);
    reservationRequiredDetails['noOfSeats'] = _chosenValue;
    reservationRequiredDetails['duration'] = _duration;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Scaffold(
          body: Column(
            children: <Widget>[
              SizedBox(height: 50.0,),
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
                                reservationRequiredDetails['date'] = date.toString().substring(0, 10);
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
                                reservationRequiredDetails['time'] = time.toString().substring(10, 15);
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
                          value: reservationRequiredDetails['chosenValue'],
                          items: <int>[1, 2, 3, 4]
                              .map<DropdownMenuItem<int>>((int value) {
                            return DropdownMenuItem<int>(
                              value: value,
                              child: Text(value.toString()),
                            );
                          }).toList(),
                          onChanged: (int value) {
                            setState(() {
                              _chosenValue = value;
                              reservationRequiredDetails['chosenValue'] = _chosenValue;
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

              Container(height: 500, width: 400,child: ShowTables1()),
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
                    "100001",
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
