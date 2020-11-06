import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tables24_v3/Rahul/welcome.dart';
import 'package:tables24_v3/Rohan/manager_screen.dart';
import 'signup.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'home.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,

    home: ManLogPage(),
  )
  );
}


class ManLogPage extends StatefulWidget {
  @override
  _ManLogPageState createState() => _ManLogPageState();
}

class _ManLogPageState extends State<ManLogPage> {
  TextEditingController mang_email = TextEditingController();
  TextEditingController formstatesignin = TextEditingController();
  TextEditingController formstatesignup = TextEditingController();
  TextEditingController mang_pass = TextEditingController();

  Future login()async{

    var data = {"mang_email" : mang_email.text, "mang_pass" : mang_pass.text};
    var url = "https://tables24.000webhostapp.com/Rahul/logman.php";
    var response  = await http.post(url, body: data);
    var responsebody = jsonDecode(response.body);
    print(responsebody);
    if (responsebody[0]['status'] == "success"){
      print(responsebody[0]['cust_name']);

      Fluttertoast.showToast(
          msg: "LOGIN SUCCESSFUL",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );
      Navigator.push(context, MaterialPageRoute(builder: (context)=> ManagerScreen()));

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
                  Colors.orange[800],
                  Colors.orange[500],
                  Colors.orange[400]
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
                  Text("     Log in to continue as a Manager", style: TextStyle(color: Colors.white, fontSize: 18),),

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
                              controller: mang_email,
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
                              controller: mang_pass,
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

                    SizedBox(height: 15),
                    Text("", style: TextStyle(color: Colors.grey),),
                    SizedBox(height: 30),
                    Container(
                      height: 50.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.orange[600],
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
                    Container(
                      height: 50.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.red[600],
                      ),

                      child: Container(

                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child :
                          Center(
                            child: Text("Back", style: TextStyle(color: Colors.white,fontSize: 16, fontWeight: FontWeight.bold),),
                          ),
                        ),
                      ),
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

