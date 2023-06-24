import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:masaruna/constant.dart';
import 'package:masaruna/controls/control.dart';
import 'package:intl/intl.dart' as int;
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

import '../model/accepted_driver_subscribe_model.dart';
import 'driver_delivery_status.dart';

class Driver_Location_one extends StatefulWidget {
  Driver_Location_one(
      {Key? key,
      required this.student_location,
      required this.name,
      required this.id,
      required this.phone,
      required this.lat_driver,
      required this.long_driver})
      : super(key: key);
  accepted_driver_subscribe_model student_location;
  final String name;
  final String id;
  final String phone;
  var lat_driver;
  var long_driver;

  @override
  State<Driver_Location_one> createState() => _Driver_Location_oneState();
}

class _Driver_Location_oneState extends State<Driver_Location_one> {
  Control _control = Control();
  bool isloading = false;

  @override
  void initState() {
    ShowBottomSheet();
    get();

    super.initState();
  }

  @override
  Completer<GoogleMapController> _controller = Completer();

  // String? latitude;
  // String? longitude;
  List<LatLng> po = [];

  get() async {
    LatLng sourceLoc = LatLng(widget.lat_driver, widget.long_driver);
    LatLng destina = LatLng(widget.student_location.student_lat,
        widget.student_location.student_long);
    PolylinePoints polygonPoints = PolylinePoints();
    PolylineResult result = await polygonPoints.getRouteBetweenCoordinates(
        'AIzaSyAc4K9kZM9QitCAppry8TMcEgvtzXfKm-4',
        PointLatLng(sourceLoc.latitude, sourceLoc.longitude),
        PointLatLng(destina.latitude, destina.longitude));

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        po.add(LatLng(point.latitude, point.longitude));
      });
      setState(() {});
    }
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Set<Marker> myMarker = {
      Marker(
          draggable: true,
          markerId: MarkerId('1'),
          position: LatLng(widget.lat_driver, widget.long_driver)),
      Marker(
          draggable: true,
          markerId: MarkerId('2'),
          position: LatLng(widget.student_location.student_lat,
              widget.student_location.student_long))
    };

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
          color: goodcolor,
        ),
        title: Text(
          'الخريطة',
          style: TextStyle(color: goodcolor),
        ),
      ),
      body: isloading
          ? Container(
              width: double.infinity,
              child: Center(
                  child: CircularProgressIndicator(
                color: goodcolor,
              )),
            )
          : Column(
              children: [
                Expanded(
                  child: GoogleMap(
                    polylines: {
                      Polyline(
                        polylineId: PolylineId('route'),
                        points: po,
                      )
                    },
                    markers: myMarker,
                    onTap: (LatLng) {
                      ShowBottomSheet();
                    },
                    mapType: MapType.normal,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(widget.lat_driver, widget.long_driver),
                      zoom: 8,
                    ),
                    zoomControlsEnabled: true,
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                  ),
                ),
              ],
            ),
    );
  }

  ShowBottomSheet() {
    Future.delayed(Duration(seconds: 0)).then((_) {
      showModalBottomSheet(
          context: context,
          builder: (builder) {
            return Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.only(topLeft: Radius.circular(25))),
              height: 120,
              child: Container(
                padding: EdgeInsets.only(top: 10),
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.account_circle_rounded,
                          size: 55,
                          color: goodcolor,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          widget.name,
                          style: TextStyle(
                              color: goodcolor,
                              fontSize: 20,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                            margin: EdgeInsets.only(left: 20),
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                ))),
                                onPressed: () {
                                  DateTime date = DateTime.now();
                                  String dateF =
                                      int.DateFormat('yyyy-MM-dd').format(date);

                                  _control.add_student_list(dateF.toString(),
                                      widget.id.toString(), context);
                                },
                                child: Text("تم التوصيل"))),
                        IconButton(
                            onPressed: () {
                              UrlLauncher.launch(
                                  'tel:${widget.phone.toString()}');
                            },
                            icon: Icon(
                              Icons.phone,
                              size: 30,
                              color: goodcolor,
                            ))
                      ],
                    )
                  ],
                ),
              ),
            );
          });
    });
  }
}
