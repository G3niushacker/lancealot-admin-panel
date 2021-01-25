import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lancealot_admin_panel/models/guard_model.dart';

class GuardsOnMap extends StatefulWidget {
  @override
  _GuardsOnMapState createState() => _GuardsOnMapState();
}

class _GuardsOnMapState extends State<GuardsOnMap> {
  double currentUserlat, currentUserLong;
  GoogleMapController _controller;
  static CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  final Set<Marker> markers = {};
  List<Guard_Model> guards = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Online Guards Locations"),
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller = controller;
          getAvailableGuard();
        },
        markers: markers,
      ),
    );
  }

  getAvailableGuard() async {
    print("get available guard called(2)");
    final Uint8List markerIcon =
        await getBytesFromAsset('images/guard.png', 100);
    double guardlat, guardlong;
    await FirebaseFirestore.instance
        .collection("onlineGuards")
        .get()
        .then((value) {
      value.docs.forEach((element) async {
        if (element.data()["latitude"] != null) {
          guardlat = element.data()["latitude"];
          guardlong = element.data()['longitude'];
          Guard_Model guard = Guard_Model();
          guard.firstName = element.data()["firstName"];
          guard.lastName = element.data()["lastName"];
          guard.latitude = element.data()["latitude"];
          guard.longitude = element.data()['longitude'];
          guard.phone = element.data()['phone'];
          guard.uid = element.id;
          guard.image = element.data()['image'];
          guards.add(guard);
          Marker marker = Marker(
              icon: BitmapDescriptor.fromBytes(markerIcon),
              onTap: () {},
              markerId: MarkerId(element.id),
              position: LatLng(
                guardlat,
                guardlong,
              ));
          markers.add(marker);
        }
      });
    });
    print("List of markers(3) : $markers");
    sortList();
    setState(() {});
  }

  sortList() {
    print("get sort list");
    guards.sort((a, b) => calculateDistance(
            a.latitude, a.longitude, currentUserlat, currentUserLong)
        .compareTo(calculateDistance(
            b.latitude, b.longitude, currentUserlat, currentUserLong)));
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * cos(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
        .buffer
        .asUint8List();
  }
}
