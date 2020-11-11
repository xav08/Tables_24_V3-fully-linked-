import 'package:flutter/material.dart';
import 'package:tables24_v3/Rohan/pending_cancel.dart';
import 'pending_cancel.dart';
import 'pending_new.dart';

class PendingList extends StatefulWidget {
  @override
  _PendingListState createState() => _PendingListState();
}

class _PendingListState extends State<PendingList> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Pending Reservations'),
            backgroundColor: Colors.orange[500],
            bottom: TabBar(
              tabs: <Widget>[
                Tab(
                  icon: Icon(Icons.new_releases),
                  text: 'New Bookings',
                ),
                Tab(
                  icon: Icon(Icons.cancel),
                  text: 'Cancelled Bookings',
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              PendingNew(),
              PendingCancel(),
            ],
          ),
        ),
      ),
    );
  }
}
