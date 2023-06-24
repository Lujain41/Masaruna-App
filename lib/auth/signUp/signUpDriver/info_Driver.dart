import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:masaruna/constant.dart';
import '../../../controls/user_control.dart';
import '../../../model/city_model.dart';
import '../../../model/streets_model.dart';

import 'package:path/path.dart' as Path;
import 'package:image_picker/image_picker.dart';

String? driver_name, driver_sex, driver_city, driver_street;
File? imageFile;

class info_Driver extends StatefulWidget {
  info_Driver({
    super.key,
    required this.pressd,
  });
  final Function pressd;

  @override
  State<info_Driver> createState() => _info_DriverState();
}

class _info_DriverState extends State<info_Driver> {
  Completer<GoogleMapController> _controller = Completer();
  bool isImage = false;

  PickedFile? pickedFile;

  File? file;
  final imagepicker = ImagePicker();
  var imagname;
  TextEditingController nameController = TextEditingController();
  String cityController ="";
  String streetController = "";
  TextEditingController PhoneController = TextEditingController();
  User_Control _user_control = User_Control();
  List<citie_model> citys = [];
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

  var maleOrFemale;
  String? latitude;
  String? longitude;

  @override
  void initState() {
    get_streets();
    get_cities();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              form(nameController, 'الاسم'),
              SizedBox(
                height: 25,
              ),
              Row(
                children: [
                  Text(
                    'الصورة الشخصية:',
                    style: TextStyle(fontSize: 20, color: goodcolor),
                  ),
                ],
              ),
              Icon(
                Icons.image,
                size: 100,
              ),
              ElevatedButton(
                  onPressed: () async {
                    _getFromGallery();
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (BuildContext context) {
                    //   return dashboard();
                    // }));
                  },
                  child: Container(
                    width: 70,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(Icons.cloud_upload_rounded),
                        Text(
                          'رفع',
                          style: TextStyle(
                              fontSize: 17,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          // side: BorderSide(width: 1.0, color: Colors.black),
                          borderRadius: BorderRadius.circular(8)),
                      minimumSize: const Size(50, 30),
                      primary: goodcolor2)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'الجنس:',
                    style: TextStyle(fontSize: 20, color: goodcolor),
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width * 0.63,
                      child: Row(children: [
                        Row(children: [
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
                                style: TextStyle(fontSize: 20),
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
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                        ])
                      ])),
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
                    child:DropdownSearch<String>(
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
                                  InputDecorationStyle('الحي'),
                            ),
                            onChanged: (value) {
                              setState(() {
                                cityController = value.toString();
                              });
                            },
                          ),

                    
                    //  SearchField(
                    //   /// hasOverlay: true,
                    //   controller: cityController,
                    //   searchInputDecoration: InputDecorationStyle('المدينة'),
                    //   suggestions: citys
                    //       .map(
                    //         (e) => SearchFieldListItem(
                    //           e.name,
                    //           item: e.name,
                    //           // Use child to show Custom Widgets in the suggestions
                    //           // defaults to Text widget
                    //           child: Center(
                    //             child: Text(e.name),
                    //           ),
                    //         ),
                    //       )
                    //       .toList(),
                    // ),
                  ),
                ],
              ),
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
                    child:DropdownSearch<String>(
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
                    
                    //  SearchField(
                    //   /// hasOverlay: true,
                    //   controller: streetController,
                    //   searchInputDecoration: InputDecorationStyle('الحي'),
                    //   suggestions: streets
                    //       .map(
                    //         (e) => SearchFieldListItem(
                    //           e.name,
                    //           item: e.name,
                    //           // Use child to show Custom Widgets in the suggestions
                    //           // defaults to Text widget
                    //           child: Center(
                    //             child: Text(e.name),
                    //           ),
                    //         ),
                    //       )
                    //       .toList(),
                    // ),
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              ElevatedButton(
                onPressed: () {
                  if (nameController.text.isNotEmpty &&
                      cityController!="" &&
                      streetController!="" &&
                      imageFile != null &&
                      maleOrFemale != null) {
                    // driver_image = imagname;
                    driver_name = nameController.text.toString();
                    driver_sex = maleOrFemale.toString();
                    driver_city = cityController.toString();
                    driver_street = streetController.toString();
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
                height: 50,
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
        Container(
          height: 70,
          width: MediaQuery.of(context).size.width * 0.6,
          child: TextFormField(
            textAlign: TextAlign.center,
            cursorColor: Colors.black,
            controller: controllerText,
            decoration: InputDecorationStyle(Title),
          ),
        ),
      ],
    );
  }

  

  InputDecoration InputDecorationStyle(String Title) {
    return InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      filled: true,
      fillColor: Color(0xFFF0EFEF),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Color(0xff576f72))),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Color(0xff576f72))),
      suffixIcon: Title == "الاسم"
          ? SizedBox()
          : Icon(
              Icons.search,
            ),
    );
  }

  _getFromGallery() async {
    pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 300,
      maxHeight: 300,
    );
    if (pickedFile != null) {
      imageFile = File(pickedFile!.path);

      setState(() {
        isImage = true;
      });

      print(imageFile);
    }
  }
}
