import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:masaruna/constant.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

import '../controls/control.dart';
import '../model/driver_model.dart';

class LocationWidget extends StatefulWidget {
  const LocationWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<LocationWidget> createState() => _LocationWidgetState();
}

class _LocationWidgetState extends State<LocationWidget> {
  bool isloading = true;
  Control _control = Control();
  List<driver_model> Ldriver = [];
  bool isDriver = false;
  double latitudeD = 0.0;
  double longitudeD = 0.0;
  get_student_subscribe() {
    _control.get_student_subscribe().then((value) {
      setState(() {
        Ldriver = value!;
        latitudeD = Ldriver[0].lat == null ? 0 : Ldriver[0].lat;
        longitudeD = Ldriver[0].long == null ? 0 : Ldriver[0].long;

        print(latitudeD);
        print(longitudeD);
        Ldriver.length != 0 ? isDriver = true : isDriver = false;
        getPostion();
        print('======');
        showbottomsheet();
        print('======');
      });
    });
  }

  var latitude = 0.0;
  var longitude = 0.0;
  late Position cl;
  showbottomsheet() {
    isloading
        ? null
        : isDriver
            ? Future.delayed(Duration(seconds: 0)).then((_) {
                print('qqqqqqqqqqqqqq');
                double KM = double.parse('${Ldriver[1].kilometers}');
                showModalBottomSheet(
                    context: context,
                    builder: (builder) {
                      return Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25))),
                        height: 120,
                        child: Column(
                          children: [
                            Text("المتبقي"),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(
                                    Icons.account_circle_rounded,
                                    size: 55,
                                    color: goodcolor,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        Ldriver[1].name.toString(),
                                        style: TextStyle(
                                            color: goodcolor,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700),
                                      ),

                                      // Text(
                                      //   "السائق في الطريق اليك",
                                      //   style: TextStyle(
                                      //     fontSize: 15,
                                      //     color: goodcolor,
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                  Expanded(child: SizedBox()),
                                  Column(
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            UrlLauncher.launch(
                                                'tel:${Ldriver[1].phone..toString()}');
                                          },
                                          icon: Icon(Icons.phone))
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(Ldriver[1]
                                              .kilometers
                                              .toStringAsFixed(3) +
                                          ' KM'),
                                      Text(((KM / 100).toInt()).toString() +
                                          ' ساعة')
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    });
              })
            : null;
  }

  @override
  void initState() {
    get_student_subscribe();
    super.initState();
  }

  @override
  Completer<GoogleMapController> _controller = Completer();

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Set<Marker> myMarker = {
      Marker(
          draggable: true,
          markerId: MarkerId('1'),
          position: LatLng(latitude, longitude)),
      Marker(
          draggable: true,
          markerId: MarkerId('2'),
          position: LatLng(latitudeD, longitudeD)),
    };

    return isloading
        ? Scaffold(
            body: Center(
                child: CircularProgressIndicator(
              color: goodcolor,
            )),
          )
        : isDriver == false
            ? Scaffold(
                body: Center(
                    child: Text(
                  'أشترك الان',
                  style: TextStyle(color: goodcolor, fontSize: 25),
                )),
              )
            : Scaffold(
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
                        markers: myMarker,
                        onTap: (LatLng) {
                          showbottomsheet();
                        },
                        mapType: MapType.normal,
                        initialCameraPosition: CameraPosition(
                          target: LatLng(latitude, longitude),
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

  Future getPostion() async {
    bool services;
    services = await Geolocator.isLocationServiceEnabled();

    LocationPermission per;
    per = await Geolocator.checkPermission();

    if (per == LocationPermission.denied) {
      per = await Geolocator.requestPermission();
    }
    if (per != LocationPermission.denied) {
      getLatAndLong();
    }
  }

  getLatAndLong() async {
    cl = await Geolocator.getCurrentPosition().then((value) => value);

    setState(() {
      latitude = cl.latitude;
      longitude = cl.longitude;

      isloading = false;
    });
  }
}
