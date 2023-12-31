import 'dart:io';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:image_picker/image_picker.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:masaruna/auth/signUp/signUpDriver/info_Driver.dart';
import 'package:masaruna/constant.dart';
import 'package:masaruna/controls/user_control.dart';
import '../../../model/universities_model.dart';
import '../../login.dart';

class info_Driver2 extends StatefulWidget {
  info_Driver2(
      {super.key,
      required this.driver_name_2,
      required this.imageFile,
      required this.driver_sex_2,
      required this.driver_city_2,
      required this.id,
      required this.driver_street_2});
  String? driver_name_2;
  String? driver_sex_2;
  String? driver_city_2;
  String? driver_street_2;
  String? id;
  File? imageFile;
  @override
  State<info_Driver2> createState() => _info_Driver2State();
}

class _info_Driver2State extends State<info_Driver2> {
  User_Control _user_control = User_Control();
  String educationalController = "";
  TextEditingController CarController = TextEditingController();
  TextEditingController NumberCarController = TextEditingController();
  TextEditingController nameCarController = TextEditingController();
  TextEditingController CostText = TextEditingController();
  List<String> list = <String>['شهر', 'ترم', 'سنة'];
  int Number_seats = 0;
  int cost = 0;
  bool isloading = true;
  List<universities_model> universities = [];

  get_universities() {
    _user_control.get_universities().then((value) => setState(() {
          universities = value!;
          isloading = false;
        }));
  }

