import 'package:flutter/material.dart';
import 'package:tables24_v3/Rahul/dataStoring.dart';
import 'package:tables24_v3/Savio/functions/getRestaurantDetails.dart';
import 'package:tables24_v3/Savio/screens/bookingPage1.dart';
import 'package:tables24_v3/Savio/widgets/restaurantFeatures.dart';
import 'package:tables24_v3/Savio/widgets/starRating.dart';


class HomePage2 extends StatelessWidget {
  String resName;
  String resId;
  HomePage2(String this.resName, String this.resId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: FutureBuilder(
        future: getRestaurantDetails(resId),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          List snap1 = snapshot.data;

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
          print(snap1);
          currentUserAndRestaurantDetails['resLayout'] = "${snap1[0]['layout']}";
          print(currentUserAndRestaurantDetails["resLayout"]);
          snapForRestaurantDetails['snap1'] = snap1;
          return BookingPage3();
        },
      ),
    );
  }
}



class BookingPage3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget> [
        Positioned(
        top: 0,
        left: 0,
        child: Container(
          width: MediaQuery
              .of(context)
              .size
              .width,
          height: MediaQuery
              .of(context)
              .size
              .height / 2 + 15,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage('${snapForRestaurantDetails["snap1"][0]["images"][0]}'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      Positioned(
        bottom: MediaQuery
            .of(context)
            .size
            .height / 2 - 73,
        left: 0,
        child: Container(
          width: MediaQuery
              .of(context)
              .size
              .width,
          height: 100,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              gradient: LinearGradient(
                  colors: [Colors.red[900], Colors.red[600]],
                  begin: Alignment.topCenter
              )
          ),
        ),
      ),
      Positioned(
        bottom: 0,
        left: 0,
        child: Container(
          padding: EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 2 + 20,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(40.0),
                topLeft: Radius.circular(40.0)),
            color: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                  height: (MediaQuery.of(context).size.height / 2 - 40) / 5 + 3,
                  width: MediaQuery.of(context).size.width - 40,
                 // color: Colors.grey,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget> [Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget> [
                      Text('${snapForRestaurantDetails["snap1"][0]["res_name"]}', style: TextStyle(fontFamily: "Oxygen",fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),),
                      Text('${snapForRestaurantDetails["snap1"][0]["address"]}',style: TextStyle(fontFamily: "Oxygen",fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),),
              ],),
                  StarRatingBuilder(int.parse('${snapForRestaurantDetails["snap1"][0]["rating"]}')),
                    ],),
            ),
              RestaurantDetailsNavigator(),

        ],
      ),
    ),),
          Positioned(
            bottom: 10,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              //color: Colors.green,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget> [
                  FavouriteButton(),
                  BookNowButton(),
                ],
              ),
            ),
          )

        ]
    ,
    )
    ,

    );
  }
}



class RestaurantDetailsNavigator extends StatefulWidget {
  @override
  _RestaurantDetailsNavigatorState createState() => _RestaurantDetailsNavigatorState();
}

class _RestaurantDetailsNavigatorState extends State<RestaurantDetailsNavigator> {
  Widget currentPage;
  int currentPageNo;
  RestaurantDetailsCard restaurantDetailsCard;
  @override
  void initState(){
    super.initState();
    currentPage = RestaurantDetailsCard();
    currentPageNo = 1;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: (MediaQuery.of(context).size.height / 2 - 40) / 1.2,
      width: MediaQuery.of(context).size.width - 40,
      //color: Colors.red,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget> [
          Container(
            padding: EdgeInsets.all(5),
            height: 40,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              //color: Colors.grey,
              border: Border.all(color: Colors.black, width: 1, style: BorderStyle.solid),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget> [
                InkWell(
                    onTap: (){
                      setState(() {
                        currentPageNo = 1;
                        currentPage = RestaurantDetailsCard();
                      });
                    },
                    child: Text("Details", style: TextStyle(fontFamily: "Oxygen",fontSize: 20,color: (currentPageNo == 1)? Colors.red: Colors.black ))),
                VerticalDivider(width: 1, thickness: 1,color: Colors.black,),
                InkWell(
                    onTap: (){
                      setState(() {
                        currentPageNo = 2;
                        currentPage = RestaurantFeaturesCard();
                      });
                    },
                    child: Text("Features", style: TextStyle(fontFamily: "Oxygen",fontSize: 20,color: (currentPageNo == 2)? Colors.red: Colors.black))),
                VerticalDivider(width: 5, thickness: 1, color: Colors.black,),
                InkWell(
                    onTap: (){
                      setState(() {
                        currentPageNo = 3;
                        currentPage = RestaurantContactCard();
                      });
                    },
                    child: Text("Contact", style: TextStyle(fontFamily: "Oxygen",fontSize: 20, color: (currentPageNo == 3)? Colors.red: Colors.black))),

              ],
            ),

          ),
          currentPage,

        ],
      ),
    );
  }
}


class RestaurantDetailsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
      width: MediaQuery.of(context).size.width - 40,
      height: (MediaQuery.of(context).size.height / 2 - 40) / 1.2 - 40,
      //color: Colors.black,
      child: ListView(
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget> [
          Text("Description", style: TextStyle(fontFamily: "Oxygen", color: Colors.red[800],fontSize: 25, fontWeight: FontWeight.bold
          )),
          SizedBox(height: 10,),
          Text( '${snapForRestaurantDetails["snap1"][0]["description"]}',
              style: TextStyle(fontFamily: "Oxygen",fontSize: 20,)),
          SizedBox(height: 40,)
        ],
      ),

    );
  }
}


class RestaurantFeaturesCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
      width: MediaQuery.of(context).size.width - 40,
      height: (MediaQuery.of(context).size.height / 2 - 40) / 1.2 - 40,
      //color: Colors.black,
      child: ListView(
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget> [
          Text("Features", style: TextStyle(fontFamily: "Oxygen", color: Colors.red[800],fontSize: 25, fontWeight: FontWeight.bold
          )),
          SizedBox(height: 10,),
          Container(
            height: (MediaQuery.of(context).size.height / 2 - 40) / 1.2 - 84,
              width: MediaQuery.of(context).size.width - 40,
              child: FeaturesBuild('${snapForRestaurantDetails["snap1"][0]["features"]}')),
        ],
      ),

    );
  }
}


class RestaurantContactCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
      width: MediaQuery.of(context).size.width - 40,
      height: (MediaQuery.of(context).size.height / 2 - 40) / 1.2 - 40,
      //color: Colors.black,
      child: ListView(
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget> [
          Text("Contact", style: TextStyle(fontFamily: "Oxygen", color: Colors.red[800],fontSize: 25, fontWeight: FontWeight.bold
          )),
          SizedBox(height: 10,),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget> [
              Row(
                children: [
                  Icon(Icons.person, color: Colors.black,),
                  SizedBox(width: 10),
                  Text('${snapForRestaurantDetails["snap1"][0]["mangName"]}',
                    style: TextStyle(fontFamily: "Oxygen",fontSize: 20,)),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.location_on),
                  SizedBox(width: 10),
                  Text('${snapForRestaurantDetails["snap1"][0]["address"]}',
                      style: TextStyle(fontFamily: "Oxygen",fontSize: 20,)),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.mail),
                  SizedBox(width: 10),
                  Text('${snapForRestaurantDetails["snap1"][0]["mangEmail"]}',
                      style: TextStyle(fontFamily: "Oxygen",fontSize: 20,)),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.phone),
                  SizedBox(width: 10),
                  Text('${snapForRestaurantDetails["snap1"][0]["mangPhone"]}',
                      style: TextStyle(fontFamily: "Oxygen",fontSize: 20,)),
                ],
              ),


          ]),
          SizedBox(height: 40,)
        ],
      ),

    );
  }
}


class FavouriteButton extends StatefulWidget {
  @override
  _FavouriteButtonState createState() => _FavouriteButtonState();
}

class _FavouriteButtonState extends State<FavouriteButton> {
  bool state = true;
  @override
  void initState() {
    super.initState();
    if(checkResInFav())
      state = true;
    else
      state = false;
  }
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        setState(() {state = ! state;
      print("state = " + state.toString());
      if(state == true)
        addFavourite(1);
      else
        addFavourite(-1);
      });},
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 3 ),
          shape: BoxShape.circle,
          boxShadow: [BoxShadow(color: Colors.black,
            offset: new Offset(-3.0, 3.0),
            blurRadius: 5.0,) ],
          color: Colors.white,
        ),
        child: (state)? Icon(Icons.favorite, color: Colors.red[800], size: 30,) : Icon(Icons.favorite_border, size: 30),
      ),
    );
  }
}


class BookNowButton extends StatefulWidget {
  @override
  _BookNowButtonState createState() => _BookNowButtonState();
}

class _BookNowButtonState extends State<BookNowButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        String temp = '${snapForRestaurantDetails["snap1"][0]["res_name"]}';
        String temp1 = '${snapForRestaurantDetails["snap1"][0]["restaurant_id"]}';
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BookingPage1(temp, temp1)),
        );

      },
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width / 1.5 + 30,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            border: Border.all(color: Colors.black, width: 3),
            boxShadow: [BoxShadow(color: Colors.black,
              offset: new Offset(-3.0, 3.0),
              blurRadius: 5.0,) ],
            gradient: LinearGradient(
              colors: [Colors.red[900], Colors.red[700]],
              begin: Alignment.topCenter,
            )
        ),
        alignment: Alignment(0, 0),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.shopping_cart, size: 40, color: Colors.white),
              SizedBox(width: 10,),
              Text("Book Now", style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
              )]),

      ),
    );
  }
}


class FeaturesBuild extends StatelessWidget {
  String features;
  List featuresList;

  FeaturesBuild(String this.features) {
    features = features.replaceAll('[', '');
    features = features.replaceAll(']', '');
    features = features.replaceAll('\'', '');
    this.featuresList = features.split(', ');
    print("the features are" + featuresList.toString());
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: featuresList.length,
        itemBuilder: (context, index) {
          IconData iconName = getIcon(featuresList[index]);
          return Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(iconName),
                  SizedBox(width: 10,),
                  Text(featuresList[index], style: TextStyle(fontSize: 20, fontFamily: "Oxygen"),)
                ],
              ),
          );
        });
  }
}

