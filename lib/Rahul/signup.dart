import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,

    home: SignupPage(),
  )
  );
}

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => new _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {


  TextEditingController cust_name = TextEditingController();
  TextEditingController cust_email = TextEditingController();
  TextEditingController cust_pass = TextEditingController();
  TextEditingController phone_number = TextEditingController();






  void register()async {
    var url = "https://tables24.000webhostapp.com/Rahul/regg.php";
    var data =  {
      "cust_email" : cust_name.text,
      "cust_pass" : cust_email.text,
      "cust_name" : cust_pass.text,
      "phone_number" : phone_number.text,

    };
    var response  = await http.post(url, body: data);

    var responsebody = jsonDecode(response.body);


    /*if (responsebody[0]['status'] == "failed") {
      Fluttertoast.showToast(
          msg: "This user already exists",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );


    }
    else{
      Fluttertoast.showToast(
          msg: "Registration Successful",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );


    };*/

    print(responsebody);
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

                  Text("  Continue by Signing Up,", style: TextStyle(color: Colors.white, fontFamily:'Itim',fontWeight:FontWeight.bold,fontSize: 29),),
                  SizedBox(height: 10,),


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
                    SizedBox(height: 20),
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
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(color: Colors.grey[200]))
                            ),
                            child: TextFormField(
                              controller: cust_name,

                              decoration: InputDecoration(
                                hintText: "Name",
                                hintStyle: TextStyle(color: Colors.grey),
                                border: InputBorder.none,
                              ),
                            ),
                          ),

                          Container(
                            padding: EdgeInsets.all(6),
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
                            padding: EdgeInsets.all(6),
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

                          Container(
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(color: Colors.grey[200]))
                            ),
                            child: TextField(
                              controller: phone_number,
                              decoration: InputDecoration(
                                hintText: "Phone Number",
                                hintStyle: TextStyle(color: Colors.grey),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 40),

                    Row(
                      children: <Widget>[
                        Expanded(
                            child: MaterialButton(
                              height: 50,
                              color: Colors.red[600],
                              child: Text(
                               'Register',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                              onPressed: (){
                                register();
                              },

                            ))
                      ],


                     /* height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.red[600],

                      ),*/

                     /* child: Container(

                        child: InkWell(
                          onTap: (){
                           register();
                          },



                          child :
                          Center(
                            child: Text("Sign Up", style: TextStyle(color: Colors.white,fontSize: 16, fontWeight: FontWeight.bold),),
                          ),
                        ),
                      ),*/
                    ),



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
    );;
  }
}

