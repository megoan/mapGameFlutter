import 'package:google_maps_flutter/google_maps_flutter.dart';
enum TYPE{YIZKOR,REFUA}
class PMarker {
  String id;
  String name;
  String fatherName;
  int chapterCount;
  DateTime createdAt;
  TYPE type;
  double lat;
  double lon;

  PMarker(this.id,this.type,this.name,this.fatherName,this.chapterCount,this.createdAt,this.lat,this.lon);
}