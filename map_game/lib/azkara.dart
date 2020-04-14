import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:map_game/appColors.dart';
import 'package:map_game/providers/markerProvider.dart';
import 'package:provider/provider.dart';

class Azkara extends StatefulWidget {
  @override
  _AzkaraState createState() => _AzkaraState();
}

class _AzkaraState extends State<Azkara> {
  TextEditingController otiotController = new TextEditingController();

  List<String> letters = [];
  List<String> fonts = ["Roboto","Shofar", "Ezra", "Alef"];
  int index=0;
  double fontSize = 18;
  @override
  Widget build(BuildContext context) {
    MarkerProvider markerProvider = Provider.of<MarkerProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.tMainColor,
        title: Text("תהילים לאזכרה"),
        actions: <Widget>[
          IconButton(
              icon: FaIcon(
                FontAwesomeIcons.expandArrowsAlt,
                color: Colors.white,
              ),
              onPressed: () {
                if (fontSize < 60) {
                  setState(() {
                    fontSize += 2;
                    print(fontSize);
                  });
                }
              }),
          IconButton(
              icon: FaIcon(FontAwesomeIcons.compressArrowsAlt, color: Colors.white),
              onPressed: () {
                if (fontSize > 0) {
                  setState(() {
                    fontSize -= 2;
                  });
                }
              }),
          IconButton(
              icon: FaIcon(
                FontAwesomeIcons.font,
                color: Colors.white,
              ),
              onPressed: null)
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  child: Text(
                    MarkerProvider.tehilimPerek[32],
                    textDirection: TextDirection.rtl,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: fontSize,fontFamily: fonts[index+1]),
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                Container(
                  child: Text(
                    MarkerProvider.tehilim[32],
                    textDirection: TextDirection.rtl,
                    style: TextStyle(fontSize: fontSize),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Text(
                    MarkerProvider.tehilimPerek[15],
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: fontSize),
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                Container(
                  child: Text(
                    MarkerProvider.tehilim[15],
                    textDirection: TextDirection.rtl,
                    style: TextStyle(fontSize: fontSize),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Text(
                    MarkerProvider.tehilimPerek[16],
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: fontSize),
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                Container(
                  child: Text(
                    MarkerProvider.tehilim[16],
                    textDirection: TextDirection.rtl,
                    style: TextStyle(fontSize: fontSize),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Text(
                    MarkerProvider.tehilimPerek[71],
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: fontSize),
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                Container(
                  child: Text(
                    MarkerProvider.tehilim[71],
                    textDirection: TextDirection.rtl,
                    style: TextStyle(fontSize: fontSize),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Text(
                    MarkerProvider.tehilimPerek[103],
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: fontSize),
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                Container(
                  child: Text(
                    MarkerProvider.tehilim[103],
                    textDirection: TextDirection.rtl,
                    style: TextStyle(fontSize: fontSize),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Text(
                    MarkerProvider.tehilimPerek[129],
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: fontSize),
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                Container(
                  child: Text(
                    MarkerProvider.tehilim[129],
                    textDirection: TextDirection.rtl,
                    style: TextStyle(fontSize: fontSize),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  decoration: InputDecoration(hintText: 'אותיות הנפטר/ת'),
                  onChanged: (val) {
                    if (val != null && val.trim() != "") {
                      letters = val.split("");
                      setState(() {});
                    } else {
                      letters = [];
                      setState(() {});
                    }
                  },
                ),
                getOtiot(),
                SizedBox(
                  height: 30,
                ),
                Container(
                  child: Text("אותיות נשמה"),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Text(
                    "נ",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: fontSize),
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                Container(
                  child: Text(
                    MarkerProvider.otiot["נ"],
                    textDirection: TextDirection.rtl,
                    style: TextStyle(fontSize: fontSize),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Text(
                    "ש",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: fontSize),
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                Container(
                  child: Text(
                    MarkerProvider.otiot["ש"],
                    textDirection: TextDirection.rtl,
                    style: TextStyle(fontSize: fontSize),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Text(
                    "מ",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: fontSize),
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                Container(
                  child: Text(
                    MarkerProvider.otiot["מ"],
                    textDirection: TextDirection.rtl,
                    style: TextStyle(fontSize: fontSize),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Text(
                    "ה",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: fontSize),
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                Container(
                  child: Text(
                    MarkerProvider.otiot["ה"],
                    textDirection: TextDirection.rtl,
                    style: TextStyle(fontSize: fontSize),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getOtiot() {
    List<Widget> list = [];
    if (letters != null && letters.length > 0) {
      for (var l in letters) {
        l = MarkerProvider.letterConver[l];
        if (MarkerProvider.otiot.containsKey(l)) {
          list.add(
            Container(
              child: Text(
                "$l",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          );
          list.add(
            SizedBox(
              height: 3,
            ),
          );
          list.add(
            Container(
              child: Text(
                MarkerProvider.otiot[l],
                textDirection: TextDirection.rtl,
                style: TextStyle(fontSize: fontSize),
              ),
            ),
          );
          list.add(
            SizedBox(
              height: 10,
            ),
          );
        } else {
          list.add(Container());
        }
      }
      return Column(
        children: list,
      );
    } else {
      return Container();
    }
  }
}
