import 'dart:async';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:masaruna/auth/signUp/info2.dart';
import 'package:masaruna/controls/user_control.dart';
import 'package:masaruna/model/city_model.dart';
import 'package:masaruna/model/streets_model.dart';
import 'package:searchfield/searchfield.dart';

import '../../constant.dart';

String? student_name,
    student_sex,
    student_city,
    student_street,
    student_home_number,
    student_long,
    student_lant;
String elid = "";

class infoUser extends StatefulWidget {
  const infoUser({super.key, required this.pressd});
  final Function pressd;
  @override
  State<infoUser> createState() => _infoUserState();
}

class _infoUserState extends State<infoUser> {
  Completer<GoogleMapController> _controller = Completer();

  TextEditingController nameController = TextEditingController();
  String streetController = "";
  String cityController = "";
  TextEditingController PhoneController = TextEditingController();

  User_Control _user_control = User_Control();

  List<citie_model> citys = [];
  var latitude = 0.0;
  var longitude = 0.0;
  late Position cl;
  bool isloading = true;
  get_cities() {
    _user_control.get_cities().then((value) => setState(() {
          citys = value!;
          get_streets();
        }));
  }

  List<streets_model> streets = [];

  get_streets() {
    _user_control.get_streets().then((value) => setState(() {
          streets = value!;
          isloading = false;
        }));
  }

  @override
  void initState() {
    get_cities();
    getPostion();
    // TODO: implement initState
    super.initState();
  }

