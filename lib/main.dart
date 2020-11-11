import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:tables24_v3/Rahul/dataStoring.dart';
import 'package:tables24_v3/Rahul/home.dart';
import 'package:tables24_v3/Rahul/manlog.dart';
import 'package:tables24_v3/Rahul/signup.dart';
import 'package:tables24_v3/Rahul/welcome.dart';
import 'package:tables24_v3/Rahul/manlog.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tables24_v3/Rohan/manager_screen.dart';
import 'package:tables24_v3/Savio/screens/bookingPage3.dart';
import 'package:tables24_v3/Savio/screens/firstScreen.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    routes: <String, WidgetBuilder>{
      '/signup': (BuildContext context) => new SignupPage(),
      '/manlogin': (BuildContext context) => new ManLogPage(),
    },
    home: LoadScreen(),// BookingPage3(),
  )
  );
}


class LoadScreen extends StatefulWidget {
  @override
  _LoadScreenState createState() => _LoadScreenState();
}

class _LoadScreenState extends State<LoadScreen> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      routeName: "/",
      seconds: 7,
      backgroundColor: Colors.white,
      image: Image.asset('images/logo.png'),
      loaderColor: Colors.red,
      photoSize: 150.0,
      navigateAfterSeconds: LogPage(),

    );
  }
}



class LogPage extends StatefulWidget {
  @override
  _LogPageState createState() => _LogPageState();
}

class _LogPageState extends State<LogPage> {
  TextEditingController cust_email = TextEditingController();
  TextEditingController formstatesignin = TextEditingController();
  TextEditingController formstatesignup = TextEditingController();
  TextEditingController cust_pass = TextEditingController();

  Future login()async{

    var data = {"cust_email" : cust_email.text, "cust_pass" : cust_pass.text};
    var url = "https://tables24.000webhostapp.com/Rahul/login3.php";
    var response  = await http.post(url, body: data);
    var responsebody = jsonDecode(response.body);
    print(responsebody);
    if (responsebody[0]['status'] == "success"){
      print(responsebody[0]['cust_name']);
      currentUserAndRestaurantDetails["custId"] = responsebody[0]["cust_id"];
      currentUserAndRestaurantDetails["custName"] = responsebody[0]["cust_name"];
      currentUserAndRestaurantDetails["custEmail"] = responsebody[0]["cust_email"];
      currentUserAndRestaurantDetails["custPhone"] = responsebody[0]["phone_number"];
      currentUserAndRestaurantDetails['favourites'] = responsebody[0]['favourites'];
      print("currently used customer id is " + currentUserAndRestaurantDetails["custId"]);
      print(currentUserAndRestaurantDetails);

      Fluttertoast.showToast(
          msg: "LOGIN SUCCESSFUL",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );
      Navigator.push(context, MaterialPageRoute(builder: (context)=> FirstScreen1()));

    }




    else{
      Fluttertoast.showToast(
          msg: "INCORRECT USERNAME OR PASSWORD",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    };



  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                colors: [
                  Colors.red[800],
                  Colors.red[500],
                  Colors.red[400]
                ]

            )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 80,),
            Padding(padding: EdgeInsets.all(20),
              child: Column(
                children: <Widget>[

                  Text("  Welcome,", style: TextStyle(color: Colors.white, fontFamily:'Itim',fontWeight:FontWeight.bold,fontSize: 29),),
                  SizedBox(height: 10,),
                  Text("     Log in to continue", style: TextStyle(color: Colors.white, fontSize: 18),),

                ],
              ),),
            SizedBox(height: 20),

            Expanded(child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(60),topRight: Radius.circular(60)),

              ),
              child: Padding(padding: EdgeInsets.all(30),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 60),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [BoxShadow(
                            color: Color.fromRGBO(225, 95, 27, 3),
                            blurRadius: 20,
                            offset: Offset(0, 10),

                          )]
                      ),

                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(color: Colors.grey[200]))
                            ),
                            child: TextField(
                              controller: cust_email,
                              decoration: InputDecoration(
                                hintText: "Email",
                                hintStyle: TextStyle(color: Colors.grey),
                                border: InputBorder.none,
                              ),
                            ),
                          ),

                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(color: Colors.grey[200]))
                            ),
                            child: TextFormField(
                              obscureText: true,
                              controller: cust_pass,
                              decoration: InputDecoration(
                                hintText: "Password",
                                hintStyle: TextStyle(color: Colors.grey),
                                border: InputBorder.none,


                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 40),


                    Container(
                      height: 50.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.red[600],
                      ),

                      child: Container(

                        child: InkWell(
                          onTap: () {
                            login();
                          },
                          child :
                          Center(
                            child: Text("Log in", style: TextStyle(color: Colors.white,fontSize: 16, fontWeight: FontWeight.bold),),
                          ),
                        ),
                      ),
                    ),


                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'New to this app?',
                          style: TextStyle(fontFamily: 'Montserrat',fontSize: 15),
                        ),
                        SizedBox(width: 5.0),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed('/signup');
                          },
                          child: Text(
                            'Register',
                            style: TextStyle(
                                color: Colors.green,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                decoration: TextDecoration.underline),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height:10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Manager?',
                          style: TextStyle(fontFamily: 'Montserrat',fontSize: 15),
                        ),
                        SizedBox(width: 5.0),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed('/manlogin');
                          },
                          child: Text(
                            'Log In Here',
                            style: TextStyle(
                                color: Colors.orange,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                decoration: TextDecoration.underline),
                          ),
                        )
                      ],
                    ),









                  ],
                ),)
              ,))

          ],
        ),
      ),
    );
  }
}

