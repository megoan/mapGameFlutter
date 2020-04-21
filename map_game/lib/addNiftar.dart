import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_game/appColors.dart';
import 'package:map_game/models/pMarker.dart';
import 'package:map_game/providers/markerProvider.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddNiftar extends StatefulWidget {
  @override
  _AddNiftarState createState() => _AddNiftarState();
}

class _AddNiftarState extends State<AddNiftar> {
  final databaseReference = Firestore.instance;
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> markers;
  BitmapDescriptor customIcon;
  bool isInit = true;
  MarkerProvider markerProvider;
  final _formKey = GlobalKey<FormState>();
  String addressSearch;
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController textEditingController = new TextEditingController();
  TextEditingController fullNameController = new TextEditingController();
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(MarkerProvider.startLan, MarkerProvider.startLon),
    zoom: 0.0,
  );
  Marker marker;
  bool isSaving = false;
  bool mapIsLoading = false;
  @override
  void dispose() {
    fullNameController.dispose();
    textEditingController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      double width = MediaQuery.of(context).size.width;
      showFillName(width);
    });
  }

  @override
  void didChangeDependencies() {
    if (isInit) {
      isInit = false;
      markers = Set.from([]);
      markerProvider = Provider.of<MarkerProvider>(context);
      createMarker(context);
    }

    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  Future<void> _goToMarker(CameraPosition position) async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(position));
    return;
  }

  createMarker(context) {
    if (customIcon == null) {
      ImageConfiguration configuration = createLocalImageConfiguration(context);
      BitmapDescriptor.fromAssetImage(configuration, 'assets/book2.png').then((icon) {
        setState(() {
          customIcon = icon;
        });
      });
    }
  }

  void showFillName(width) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => WillPopScope(
        onWillPop: () {},
        child: AlertDialog(
          contentPadding: EdgeInsets.all(0),
          backgroundColor: Colors.transparent,
          elevation: 5,
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(25.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Container(
                      width: width - 30,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "הוספת שם לתפילה",
                              style: TextStyle(fontSize: 18, color: Colors.grey),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(width: width - 46, child: Text("אנא מלא/י את שמו/ה של החולה בצורה הבאה",textAlign: TextAlign.center,)),
                          Text("השם שלו/ה בן/בת שם של אמא שלו/ה"),
                          SizedBox(
                            height: 3,
                          ),
                          Text(
                            "לדוגמא: יצחק בן שרה",
                            style: TextStyle(color: Colors.black54),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: width - 46,
                            child: Form(
                              key: _formKey,
                              child: TextFormField(
                                validator: (v) {
                                  if (v != null && v.trim() != "") {
                                    return null;
                                  } else
                                    return 'הזן שם מלא: פלוני בן אלמוני';
                                },
                                controller: fullNameController,
                                decoration: InputDecoration(hintText: 'הזן שם מלא: פלוני בן אלמוני'),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                FlatButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    "ביטול",
                                    style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.tMainColor),
                                  ),
                                ),
                                RaisedButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        "בחר/י מיקום במפה",
                                        style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.tLightTextColor),
                                      ),
                                      // SizedBox(
                                      //   width: 4,
                                      // ),
                                      // Icon(
                                      //   Icons.location_on,
                                      //   color: Colors.white,
                                      // )
                                    ],
                                  ),
                                  onPressed: () async {
                                    if (_formKey.currentState.validate()) {
                                      Navigator.pop(context, true);
                                      // PMarker pm = PMarker("34345", TYPE.REFUA, fullNameController.text.toString(), 0, DateTime.now(), marker.position.latitude, marker.position.longitude);
                                      // markerProvider.addMarker(pm);
                                      // await databaseReference.collection("sick").add({'fullName': fullNameController.text.toString(), 'chapterCount': 0, 'type': "refua", "createdAt": DateTime.now(), "loc": GeoPoint(marker.position.latitude, marker.position.longitude)});
                                      // Navigator.pop(context, pm);
                                    }
                                    // else {
                                    //   final snackBar = SnackBar(
                                    //       content: Row(
                                    //     children: <Widget>[
                                    //       Icon(Icons.warning),
                                    //       SizedBox(
                                    //         width: 20,
                                    //       ),
                                    //       Text('חובה למלא את השם'),
                                    //     ],
                                    //   ));

                                    //   _scaffoldKey.currentState.showSnackBar(snackBar);
                                    // }
                                  },
                                  color: AppColors.tMainColor,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    ).then((onValue) {
      if (onValue == null) {
        Navigator.pop(context);
      }
    });
  }

  Future<void> goToAdress(String address) async {
    List<Placemark> placemarks = await Geolocator().placemarkFromAddress(address);
    if (placemarks != null && placemarks.length > 0) {
      Placemark placemark = placemarks[0];
      _goToMarker(CameraPosition(bearing: 192.8334901395799, target: LatLng(placemark.position.latitude, placemark.position.longitude), tilt: 59.440717697143555, zoom: 15));
      marker = Marker(markerId: MarkerId('1'), icon: customIcon, position: LatLng(placemark.position.latitude, placemark.position.longitude), onTap: null);

      setState(() {
        markers.add(marker);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Theme.of(context).backgroundColor,
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: AppColors.tMainColor,
          label: Text(
            "שמור",
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () async {
            if (marker == null) {
              final snackBar = SnackBar(
                content: Row(
                  children: <Widget>[
                    Icon(Icons.warning),
                    SizedBox(
                      width: 20,
                    ),
                    Text('לחץ על המפה לבחור מיקום'),
                  ],
                ),
              );
              _scaffoldKey.currentState.showSnackBar(snackBar);
            } else {
              setState(() {
                isSaving = true;
              });
              PMarker pm = PMarker("34345", TYPE.REFUA, fullNameController.text.toString(), 0, DateTime.now(), marker.position.latitude, marker.position.longitude);
              markerProvider.addMarker(pm);
              await databaseReference.collection("sick").add({'fullName': fullNameController.text.toString(), 'chapterCount': 0, 'type': "refua", "createdAt": DateTime.now(), "loc": GeoPoint(marker.position.latitude, marker.position.longitude)});
              Navigator.pop(context, [true, pm]);
            }
          },
          icon: Icon(
            Icons.save,
            color: Colors.white,
          ),
        ),
        body: Container(
          child: Stack(
            children: <Widget>[
              Opacity(
                opacity: mapIsLoading ? 1 : 0,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
              Opacity(
                opacity: mapIsLoading ? 0 : 1,
                child: GoogleMap(
                  onTap: (latLng) {
                    print(latLng);
                    marker = Marker(markerId: MarkerId('1'), icon: customIcon, position: latLng, onTap: null);

                    setState(() {
                      markers.add(marker);
                    });
                  },
                  markers: markers,
                  mapType: MapType.satellite,
                  initialCameraPosition: _kGooglePlex,
                  onMapCreated: (GoogleMapController controller) {
                    setState(() {
                      mapIsLoading = false;
                    });
                    _controller.complete(controller);
                  },
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Flexible(
                          child: Container(
                            decoration: new BoxDecoration(color: Colors.white, borderRadius: new BorderRadius.all(new Radius.circular(25.7))),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: TextField(
                                controller: textEditingController,
                                decoration: InputDecoration(
                                  hintText: "כתובת",
                                  suffixIcon: GestureDetector(
                                    child: Icon(Icons.search),
                                    onTap: () {
                                      addressSearch = textEditingController.text.toString();
                                      goToAdress(addressSearch);
                                    },
                                  ),
                                  border: InputBorder.none,
                                ),
                                onSubmitted: (val) {
                                  addressSearch = val;
                                  goToAdress(addressSearch);
                                },
                              ),
                            ),
                          ),
                        ),
                        // SizedBox(
                        //   width: 20,
                        // ),
                        // GestureDetector(
                        //     onTap: () async {
                        //       Position position = await Geolocator().getLastKnownPosition(desiredAccuracy: LocationAccuracy.high);
                        //       if (position == null) {
                        //         Geolocator geolocator = Geolocator()..forceAndroidLocationManager = true;
                        //         GeolocationStatus geolocationStatus  = await geolocator.checkGeolocationPermissionStatus();
                        //         position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
                        //       }
                        //       _goToMarker(CameraPosition(bearing: 192.8334901395799, target: LatLng(position.latitude, position.longitude), tilt: 59.440717697143555, zoom: 19.151926040649414));
                        //     },
                        //     child: Icon(
                        //       Icons.my_location,
                        //       size: 36,
                        //       color: AppColors.tHappyColor,
                        //     ))
                      ],
                    ),
                  ),
                ),
              ),
              if (isSaving)
                Align(
                  alignment: Alignment.center,
                  child: CupertinoActivityIndicator(),
                )
            ],
          ),
        ),
      ),
    );
  }
}
