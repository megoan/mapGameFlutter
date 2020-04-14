import 'package:google_maps_flutter/google_maps_flutter.dart';
enum TYPE{YIZKOR,REFUA}
class PMarker {
  String id;
  String fullName;
  int chapterCount;
  DateTime createdAt;
  TYPE type;
  double lat;
  double lon;

  PMarker(this.id,this.type,this.fullName,this.chapterCount,this.createdAt,this.lat,this.lon);
}
