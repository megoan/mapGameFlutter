import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Google Maps Demo',
      home: MapSample(),
    );
  }
}

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> markers;
  BitmapDescriptor customIcon;
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(31.736474, 34.976774),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(31.736474, 34.976774),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  void initState() {
    markers = Set.from([]);
    // TODO: implement initState
    super.initState();
  }

  createMarker(context) {
    if (customIcon == null) {
      ImageConfiguration configuration = createLocalImageConfiguration(context);
      BitmapDescriptor.fromAssetImage(configuration, 'assets/candle.png')
          .then((icon) {
        setState(() {
          customIcon = icon;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    createMarker(context);
    return new Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          // Container(
          //   width: MediaQuery.of(context).size.width,
          //   height: MediaQuery.of(context).size.height,
          //   child: GoogleMap(
          //     onTap: (latLng) {
          //       print(latLng);
          //       Marker m = Marker(
          //           markerId: MarkerId('1'),
          //           icon: customIcon,
          //           position: latLng,
          //           onTap: () {
          //             showDialog(
          //                 context: context,
          //                 builder: (_) => AlertDialog(
          //                       title: new Text("Dialog Title"),
          //                       content: new Text("This is my content"),
          //                     ));
          //           });
          //       setState(() {
          //         markers.add(m);
          //       });
          //     },
          //     markers: markers,
          //     mapType: MapType.satellite,
          //     initialCameraPosition: _kGooglePlex,
          //     onMapCreated: (GoogleMapController controller) {
          //       _controller.complete(controller);
          //     },
          //   ),
          // ),
          Container(
            width: 100,
            height: 200,
            color: Colors.yellow.withOpacity(0.5),
          ),
          Container(
  
          )
        ],
      ),
      appBar: AppBar(title: Text("hello")),
      drawer: Drawer(),
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
}
