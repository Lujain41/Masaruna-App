import 'dart:math';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:masaruna/constant.dart';
import 'package:intl/intl.dart' as int;
import 'package:masaruna/model/accepted_driver_subscribe_model.dart';

import '../controls/control.dart';
import '../model/driver_execuse_model.dart';
import 'driver_location_one.dart';

class DriverDeliveryStatus2 extends StatefulWidget {
  DriverDeliveryStatus2({super.key, required this.exe});
  List<driver_execuse_model> exe;
  @override
  State<DriverDeliveryStatus2> createState() => _DriverDeliveryStatusState2();
}

class _DriverDeliveryStatusState2 extends State<DriverDeliveryStatus2> {
  List<accepted_driver_subscribe_model> driver_execuse = [];
  Control _control = Control();
  bool isloading = true;
  DateTime date = DateTime.now();
  get_accepted_driver_subscribe() {
    String dateF = int.DateFormat('yyyy-MM-dd').format(date);
    _control.get_accepted_driver_subscribe(dateF.toString()).then((value) {
      setState(() {
        driver_execuse = value!;
        isloading = false;
      });
    });
  }

  late Position cl;
  var latitude;
  var longitude;

  @override
  void initState() {
    getPostion();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("حالة التوصيل"),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios)),
      ),
      body: isloading
          ? Container(
              width: double.infinity,
              child: Center(
                  child: CircularProgressIndicator(
                color: goodcolor,
              )),
            )
          : Container(
              padding: EdgeInsets.only(top: 15),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // SizedBox(
                    //   width: 250,
                    //   child: Row(children: [
                    //     SizedBox(
                    //       width: 10,
                    //     ),
                    //     Text(
                    //       "الفترة: ",
                    //       style: TextStyle(color: goodcolor, fontSize: 20),
                    //     ),
                    //     SizedBox(
                    //       width: 5,
                    //     ),
                    //     Container(
                    //         margin: EdgeInsets.symmetric(vertical: 10),
                    //         padding: EdgeInsets.symmetric(horizontal: 20),
                    //         width: 100,
                    //         height: 40,
                    //         decoration: BoxDecoration(
                    //             border: Border.all(color: goodcolor, width: 2),
                    //             borderRadius: BorderRadius.circular(2)),
                    //         child: Center(
                    //             child: Text(
                    //           widget.timeofday,
                    //           style: TextStyle(
                    //               fontSize: 18,
                    //               color: goodcolor,
                    //               fontWeight: FontWeight.w900),
                    //         )))
                    //   ]),
                    // ),
                    // SizedBox(
                    //   height: 10,
                    // ),
                    Expanded(
                        child: SizedBox(
                      width: size.width * 0.9,
                      child: ListView.builder(
                          itemCount: driver_execuse.length,
                          itemBuilder: (context, index) {
                            String _name = "";
                            String _status = "";
                            accepted_driver_subscribe_model _student_location;
                            bool _canpressd = false;
                            if (widget.exe.isNotEmpty) {
                              if (widget.exe[index].toString() == "1") {
                                _status = "workoff";
                                _canpressd = false;
                                _name = driver_execuse[index]
                                    .student_name
                                    .toString();
                              }
                            } else {
                              switch (driver_execuse[index].state) {
                                case 0:
                                  _status = "waiting";
                                  _canpressd = true;
                                  _name = driver_execuse[index]
                                      .student_name
                                      .toString();
                                  _student_location = driver_execuse[index];

                                  break;
                                case 1:
                                  _status = "complete";
                                  _canpressd = false;
                                  _name = driver_execuse[index]
                                      .student_name
                                      .toString();
                                  break;
                              }
                            }
                            return StatusCard(
                              lat_driver: latitude,
                              long_driver: longitude,
                              size: size,
                              status: _status,
                              canPressed: _canpressd,
                              student_location: driver_execuse[index],
                              name:
                                  driver_execuse[index].student_name.toString(),
                              id: driver_execuse[index].student_id.toString(),
                              phone: driver_execuse[index]
                                  .student_phone
                                  .toString(),
                            );
                          }),
                    )),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
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
      get_accepted_driver_subscribe();
    });
  }
}

class StatusCard extends StatefulWidget {
  StatusCard(
      {Key? key,
      required this.name,
      required this.student_location,
      required this.size,
      required this.status,
      required this.canPressed,
      required this.id,
      required this.phone,
      required this.lat_driver,
      required this.long_driver})
      : super(key: key);

  final Size size;
  final String status;
  final bool canPressed;
  final accepted_driver_subscribe_model student_location;
  final String name;
  final String id;
  final String phone;
  var lat_driver;
  var long_driver;

  @override
  State<StatusCard> createState() => _StatusCardState();
}

class _StatusCardState extends State<StatusCard> {
  Widget _widget = SizedBox();

  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: Container(
          margin: EdgeInsets.only(top: 30),
          padding: EdgeInsets.symmetric(horizontal: 15),
          width: widget.size.width * 0.9,
          height: 60,
          decoration: BoxDecoration(
              color: widget.status == "workoff" ? Colors.red[200] : Kbackground,
              borderRadius: BorderRadius.circular(25)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 150,
                child: Row(
                  children: [
                    Icon(
                      Icons.account_circle,
                      size: 55,
                      color: goodcolor,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      widget.name,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: goodcolor),
                    ),
                  ],
                ),
              ),
              Builder(
                builder: (BuildContext context) {
                  switch (widget.status) {
                    case "workoff":
                      _widget = Transform.rotate(
                          angle: 90 * pi / 40,
                          child: Icon(
                            Icons.add_circle_outline,
                            size: 40,
                            color: Colors.red,
                          ));

                      break;

                    case "waiting":
                      _widget = FaIcon(
                        FontAwesomeIcons.mapLocationDot,
                        color: Colors.green[700],
                        size: 30,
                      );
                      break;

                    case "complete":
                      _widget = Icon(
                        Icons.check_circle_outline,
                        color: Colors.blue,
                        size: 40,
                      );
                      break;
                  }
                  return _widget;
                },
              ),
            ],
          ),
        ),
        onTap: widget.canPressed
            ? () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => Driver_Location_one(
                              lat_driver: widget.lat_driver,
                              long_driver: widget.long_driver,
                              name: widget.name,
                              student_location: widget.student_location,
                              id: widget.id,
                              phone: widget.phone,
                            ))));
              }
            : null);
  }
}
