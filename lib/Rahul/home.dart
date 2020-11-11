import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tables24_v3/Rahul/constants.dart';
import 'package:tables24_v3/Rahul/dataStoring.dart';
import 'package:tables24_v3/Rahul/res_card.dart';
import 'package:tables24_v3/Rahul/res_card1.dart';
import 'package:tables24_v3/Rahul/res_view.dart';
import 'package:http/http.dart' as http;
import 'package:tables24_v3/Rahul/userProfile.dart';
import 'dart:convert';

import 'package:tables24_v3/Savio/screens/allReservations.dart';
import 'package:tables24_v3/Savio/screens/bookingPage1.dart';
import 'package:tables24_v3/Savio/screens/bookingPage3.dart';
import 'package:tables24_v3/Savio/screens/homePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: "Poppins",
          scaffoldBackgroundColor: kWhiteColor,
          primaryColor: kPrimaryColor,
          textTheme: TextTheme(
            headline: TextStyle(
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                fontFamily: "Oxygen",
                fontSize: 29),
            button: TextStyle(fontWeight: FontWeight.bold),
          )),
      home: FirstScreen1(),
    );
  }
}

class FirstScreen1 extends StatefulWidget {
  @override
  _FirstScreen1State createState() => _FirstScreen1State();
}

class _FirstScreen1State extends State<FirstScreen1> {
  int currentTabIndex = 0;
  List<Widget> pages;
  Widget currentPage;

  AllReservationsPage allReservationsPage;
  HomePage homePage;
  UserProfile userProfile;

  @override
  void initState() {
    super.initState();
    homePage = HomePage();
    allReservationsPage = AllReservationsPage();
    userProfile = UserProfile();
    pages = [homePage, allReservationsPage, userProfile];

    currentPage = homePage;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int index) {
          setState(() {
            currentTabIndex = index;
            currentPage = pages[index];
          });
        },
        currentIndex: currentTabIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            title: Text("HOME"),
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            title: Text("MY BOOKINGS"),
            icon: Icon(Icons.bookmark_border),
          ),
          BottomNavigationBarItem(
            title: Text("PROFILE"),
            icon: Icon(Icons.person),
          ),
        ],
      ),
      body: currentPage,
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var listsearch = [];

  Future getData() async {
    var url = "https://tables24.000webhostapp.com/Rahul/getRestaurants.php";
    var response = await http.get(url);
    var responsebody = jsonDecode(response.body);
    for (int i = 0; i < responsebody.length; i++) {
      listsearch.add(responsebody[i]['res_name']);
    }
    print(listsearch);
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Material(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 20, top: 50),
            child: Align(
              alignment: Alignment.topRight,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text("Where would you\n like to eat",
                style: TextStyle(
                    fontSize: 29,
                    fontStyle: FontStyle.italic,
                    fontFamily: "Oxygen",
                    fontWeight: FontWeight.w800)),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: <Widget>[
                CategoryTitle(title: "Indian"),
                CategoryTitle(title: "Arabian"),
                CategoryTitle(title: "Continental"),
                CategoryTitle(title: "Chinese"),
              ],
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            height: 45,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Color(0xFFDDDDDD)),
            ),
            child: TextField(
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 30.0, vertical: 9.0),
                  hintText: "Search Restaurants",
                  suffixIcon: Icon(Icons.search),
                  border: InputBorder.none,
                ),
                onChanged: (text) {
                  showSearch(
                      context: context, delegate: DataSearch(list: listsearch));
                }),
          ),
          ResCard(),
          /* Expanded(

                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: resList.length,


                    itemBuilder: (context, index) {
                    return resCard(resList[index]);
      },
              ),






              ),*/
        ],
      ),
    );
  }
}

class resCard1 extends StatelessWidget {
  final String res;
  final String image;

  resCard1(this.res, this.image);

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.topCenter, children: <Widget>[
      Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          width: (MediaQuery.of(context).size.width / 2) * 5.2,
          height: (MediaQuery.of(context).size.height / 2) * 0.7,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(this.image), fit: BoxFit.cover),
          ),
        ),
      ),
      Positioned(
        top: (MediaQuery.of(context).size.height / 2) * 0.40,
        child: Card(
          clipBehavior: Clip.antiAlias,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          child: Container(
            padding: EdgeInsets.only(top: 10, left: 80, right: 50),
            width: (MediaQuery.of(context).size.width / 1.50),
            height: (MediaQuery.of(context).size.height / 2) * 0.33,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  res,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w700),
                ),
                Container(
                  width: double.infinity,
                  height: 15,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        if (index < 4) {
                          return Icon(
                            Icons.star,
                            color: Colors.orange,
                            size: 15,
                          );
                        }
                        return Icon(
                          Icons.star,
                          color: Colors.grey,
                          size: 15,
                        );
                      }),
                ),
                SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  height: 30,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 3, vertical: 2),
                        padding:
                            EdgeInsets.symmetric(horizontal: 3, vertical: 2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(1),
                          color: Colors.red,
                        ),
                        child: Text(
                          res,
                          style: TextStyle(color: Colors.white, fontSize: 13),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      )
    ]);
  }
}