  var Period;
  var dropdownValue;
  @override
  void initState() {
    get_universities();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double wi = MediaQuery.of(context).size.width;
    double hi = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 25,
              ),
              // Text(widget.driver_name_2.toString()),
              // Text(widget.imageFile.toString()),
              // Text(widget.driver_sex_2.toString()),
              // Text(widget.driver_city_2.toString()),
              // Text(widget.driver_street_2.toString()),
              Row(
                children: [
                  Text(
                    'الجهة التعليمية:',
                    style: TextStyle(fontSize: 18, color: goodcolor),
                  ),
                ],
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 175,
                    height: 70,
                    child: DropdownSearch<String>(
                      popupProps: const PopupProps.menu(
                        showSelectedItems: true,
                        showSearchBox: true,
                      ),
                      items: universities.map((e) {
                        return e.name.toString();
                      }).toList(),
                      dropdownDecoratorProps: DropDownDecoratorProps(
                        textAlign: TextAlign.right,
                        dropdownSearchDecoration: InputDecorationStyle('الحي'),
                      ),
                      onChanged: (value) {
                        setState(() {
                          educationalController = value.toString();
                        });
                      },
                    ),
                    // SearchField(
                    //   hasOverlay: true,
                    //   controller: educationalController,
                    //   searchInputDecoration:
                    //       InputDecorationStyle('الجهة التعليمية'),
                    //   suggestions: universities
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
                height: 30,
              ),
              Row(
                children: [
                  Text(
                    'طراز السيارة:',
                    style: TextStyle(fontSize: 18, color: goodcolor),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  form(CarController, '', 175),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    'عدد المقاعد:',
                    style: TextStyle(fontSize: 18, color: goodcolor),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: goodcolor),
                    ),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  Number_seats += 1;
                                });
                              },
                              child: Container(
                                height: 20,
                                width: 30,
                                decoration: BoxDecoration(
                                    border: Border.all(color: goodcolor)),
                                child: Center(
                                  child: Icon(
                                    Icons.arrow_drop_up_outlined,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  if (Number_seats == 0) {
                                  } else {
                                    Number_seats -= 1;
                                  }
                                });
                              },
                              child: Container(
                                height: 20,
                                width: 30,
                                decoration: BoxDecoration(
                                    border: Border.all(color: goodcolor)),
                                child: Center(
                                  child: Icon(
                                    Icons.arrow_drop_down,
                                    size: 20,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        Container(
                          width: 75,
                          child: Center(
                            child: Text(
                              Number_seats.toString(),
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    'رقم اللوحة :',
                    style: TextStyle(fontSize: 18, color: goodcolor),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  formCar(NumberCarController, '2222', 80),
                  SizedBox(
                    width: 10,
                  ),
                  formCar(nameCarController, 'MAS', 80)
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(children: [
                Text(
                  'الفترة',
                  style: TextStyle(fontSize: 18, color: goodcolor),
                ),
                Expanded(child: SizedBox()),
                SizedBox(
                  width: 210,
                  child: Row(
                    children: [
                      Row(
                        children: [
                          Radio(
                            activeColor: Colors.black,
                            value: "صباحي",
                            groupValue: Period,
                            onChanged: (value) {
                              setState(() {
                                Period = value;
                              });
                            },
                          ),
                          Text(
                            'صباحي',
                            style: TextStyle(color: goodcolor),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                            activeColor: Colors.black,
                            value: "مسائي",
                            groupValue: Period,
                            onChanged: (value) {
                              setState(() {
                                Period = value;
                              });
                            },
                          ),
                          Text(
                            'مسائي',
                            style: TextStyle(color: goodcolor),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ]),
              Row(
                children: [
                  Text(
                    'التكلفة:',
                    style: TextStyle(fontSize: 18, color: goodcolor),
                  ),
                  Expanded(
                    child: SizedBox(),
                  ),
                  SizedBox(
                    width: 195,
                    child: Row(
                      children: [
                        Container(
                          width: 110,
                          decoration: BoxDecoration(
                            border: Border.all(color: goodcolor),
                          ),
                          // width: 50,
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        cost += 1;
                                        CostText.text = cost.toString();
                                      });
                                    },
                                    child: Container(
                                      height: 25,
                                      width: 30,
                                      decoration: BoxDecoration(
                                          border: Border.all(color: goodcolor)),
                                      child: Center(
                                        child: Icon(
                                          Icons.arrow_drop_up_outlined,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        if (cost == 0) {
                                        } else {
                                          cost -= 1;
                                          CostText.text = cost.toString();
                                        }
                                      });
                                    },
                                    child: Container(
                                      height: 25,
                                      width: 30,
                                      decoration: BoxDecoration(
                                          border: Border.all(color: goodcolor)),
                                      child: Center(
                                        child: Icon(
                                          Icons.arrow_drop_down,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Container(
                                width: 75,
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  controller: CostText,
                                  onChanged: (value) {
                                    setState(() {
                                      value = cost.toString();
                                      cost = int.parse(CostText.text);
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  String carr = NumberCarController.text.toString() +
                      CarController.text.toString();
                  _user_control.register_driver_complete(
                      imageFile!,
                      driver_name.toString(),
                      driver_sex.toString(),
                      driver_city.toString(),
                      driver_street.toString(),
                      educationalController.toString(),
                      carr.toString(),
                      Number_seats.toString(),
                      NumberCarController.text.toString(),
                      '2',
                      Period.toString(),
                      cost.toString(),
                      widget.id.toString(),
                      context);
                },
                child: Text(
                  'انهـاء',
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

  Widget form(controllerText, String Title, double wi) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          height: 70,
          width: wi,
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
                hintText: Title,
                hintStyle: TextStyle(color: Colors.black54),
                suffixIcon: controllerText == CarController
                    ? SizedBox()
                    : Icon(Icons.search)),
          ),
        ),
      ],
    );
  }

  Widget formCar(controllerText, String Title, double wi) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          // height: 40,
          width: wi,
          child: TextFormField(
              textAlign: TextAlign.center,
              cursorColor: Colors.black,
              controller: controllerText,
              decoration: InputDecorationStyle(Title)),
        )
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
        hintText: Title
        // suffixIcon: Title == "الاسم"
        // // ? SizedBox()
        // // : Icon(
        // //     Icons.search,
        // //     size: ,
        // //   ),
        );
  }
}
