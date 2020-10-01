import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:we_q/loginscreen.dart';
import 'package:we_q/main.dart';
import 'package:we_q/shops.dart';
void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  home: signup(),
));
class signup extends StatefulWidget {
  @override
  _signupState createState() => _signupState();
}

class _signupState extends State<signup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Container(
            height: 350,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image:AssetImage("assets/images/undraw_lost_online_wqob.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 12,),
          Container(child: Text("SIGN UP",style: TextStyle(fontSize: 20),),),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(196, 135, 198, 0.7),
                      blurRadius: 20,
                      offset: Offset(0,10),
                    )
                  ]
              ),
              child: Column(
                children: <Widget>[
                  Container(height:40,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                            color: Colors.grey[200]
                        ),
                      ),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Username",
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                  Container(height:40,
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Password",
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                  Container(height:40,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                            color: Colors.grey[200]
                        ),
                      ),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Confirm Password",
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10,),
          Container(
            height: 40,
            margin: EdgeInsets.symmetric(horizontal: 70),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: Color.fromRGBO(49, 39, 79, 1),
            ),
            child: Center(child: FlatButton(child:
            Text("REGISTER",style: TextStyle(color: Colors.white),),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)
                {
                  return shops();
                }));
              },
            ),
            ),
          ),
          Center(child: FlatButton(
            child: Text("ALREADY REGISTERED",style: TextStyle(color:Color.fromRGBO(150, 39, 79, 2),fontSize: 14,fontWeight: FontWeight.bold ),),
            onPressed: ()
            {
              Navigator.push(context, MaterialPageRoute(builder: (context)
              {
                return Homepage();
              }));
            },
          ),
          ),
        ],
      ),
    );
  }
}
