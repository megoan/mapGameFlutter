import 'dart:math';

import 'package:flutter/material.dart';
import 'package:map_game/models/pMarker.dart';
import 'package:map_game/providers/markerProvider.dart';
import 'package:provider/provider.dart';

import 'appColors.dart';

class MarkerDialog extends StatefulWidget {
  PMarker pMarker;
  MarkerDialog(this.pMarker);
  @override
  _MarkerDialogState createState() => _MarkerDialogState();
}

class _MarkerDialogState extends State<MarkerDialog> {
  int index = 0;
  Random random = new Random();
  ScrollController scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        contentPadding: EdgeInsets.all(0),
        backgroundColor: Colors.transparent,
        elevation: 5,
        content: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [AppColors.tGradientTop, AppColors.tGradientBottom], stops: [0.0, 1.0]),
              borderRadius: BorderRadius.all(
                Radius.circular(25.0),
              )),
          child: Column(
            children: <Widget>[
               SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    //new Text(widget.pMarker.name),
                    new Text("${widget.pMarker.name} בן ${widget.pMarker.fatherName}"),
                   // new Text(widget.pMarker.name),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                MarkerProvider.tehilimPerek[index],
                textDirection: TextDirection.rtl,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: Scrollbar(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: 200,
                          child: new Text(
                            MarkerProvider.tehilim[index],
                            maxLines: null,
                            textDirection: TextDirection.rtl,
                          ),
                        ),
                      ],
                    ),
                  ),
                                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      color: AppColors.tMainColor,
                      child: Row(
                        children: <Widget>[
                          Text(
                            "קראתי",
                            style: TextStyle(color: AppColors.tLightTextColor),
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Icon(
                            Icons.restaurant_menu,
                            color: AppColors.tHappyColor,
                          ),
                        ],
                      ),
                      onPressed: () {
                        setState(
                          () {
                            scrollController.animateTo(
                              0.0,
                              curve: Curves.easeOut,
                              duration: const Duration(milliseconds: 300),
                            );
                            index = ((index + 1) % 150);
                          },
                        );
                      }),
                  RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      color: AppColors.tMainColor,
                      child: Text(
                        "פרק אחר",
                        style: TextStyle(color: AppColors.tLightTextColor),
                      ),
                      onPressed: () {
                        setState(
                          () {
                            scrollController.animateTo(
                              0.0,
                              curve: Curves.easeOut,
                              duration: const Duration(milliseconds: 300),
                            );
                            index = random.nextInt(150);
                          },
                        );
                      }),
                ],
              )
            ],
          ),
        ));
  }
}