  var maleOrFemale;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: isloading
            ? Container(
                width: double.infinity,
                child: Center(
                    child: CircularProgressIndicator(
                  color: goodcolor,
                )),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 25,
                    ),
                    form(nameController, 'الاسم'),
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'الجنس:',
                          style: TextStyle(fontSize: 18, color: goodcolor),
                        ),
                        Row(
                          children: [
                            Row(
                              children: [
                                Radio(
                                  activeColor: Colors.black,
                                  value: "ذكر",
                                  groupValue: maleOrFemale,
                                  onChanged: (value) {
                                    setState(() {
                                      maleOrFemale = value;
                                    });
                                  },
                                ),
                                Text(
                                  'ذكر',
                                  style:
                                      TextStyle(fontSize: 20, color: goodcolor),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Radio(
                                  activeColor: Colors.black,
                                  value: "انثى",
                                  groupValue: maleOrFemale,
                                  onChanged: (value) {
                                    setState(() {
                                      maleOrFemale = value;
                                    });
                                  },
                                ),
                                Text(
                                  'انثى',
                                  style:
                                      TextStyle(fontSize: 20, color: goodcolor),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 75,
                            )
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'المدينة :',
                          style: TextStyle(fontSize: 18, color: goodcolor),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.6,
                          height: 70,
                          child: DropdownSearch<String>(
                            popupProps: const PopupProps.menu(
                              showSelectedItems: true,
                              showSearchBox: true,
                            ),
                            items: citys.map((e) {
                              return e.name.toString();
                            }).toList(),
                            dropdownDecoratorProps: DropDownDecoratorProps(
                              textAlign: TextAlign.right,
                              dropdownSearchDecoration:
                                  InputDecorationStyle('المدينة'),
                            ),
                            onChanged: (value) {
                              setState(() {
                                cityController = value.toString();
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    // formsearch(cityController, 'المدينة', citys),
                    SizedBox(
                      height: 35,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'الحي :',
                          style: TextStyle(fontSize: 18, color: goodcolor),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.6,
                          height: 70,
                          child: DropdownSearch<String>(
                            popupProps: const PopupProps.menu(
                              showSelectedItems: true,
                              showSearchBox: true,
                            ),
                            items: streets.map((e) {
                              return e.name.toString();
                            }).toList(),
                            dropdownDecoratorProps: DropDownDecoratorProps(
                              textAlign: TextAlign.right,
                              dropdownSearchDecoration:
                                  InputDecorationStyle('الحي'),
                            ),
                            onChanged: (value) {
                              setState(() {
                                streetController = value.toString();
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    // formsearch(streetController, 'الحي', streets[0].name),
                    SizedBox(
                      height: 25,
                    ),
                    form(PhoneController, 'رقم المنزل'),
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'تحديد الموقع:',
                          style: TextStyle(fontSize: 18, color: goodcolor),
                        ),
                        Container(
                          height: 200,
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: GoogleMap(
                            markers: myMarker,
                            onTap: (LatLng) {
                              myMarker.remove(Marker(markerId: MarkerId('1')));
                              myMarker.add(Marker(
                                  markerId: MarkerId('1'), position: LatLng));
                              setState(() {
                                latitude = LatLng.latitude;
                                longitude = LatLng.longitude;
                              });
                            },
                            mapType: MapType.normal,
                            initialCameraPosition: _kGooglePlex,
                            zoomControlsEnabled: true,
                            onMapCreated: (GoogleMapController controller) {
                              _controller.complete(controller);
                            },
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (nameController.text.isNotEmpty &&
                            maleOrFemale != null &&
                            cityController != "" &&
                            streetController != "" &&
                            PhoneController.text.isNotEmpty &&
                            longitude != null &&
                            latitude != null) {
                          student_name = nameController.text.toString();
                          student_sex = maleOrFemale.toString();
                          student_city = cityController.toString();
                          student_street = streetController.toString();
                          student_home_number = PhoneController.text.toString();
                          student_long = longitude.toString();
                          student_lant = latitude.toString();
                          widget.pressd();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                              'احد الحقول فارغ',
                              textAlign: TextAlign.center,
                            ),
                            backgroundColor: Colors.red,
                          ));
                        }
                      },

                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (BuildContext context) {
                      //   return info2();
                      // }));

                      child: Text(
                        'التالي',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              // side: BorderSide(width: 2.0, color: Colors.black),
                              borderRadius: BorderRadius.circular(15)),
                          minimumSize: const Size(190, 50),
                          primary: Color(0xFF7D9D9C)),
                    ),
                    SizedBox(
                      height: 150,
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(22.7968485797, 44.989873295),
    zoom: 8,
  );

  Set<Marker> myMarker = {
    Marker(
        draggable: true,
        markerId: MarkerId('1'),
        position: LatLng(22.796848545776797, 44.989871489393295))
  };

  Widget form(controllerText, String Title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '${Title} :',
          style: TextStyle(fontSize: 18, color: goodcolor),
        ),
        Expanded(child: SizedBox()),
        Container(
          height: 70,
          width: MediaQuery.of(context).size.width * 0.6,
          child: TextFormField(
            textAlign: TextAlign.center,
            cursorColor: Colors.black,
            controller: controllerText,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              filled: true,
              fillColor: Color(0xFFF0EFEF),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: Color(0xff576f72))),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: Color(0xff576f72))),
            ),
          ),
        ),
      ],
    );
  }

  Widget formsearch(controllerText, String Title, dynamic Data) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '${Title} :',
          style: TextStyle(fontSize: 18, color: goodcolor),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.6,
          height: 70,
          child: SearchField(
            /// hasOverlay: true,
            controller: controllerText,
            searchInputDecoration: InputDecorationStyle(Title),
            suggestions: Data.map(
              (e) => SearchFieldListItem(
                e,
                item: e,
                // Use child to show Custom Widgets in the suggestions
                // defaults to Text widget
                child: Center(
                  child: Text(e),
                ),
              ),
            ).toList(),
          ),
        ),
      ],
    );
  }

  InputDecoration InputDecorationStyle(String Title) {
    return InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      filled: true,
      fillColor: Color(0xFFF0EFEF),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Color(0xff576f72))),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Color(0xff576f72))),
      suffixIcon: Title == "الاسم"
          ? SizedBox()
          : Icon(
              Icons.search,
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
