import 'package:flutter/material.dart';
import 'package:tables24_v3/Rohan/confirm_list.dart';
import 'package:tables24_v3/Rohan/manager_account.dart';
import 'package:tables24_v3/Rohan/pending_list.dart';

class ManagerScreen extends StatefulWidget {
  @override
  _ManagerScreenState createState() => _ManagerScreenState();
}

class _ManagerScreenState extends State<ManagerScreen> {
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    ConfirmList(),
    PendingList(),
    ManagerAccount(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
//        physics: NeverScrollableScrollPhysics(),
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.confirmation_number,
            ),
            title: Text(
              'Confirmed',
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.query_builder),
            title: Text('Pending'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            title: Text('Account'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
      ),
    );
  }
}
