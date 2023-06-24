import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:masaruna/constant.dart';

class LocationWidget_Driver extends StatefulWidget {
  const LocationWidget_Driver({
    Key? key,
  }) : super(key: key);

  @override
  State<LocationWidget_Driver> createState() => _LocationWidget_DriverState();
}

class _LocationWidget_DriverState extends State<LocationWidget_Driver> {
  @override
  Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(22.7968485797, 44.989873295),
    zoom: 8,
  );
  String? latitude;
  String? longitude;

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Set<Marker> myMarker = {
      Marker(
          draggable: true,
          markerId: MarkerId('1'),
          position: LatLng(22.796848545776797, 44.989871489393295))
    };

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_back_ios),
          color: goodcolor,
        ),
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
                myMarker.remove(Marker(markerId: MarkerId('1')));
                myMarker.add(Marker(markerId: MarkerId('1'), position: LatLng));
                setState(() {
                  latitude = LatLng.latitude.toString();
                  longitude = LatLng.longitude.toString();
                });
              },
              mapType: MapType.normal,
              initialCameraPosition: _kGooglePlex,
              zoomControlsEnabled: true,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(25))),
            height: 120,
            child: Column(
              children: [
                Text("المتبقي"),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.account_circle_rounded,
                        size: 55,
                        color: goodcolor,
                      ),
                      Column(
                        children: [
                          Text(
                            "محمد",
                            style: TextStyle(
                                color: goodcolor,
                                fontSize: 20,
                                fontWeight: FontWeight.w700),
                          ),
                          Text(
                            "السائق في الطريق اليك",
                            style: TextStyle(
                              fontSize: 15,
                              color: goodcolor,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "5 كلم",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 15),
                          ),
                          Text(
                            "6 دقائق",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