class resCard extends StatelessWidget {
  final String res;
  final String image;
  final String resId;
  final String cuisine;
  final int rating;

  resCard(this.res, this.image, this.resId, this.cuisine, this.rating);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        currentUserAndRestaurantDetails['resId'] = resId;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage2(res, resId)),
        );
      },
      child: Stack(alignment: Alignment.topCenter, children: <Widget>[
        Card(
          clipBehavior: Clip.antiAlias,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          child: Container(
            width: (MediaQuery.of(context).size.width / 2) * 1.2,
            height: (MediaQuery.of(context).size.height / 2) * 0.7,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(this.image), fit: BoxFit.cover),
            ),
          ),
        ),
        Positioned(
          top: (MediaQuery.of(context).size.height / 2) * 0.5,
          child: Card(
            clipBehavior: Clip.antiAlias,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Container(
              padding: EdgeInsets.all(10),
              width: (MediaQuery.of(context).size.width / 2),
              height: (MediaQuery.of(context).size.height / 2) * 0.33,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    res,
                    style: kBlackSmall,
                  ),
                  Container(
                    width: double.infinity,
                    height: 15,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          if (rating > index) {
                            return Icon(
                              Icons.star,
                              color: Colors.orange,
                              size: 15,
                            );
                          }
                          return Icon(
                            Icons.star,
                            color: Colors.grey,
                            size: 15,
                          );
                        }),
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    height: 30,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        return Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: 3, vertical: 2),
                          padding:
                              EdgeInsets.symmetric(horizontal: 3, vertical: 2),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.red,
                          ),
                          child: Text(
                            cuisine,
                            style: TextStyle(color: Colors.white, fontSize: 13),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ]),
    );
  }
}

class CategoryTitle extends StatelessWidget {
  final String title;
  final bool active;

  const CategoryTitle({
    Key key,
    this.active = false,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 30),
      child: Text(
        title,
        style: Theme.of(context).textTheme.button.copyWith(
              color: active ? kPrimaryColor : kTextColor.withOpacity(.4),
            ),
      ),
    );
  }
}

class CustomBar extends StatefulWidget {
  @override
  _CustomBarState createState() => _CustomBarState();
}

class _CustomBarState extends State<CustomBar> {
  int currentTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentTabIndex,
      onTap: (index) {
        setState(() {
          currentTabIndex = index;
          dataRequired['currentTabIndex'] = index;
          dataRequired['currentPage'] = dataRequired['pages'][index];
        });
      },
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.red,
      unselectedItemColor: Colors.grey,
      showSelectedLabels: true,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          title: Text("HOME"),
          icon: Icon(Icons.home),
        ),
        BottomNavigationBarItem(
          title: Text("MY BOOKINGS"),
          icon: Icon(Icons.bookmark_border),
        ),
        BottomNavigationBarItem(
          title: Text("PROFILE"),
          icon: Icon(Icons.person),
        ),
      ],
    );
  }
}

class DataSearch extends SearchDelegate<String> {
  List<dynamic> list;

  DataSearch({this.list});

  Future getsearchdata() async {
    var url = "https://tables24.000webhostapp.com/Rahul/searchres.php";
    var data = {"searchrestaurant": query};
    var response = await http.post(url, body: data);
    var responsebody = jsonDecode(response.body);
    return responsebody;
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = "";
        },
        icon: Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(
        future: getsearchdata(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            List snap1 = snapshot.data;
            return ListView.builder(
                itemCount: snap1.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: (){
                      currentUserAndRestaurantDetails['resId'] = '${snap1[index]['resId']}';
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage2('${snap1[index]['resName']}', '${snap1[index]['resId']}')),
                      );
                    },
                      child: resCard1('${snap1[index]['resName']}',
                          '${snap1[index]['image']}'));
                });
          }
          return Center(child: CircularProgressIndicator());
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    var searchList =
        query.isEmpty ? list : list.where((p) => p.startsWith(query)).toList();
    return ListView.builder(
        itemCount: searchList.length,
        itemBuilder: (context, i) {
          return ListTile(
            leading: Icon(Icons.mobile_screen_share),
            title: Text(searchList[i]),
            onTap: () {
              query = searchList[i];
              showResults(context);
            },
          );
        });
  }
}
