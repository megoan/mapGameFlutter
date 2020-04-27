import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HelpMe extends StatefulWidget {
  @override
  _HelpMeState createState() => _HelpMeState();
}

class _HelpMeState extends State<HelpMe> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(icon: Icon(FontAwesomeIcons.shieldAlt), onPressed: (){
            
          })
          
        ],
        centerTitle: true,
        title: Text("תהילים עולמי"),
        leading: CircleAvatar(
          radius: 10,
          backgroundColor: Colors.transparent,
          child: Image.asset(
            "assets/ic_launcher.png",
            width: 40,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(label: Text("עזרו לתחזוק האפליקציה"),onPressed: (){
        
      },icon: Icon(FontAwesomeIcons.ccPaypal,size: 35,),),
      body:
          //textDirection: TextDirection.rtl,
          Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "!תודה",
              style: TextStyle(color: Colors.black38, fontSize: 20),
            ),
            Text(
              "!תודה שאתם קוראים תהילים",
              style: TextStyle(color: Colors.black38, fontSize: 20),
            ),
            Text(
              "!תודה שאכפת לכם",
              style: TextStyle(color: Colors.black38, fontSize: 20),
            )
          ],
        ),
      ),
    );
  }
}
