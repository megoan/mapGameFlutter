import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'appColors.dart';



class CounterText extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('mainInfo').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return new Text('טוען...', style: TextStyle(fontSize: 20, color: Colors.white));
          return new Text( snapshot.data.documents[0]["readNum"].toString(), style: TextStyle(fontSize: 26, color: AppColors.tLightTextColor));
         
        });
  }
}
