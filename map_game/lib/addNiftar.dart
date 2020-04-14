import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_game/appColors.dart';
import 'package:map_game/models/pMarker.dart';
import 'package:map_game/providers/markerProvider.dart';
import 'package:provider/provider.dart';

class AddNiftar extends StatefulWidget {
  @override
  _AddNiftarState createState() => _AddNiftarState();
}

class _AddNiftarState extends State<AddNiftar> {
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> markers;
  BitmapDescriptor customIcon;
  bool isInit = true;
  MarkerProvider markerProvider;
  String addressSearch;
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController textEditingController = new TextEditingController();
  TextEditingController fullNameController = new TextEditingController();
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(31.736474, 34.976774),
    zoom: 0.0,
  );
  Marker marker;
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
    print("hhhhhhhhhhh");
    return;
  }

  createMarker(context) {
    if (customIcon == null) {
      ImageConfiguration configuration = createLocalImageConfiguration(context);
      BitmapDescriptor.fromAssetImage(configuration, 'assets/candle3.png').then((icon) {
        setState(() {
          customIcon = icon;
        });
      });
    }
  }

  Future<void> goToAdress(String address) async {
    List<Placemark> placemarks = await Geolocator().placemarkFromAddress(address);
    if (placemarks != null && placemarks.length > 0) {
      Placemark placemark = placemarks[0];
      _goToMarker(CameraPosition(bearing: 192.8334901395799, target: LatLng(placemark.position.latitude, placemark.position.longitude), tilt: 59.440717697143555, zoom: 19.151926040649414));
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
            style: TextStyle(color: AppColors.tSadColor),
          ),
          onPressed: () {
            if (marker == null) {
              final snackBar = SnackBar(
                  content: Row(
                children: <Widget>[
                  Icon(Icons.warning),
                  SizedBox(
                    width: 20,
                  ),
                  Text('click on the map to choose a location'),
                ],
              ));
// Find the Scaffold in the widget tree and use it to show a SnackBar.
              _scaffoldKey.currentState.showSnackBar(snackBar);
            } else {
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
                      color: Colors.white,
                      // gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [AppColors.tGradientTop, AppColors.tGradientBottom], stops: [0.0, 1.0]),
                      borderRadius: BorderRadius.all(
                        Radius.circular(25.0),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            
                            SizedBox(
                              width: width - 30,
                              child: TextField(
                                controller: fullNameController,
                                decoration: InputDecoration(hintText: 'Enter full name: israel son of israel'),
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
                                        style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.tSadColor),
                                      )),
                                  RaisedButton(
                                      onPressed: () {
                                        if (fullNameController.text.toString() != "") {
                                          PMarker pm = PMarker("34345", TYPE.YIZKOR, fullNameController.text.toString(), 0, DateTime.now(), marker.position.latitude, marker.position.longitude);
                                          markerProvider.addMarker(pm);
                                          Navigator.pop(context, pm);
                                        } else {
                                          final snackBar = SnackBar(
                                              content: Row(
                                            children: <Widget>[
                                              Icon(Icons.warning),
                                              SizedBox(
                                                width: 20,
                                              ),
                                              Text('please complete all fields'),
                                            ],
                                          ));
// Find the Scaffold in the widget tree and use it to show a SnackBar.
                                          _scaffoldKey.currentState.showSnackBar(snackBar);
                                        }
                                      },
                                      color: AppColors.tSadColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: Text(
                                        "אישור",
                                        style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.tLightTextColor),
                                      ))
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ).then((onValue) {
                if (onValue != null) {
                  Navigator.pop(context, onValue);
                }
              });
            }
          },
          icon: Icon(
            Icons.save,
            color: AppColors.tSadColor,
          ),
        ),
        body: Container(
          child: Stack(
            children: <Widget>[
              GoogleMap(
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
                  _controller.complete(controller);
                },
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
                                    hintText: "Enter Address",
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
                              )),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        GestureDetector(
                            onTap: () async {
                              Position position = await Geolocator().getLastKnownPosition(desiredAccuracy: LocationAccuracy.high);
                              _goToMarker(CameraPosition(bearing: 192.8334901395799, target: LatLng(position.latitude, position.longitude), tilt: 59.440717697143555, zoom: 19.151926040649414));
                            },
                            child: Icon(
                              Icons.my_location,
                              size: 36,
                              color: AppColors.tHappyColor,
                            ))
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
