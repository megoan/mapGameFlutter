import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:map_game/models/pMarker.dart';
import 'package:map_game/providers/markerProvider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'appColors.dart';
import 'azkara.dart';

class MarkerDialog extends StatefulWidget {
  PMarker pMarker;
  MarkerDialog(this.pMarker);
  @override
  _MarkerDialogState createState() => _MarkerDialogState();
}

class _MarkerDialogState extends State<MarkerDialog> {
  List prakim = [
    "א",
    "ב",
    "ג",
    "ד",
    "ה",
    "ו",
    "ז",
    "ח",
    "ט",
    "י",
    "יא",
    "יב",
    "יג",
    "יד",
    "טו",
    "טז",
    "יז",
    "יח",
    "יט",
    "כ",
    "כא",
    "כב",
    "כג",
    "כד",
    "כה",
    "כו",
    "כז",
    "כח",
    "כט",
    "ל",
    "לא",
    "לב",
    "לג",
    "לד",
    "לה",
    "לו",
    "לז",
    "לח",
    "לט",
    "מ",
    "מא",
    "מב",
    "מג",
    "מד",
    "מה",
    "מו",
    "מז",
    "מח",
    "מט",
    "נ",
    "נא",
    "נב",
    "נג",
    "נד",
    "נה",
    "נו",
    "נז",
    "נח",
    "נט",
    "ס",
    "סא",
    "סב",
    "סג",
    "סד",
    "סה",
    "סו",
    "סז",
    "סח",
    "סט",
    "ע",
    "עא",
    "עב",
    "עג",
    "עד",
    "עה",
    "עו",
    "עז",
    "עח",
    "עט",
    "פ",
    "פא",
    "פב",
    "פג",
    "פד",
    "פה",
    "פו",
    "פז",
    "פח",
    "פט",
    "צ",
    "צא",
    "צב",
    "צג",
    "צד",
    "צה",
    "צו",
    "צז",
    "צח",
    "צט",
    "ק",
    "קא",
    "קב",
    "קג",
    "קד",
    "קה",
    "קו",
    "קז",
    "קח",
    "קט",
    "קי",
    "קיא",
    "קיב",
    "קיג",
    "קיד",
    "קטו",
    "קטז",
    "קיז",
    "קיח",
    "קיט",
    "קכ",
    "קכא",
    "קכב",
    "קכג",
    "קכד",
    "קכה",
    "קכו",
    "קכז",
    "קכח",
    "קכט",
    "קל",
    "קלא",
    "קלב",
    "קלג",
    "קלד",
    "קלה",
    "קלו",
    "קלז",
    "קלח",
    "קלט",
    "קמ",
    "קמא",
    "קמב",
    "קמג",
    "קמד",
    "קמה",
    "קמו",
    "קמז",
    "קמח",
    "קמט",
    "קנ",
  ];
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  int index = 0;
  Random random = new Random();
  ScrollController scrollController = new ScrollController();
  bool isInit = true;
  SharedPreferences prefs;
  bool justRead = false;
  @override
  void didChangeDependencies() async {
    if (isInit) {
      prefs = await _prefs;
    }
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        width: 200,
                        child: new Text(
                          "${widget.pMarker.fullName}",
                          textAlign: TextAlign.center,
                        )),
                    //new Text("${widget.pMarker.fullName}"),
                    // new Text(widget.pMarker.name),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  IconButton(
                      icon: FaIcon(
                        FontAwesomeIcons.expandArrowsAlt,
                        color: AppColors.tMainColor,
                      ),
                      onPressed: () {
                        if (MarkerProvider.fontSize < 60) {
                          setState(() {
                            MarkerProvider.fontSize += 2;
                            prefs.setDouble("fontSize", MarkerProvider.fontSize);
                          });
                        }
                      }),
                  IconButton(
                      icon: FaIcon(
                        FontAwesomeIcons.compressArrowsAlt,
                        color: AppColors.tMainColor,
                      ),
                      onPressed: () {
                        if (MarkerProvider.fontSize > 0) {
                          setState(() {
                            MarkerProvider.fontSize -= 2;
                            prefs.setDouble("fontSize", MarkerProvider.fontSize);
                          });
                        }
                      }),
                  IconButton(
                      icon: FaIcon(
                        FontAwesomeIcons.font,
                        color: AppColors.tMainColor,
                      ),
                      onPressed: () {
                        setState(() {
                          MarkerProvider.fIndex = (MarkerProvider.fIndex + 1) % MarkerProvider.fonts.length;
                          prefs.setInt("fIndex", MarkerProvider.fIndex);
                        });
                      })
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: AppColors.tMainColor,
                      ),
                      onPressed: () {
                        setState(() {
                          index = ((index + 1) % 150);
                        });
                      }),
                  Text(
                    MarkerProvider.tehilimPerek[index],
                    textDirection: TextDirection.rtl,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: MarkerProvider.fontSize, fontFamily: MarkerProvider.fonts[MarkerProvider.fIndex]),
                  ),
                  IconButton(
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        color: AppColors.tMainColor,
                      ),
                      onPressed: () {
                        setState(() {
                          if (index - 1 == 0) {
                            index = 149;
                          } else {
                            index = ((index - 1).abs() % 150);
                          }
                        });
                      }),
                ],
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
                              style: TextStyle(fontSize: MarkerProvider.fontSize, fontFamily: MarkerProvider.fonts[MarkerProvider.fIndex]),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  color: AppColors.tMainColor,
                  child: Text(
                    "חפש פרק",
                    style: TextStyle(color: AppColors.tLightTextColor),
                  ),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                              // contentPadding: EdgeInsets.all(0),
                              // backgroundColor: Colors.transparent,
                              // elevation: 5,
                              title: Text(
                                "בחר פרק",
                                textAlign: TextAlign.center,
                              ),
                              content: Directionality(
                                textDirection: TextDirection.rtl,
                                child: Container(
                                  // decoration: BoxDecoration(
                                  //     gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [AppColors.tGradientTop, AppColors.tGradientBottom], stops: [0.0, 1.0]),
                                  //     borderRadius: BorderRadius.all(
                                  //       Radius.circular(25.0),
                                  //     )),
                                  width: MediaQuery.of(context).size.width * .8,
                                  child: GridView.count(
                                    mainAxisSpacing: 10,
                                    crossAxisSpacing: 10,
                                    crossAxisCount: 4,
                                    children: List.generate(150, (index) {
                                      return RaisedButton(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        color: AppColors.tMainColor,
                                        onPressed: () {
                                          Navigator.pop(context, [index]);
                                        },
                                        child: Center(
                                          child: Text(
                                            prakim[index],
                                            style: TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      );
                                    }),
                                  ),
                                ),
                              ),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text(
                                    "ביטול",
                                    style: TextStyle(color: AppColors.tMainColor, fontWeight: FontWeight.bold),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                )
                              ],
                            )).then((onValue) {
                      if (onValue != null && onValue.length > 0) {
                        setState(() {
                          scrollController.animateTo(
                            0.0,
                            curve: Curves.easeOut,
                            duration: const Duration(milliseconds: 300),
                          );
                          index = onValue[0];
                        });
                      }
                    });
                    // setState(
                    //   () {
                    //     scrollController.animateTo(
                    //       0.0,
                    //       curve: Curves.easeOut,
                    //       duration: const Duration(milliseconds: 300),
                    //     );
                    //     index = random.nextInt(150);
                    //   },
                    // );
                  }),
              SizedBox(
                height: 20,
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
                        ],
                      ),
                      onPressed: (!justRead)
                          ? () {
                              justRead = true;
                              Future.delayed(Duration(seconds: 5), () {
                                setState(() {
                                  justRead = false;
                                });
                              });
                              final DocumentReference postRef = Firestore.instance.collection('mainInfo').document('VMJmDoyA9cVBJ8eyOVSo');
                              Firestore.instance.runTransaction((Transaction tx) async {
                                DocumentSnapshot postSnapshot = await tx.get(postRef);
                                if (postSnapshot.exists) {
                                  await tx.update(postRef, <String, dynamic>{'readNum': postSnapshot.data['readNum'] + 1});
                                }
                              });

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
                            }
                          : null),
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
              ),
              SizedBox(
                height: 10,
              ),
              // RaisedButton(
              //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30), side: BorderSide(color: AppColors.tMainColor, width: 2)),
              //   onPressed: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(builder: (context) => Azkara()),
              //     );
              //   },
              //   child: Padding(
              //     padding: const EdgeInsets.all(8.0),
              //     child: Text("תהילים לאזכרה"),
              //   ),
              //   color: Colors.white,
              // ),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ));
  }
}
