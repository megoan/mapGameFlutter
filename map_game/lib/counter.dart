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
          if (!snapshot.hasData) return new Text('Loading...', style: TextStyle(fontSize: 18, color: AppColors.tHappyColor));
          return new Text( snapshot.data.documents[0]["readNum"].toString(), style: TextStyle(fontSize: 18, color: AppColors.tHappyColor));
         
        });
  }
}