import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

String dateSub;

class ConfirmList extends StatefulWidget {
  @override
  _ConfirmListState createState() => _ConfirmListState();
}

class _ConfirmListState extends State<ConfirmList> {
  confirmList(String mang_id, String date) async {
    String theUrl = 'https://tables24.000webhostapp.com/Rohan/confirmList.php';
    var res = await http.post(Uri.encodeFull(theUrl),
        headers: {"Accept": "application/json"},
        body: {"mang_id": mang_id, "date": date});
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
        title: Text("Reservations"),
      ),
      body: new Builder(
        builder: (BuildContext context) {
          DateTime date;
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: FlatButton(
                  onPressed: () {
                    DatePicker.showDatePicker(context,
                        showTitleActions: true,
                        minTime: DateTime(2018),
                        maxTime: DateTime(2022), onChanged: (date) {
                      print('change $date');
                    }, onConfirm: (date) {
                      String dateString = date.toString();
                      List dateList = dateString.split(' ');
                      dateSub = dateList[0];
                      print('$dateSub');
                      setState(() {
                        confirmList('400001',
                            dateSub); //TODO: Chage mang_id to value from user ID
                      });
                      ;
                    }, currentTime: DateTime.now(), locale: LocaleType.en);
                  },
                  child: Text(
                    'Select Date',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 9,
                child: FutureBuilder(
                  future: confirmList('400001',
                      '$dateSub'), //TODO: Change hardcoded value to mang_id received from login
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
                          'No Reservations made for $dateSub',
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
                        var dateTime =
                            snap[index]['booked_date_time'].split(' ');
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
                                    Text(
                                        'Table ID : ${snap[index]['table_id']}'),
                                    Text('Date: $date'),
                                    Text('Time: $time'),
                                  ],
                                ),
                                SizedBox(
                                  width: 15.0,
                                ),
                                Text(
                                  'STATUS: ',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '${snap[index]['status']}',
                                  style: TextStyle(
                                    color: ('${snap[index]['status']}' ==
                                            'confirmed')
                                        ? Colors.green
                                        : Colors.red,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
