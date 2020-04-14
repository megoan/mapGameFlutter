import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_game/addNiftar.dart';
import 'package:map_game/appColors.dart';
import 'package:map_game/markerDialog.dart';
import 'package:map_game/models/pMarker.dart';
import 'package:map_game/providers/markerProvider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MarkerProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Google Maps Demo',
        home: MapSample(),
      ),
    );
  }
}

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Set<Marker> markers;
  BitmapDescriptor customIcon;
  bool isInit = true;
  MarkerProvider markerProvider;
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(31.736474, 34.976774),
    zoom: 0.0,
  );

  static final CameraPosition _kLake = CameraPosition(bearing: 192.8334901395799, target: LatLng(31.736474, 34.976774), tilt: 59.440717697143555, zoom: 19.151926040649414);

  @override
  void didChangeDependencies() async {
    if (isInit) {
      isInit = false;
      markers = Set.from([]);
      markerProvider = Provider.of<MarkerProvider>(context);
      final SharedPreferences prefs = await _prefs;

      MarkerProvider.fontSize = (prefs.getDouble('fontSize') ?? 14);
      MarkerProvider.fIndex = (prefs.getInt('fIndex') ?? 0);
      createMarker(context);
    }
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void initState() {
    // markers = Set.from([]);
    // TODO: implement initState
    super.initState();
  }

  createMarker(context) {
    if (customIcon == null) {
      ImageConfiguration configuration = createLocalImageConfiguration(context);
      BitmapDescriptor.fromAssetImage(configuration, 'assets/candle3.png').then((icon) {
        setState(() {
          customIcon = icon;
          for (var item in markerProvider.pmarkers) {
            Marker m = Marker(
                markerId: MarkerId(item.id),
                icon: customIcon,
                position: LatLng(item.lat, item.lon),
                onTap: () {
                  showDialog(context: context, builder: (_) => MarkerDialog(item));
                });
            markers.add(m);
          }
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    //createMarker(context);
    return new Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: GoogleMap(
                onTap: (latLng) {
                  print(latLng);
                  Marker m = Marker(
                      markerId: MarkerId('1'),
                      icon: customIcon,
                      position: latLng,
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                                  title: new Text("Dialog Title"),
                                  content: new Text("This is my content"),
                                ));
                      });
                  setState(() {
                    markers.add(m);
                  });
                },
                markers: markers,
                mapType: MapType.satellite,
                initialCameraPosition: _kGooglePlex,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(children: <Widget>[
                    // FloatingActionButton(onPressed: (){
                    //   _scaffoldKey.currentState.openDrawer();
                    // },child: Icon(Icons.menu),)
                  ]),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                child: Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.tMainColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        bottomLeft: Radius.circular(50),
                      ),
                    ),
                    height: 80,
                    width: 250,
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          double width = MediaQuery.of(context).size.width;
                          double height = MediaQuery.of(context).size.height;
                          showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                    contentPadding: EdgeInsets.all(0),
                                    backgroundColor: Colors.transparent,
                                    elevation: 5,
                                    content: Container(
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [AppColors.tGradientTop, AppColors.tGradientBottom], stops: [0.0, 1.0]),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(25.0),
                                          )),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SingleChildScrollView(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              SizedBox(
                                                width: width - 30,
                                                child: TextField(
                                                  decoration: InputDecoration(hintText: 'Enter a search term'),
                                                ),
                                              ),
                                              SizedBox(height: 15),
                                              SizedBox(
                                                height: height - 230,
                                                width: width - 30,
                                                child: ListView.builder(
                                                    itemCount: markerProvider.pmarkers.length,
                                                    itemBuilder: (context, index) {
                                                      return Card(
                                                        elevation: 3,
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(8),
                                                        ),
                                                        child: InkWell(
                                                          borderRadius: BorderRadius.circular(8),
                                                          onTap: () async {
                                                            Navigator.of(context).pop([false, index]);
                                                          },
                                                          child: Padding(
                                                            padding: const EdgeInsets.all(12.0),
                                                            child: Row(
                                                              children: <Widget>[
                                                                Row(
                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  children: <Widget>[
                                                                    // Text(markerProvider.pmarkers[index].name),
                                                                    // Text(' Son Of '),
                                                                    Text(markerProvider.pmarkers[index].fullName),
                                                                  ],
                                                                ),
                                                                Icon(
                                                                  Icons.location_on,
                                                                  color: AppColors.tMainColor,
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              ButtonTheme(
                                                minWidth: 200,
                                                height: 50,
                                                child: RaisedButton(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(30),
                                                  ),
                                                  color: AppColors.tMainColor,
                                                  onPressed: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(builder: (context) => AddNiftar()),
                                                    ).then((onValue) async {
                                                      if (onValue != null) {
                                                        Navigator.pop(context, [true, onValue]);
                                                      }
                                                    });
                                                  },
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Text(
                                                      "הוסף נפטר",
                                                      style: TextStyle(color: AppColors.tSadColor),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  )).then((index) async {
                            if (index != null) {
                              if (index[0]) {
                                PMarker tempMarker = index[1] as PMarker;
                                Marker m = Marker(
                                    markerId: MarkerId(tempMarker.id),
                                    icon: customIcon,
                                    position: LatLng(tempMarker.lat, tempMarker.lon),
                                    onTap: () {
                                      showDialog(context: context, builder: (_) => MarkerDialog(tempMarker));
                                    });
                                setState(() {
                                  markers.add(m);
                                });
                                _goToMarker(CameraPosition(bearing: 0, target: LatLng(tempMarker.lat, tempMarker.lon), tilt: 59.440717697143555, zoom: 6.0));
                                await Future.delayed(Duration(milliseconds: 1000), () {
                                  _goToMarker(CameraPosition(bearing: 192.8334901395799, target: LatLng(tempMarker.lat, tempMarker.lon), tilt: 59.440717697143555, zoom: 19.151926040649414));
                                });
                                Future.delayed(Duration(milliseconds: 2000), () {
                                  showDialog(context: context, builder: (_) => MarkerDialog(tempMarker));
                                });
                              } else {
                                PMarker pMarker = markerProvider.pmarkers[index[1]];
                                _goToMarker(CameraPosition(bearing: 0, target: LatLng(pMarker.lat, pMarker.lon), tilt: 59.440717697143555, zoom: 6.0));
                                await Future.delayed(Duration(milliseconds: 1000), () {
                                  _goToMarker(CameraPosition(bearing: 192.8334901395799, target: LatLng(pMarker.lat, pMarker.lon), tilt: 59.440717697143555, zoom: 19.151926040649414));
                                });
                                Future.delayed(Duration(milliseconds: 1500), () {
                                  showDialog(context: context, builder: (_) => MarkerDialog(pMarker));
                                });
                              }
                            }
                          });
                        },
                        child: Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            Container(
                              height: 60,
                              width: 60,
                              margin: new EdgeInsets.all(10.0),
                              decoration: new BoxDecoration(
                                color: AppColors.tSecondaryColor,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black,
                                    blurRadius: 20.0, // has the effect of softening the shadow
                                    spreadRadius: 1.0, // has the effect of extending the shadow
                                    offset: Offset(
                                      2.0, // horizontal, move right 10
                                      2.0, // vertical, move down 10
                                    ),
                                  )
                                ],
                                borderRadius: new BorderRadius.all(
                                  Radius.circular(100),
                                ),
                              ),
                            ),
                            CircleAvatar(
                              radius: 28,
                              backgroundColor: AppColors.tMainColor,
                              child: Image.asset('assets/candle3.png'),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: VerticalDivider(
                          color: Colors.white,
                        ),
                      ),
                      Column(children: <Widget>[
                        Text(
                          "פרקים שנקראו",
                          style: TextStyle(fontSize: 18, color: AppColors.tHappyColor),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text("12,000", style: TextStyle(fontSize: 18, color: AppColors.tHappyColor)),
                      ], crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center)
                    ]),
                  ),
                ]),
              ),
            )
          ],
        ),
      ),
      //appBar: AppBar(title: Text("hello")),
      //drawer: Drawer(),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: _goToTheLake,
      //   label: Text('To the lake!'),
      //   icon: Icon(Icons.directions_boat),
      // ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }

  Future<void> _goToMarker(CameraPosition position) async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(position));
    print("hhhhhhhhhhh");
    return;
  }
}
