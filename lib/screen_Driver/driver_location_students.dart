import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:masaruna/constant.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:intl/intl.dart' as int;
import 'package:masaruna/model/accepted_driver_subscribe_model.dart';
import 'package:masaruna/screen_Driver/homepage_Driver.dart';

import '../controls/control.dart';

class Driver_Location_Sudents extends StatefulWidget {
  Driver_Location_Sudents({
    Key? key,
  }) : super(key: key);
  @override
  State<Driver_Location_Sudents> createState() =>
      _Driver_Location_SudentsState();
}

class _Driver_Location_SudentsState extends State<Driver_Location_Sudents> {
  BitmapDescriptor markicon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor studenticon = BitmapDescriptor.defaultMarker;
  void addicon() {
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration(), "assets/images/bus.png")
        .then((icon) {
      setState(() {
        markicon = icon;
      });
    });
  }

  Control _control = Control();
  bool isloading = false;
  DateTime date = DateTime.now();
  late Position cl;
  bool isStudent = true;
  List<accepted_driver_subscribe_model> accepted_driver_subscribe = [];
  get_accepted_driver_subscribe() {
    String dateF = int.DateFormat('yyyy-MM-dd').format(date);
    _control.get_accepted_driver_subscribe(dateF.toString()).then((value) {
      setState(() {
        accepted_driver_subscribe = value!;
        isStudent = false;
      });
    });
  }

  @override
  Completer<GoogleMapController> _controller = Completer();

  var latitude_;
  var longitude_;
  List<LatLng> po = [];
  List<LatLng> x = [];
  get() async {
    LatLng sourceLoc = LatLng(x[0].latitude, x[0].longitude);
    LatLng destina = LatLng(x[1].latitude, x[1].longitude);
    PolylinePoints polygonPoints = PolylinePoints();
    for (var i = 0; i < x.length - 1; i++) {
      PolylineResult result = await polygonPoints.getRouteBetweenCoordinates(
          'AIzaSyAc4K9kZM9QitCAppry8TMcEgvtzXfKm-4',
          PointLatLng(x[i].latitude, x[i].longitude),
          PointLatLng(x[i + 1].latitude, x[i + 1].longitude));
      if (result.points.isNotEmpty) {
        result.points.forEach((PointLatLng point) {
          po.add(LatLng(point.latitude, point.longitude));
        });
        setState(() {});
      }
    }
  }

  @override
  void initState() {
    addicon();
    getPostion();

    super.initState();
  }

  Widget build(BuildContext context) {
    List<Marker> myMarker = x.map(
      (e) {
        var i = x.indexOf(e);
        return Marker(
            icon: i == 0 ? markicon : studenticon,
            draggable: true,
            markerId: MarkerId(e.toString()),
            position: LatLng(e.latitude, e.longitude));
      },
    ).toList();

    return isloading
        ? Scaffold(
            body: Center(
                child: CircularProgressIndicator(
              color: goodcolor,
            )),
          )
        : isStudent == false
            ? Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  title: Text(
                    'الخريطة',
                    style: TextStyle(color: goodcolor),
                  ),
                ),
                body: Column(
                  children: [
                    Expanded(
                      child: GoogleMap(
                        onTap: (LatLng) {
                          ShowBottomSheet();
                        },
                        polylines: {
                          Polyline(
                            polylineId: PolylineId('route'),
                            points: po,
                          ),
                        },
                        markers: myMarker.toSet(),
                        mapType: MapType.normal,
                        initialCameraPosition: CameraPosition(
                          target: LatLng(32.524410, 39.818989),
                          zoom: 5,
                        ),
                        zoomControlsEnabled: true,
                        onMapCreated: (GoogleMapController controller) {
                          _controller.complete(controller);
                        },
                      ),
                    ),
                  ],
                ),
              )
            : SizedBox();
  }

  Future getPostion() async {
    await get_accepted_driver_subscribe();
    bool services;
    services = await Geolocator.isLocationServiceEnabled();

    LocationPermission per;
    per = await Geolocator.checkPermission();

    if (per == LocationPermission.denied) {
      per = await Geolocator.requestPermission();
    }
    if (per != LocationPermission.denied) {
      await getLatAndLong();
    }
  }

  getLatAndLong() async {
    cl = await Geolocator.getCurrentPosition().then((value) => value);

    setState(() {
      latitude_ = cl.latitude;
      longitude_ = cl.longitude;
      x = [
        LatLng(latitude_, longitude_),
      ];

      for (var studnt_location in accepted_driver_subscribe) {
        x.add(
            LatLng(studnt_location.student_lat, studnt_location.student_long));
      }
      isloading = false;
    });

    ShowBottomSheet();
  }

  ShowBottomSheet() {
    Future.delayed(Duration(seconds: 6)).then((_) {
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
                  child: Center(
                    child: SizedBox(
                      width: 100,
                      height: 40,
                      child: ElevatedButton(
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ))),
                          onPressed: () async {
                            await get();
                          },
                          child: Text("إبدأ")),
                    ),
                  )),
            );
          });
    });
  }
}
