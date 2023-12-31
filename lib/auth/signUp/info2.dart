import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:masaruna/auth/login.dart';
import 'package:masaruna/constant.dart';
import 'package:masaruna/controls/user_control.dart';
import 'package:masaruna/model/universities_model.dart';
import '../../model/streets_model.dart';

class info2 extends StatefulWidget {
  info2(
      {super.key,
      required this.id,
      required this.student_name_2,
      required this.student_city_2,
      required this.student_street_2,
      required this.student_home_number_2,
      required this.student_sex_2,
      required this.student_long_2,
      required this.student_lant_2});
  final String id;
  String? student_name_2,
      student_sex_2,
      student_city_2,
      student_street_2,
      student_home_number_2,
      student_long_2,
      student_lant_2;
  @override
  State<info2> createState() => _info2State();
}

class _info2State extends State<info2> {
  String UniversityController = "";
  var timeIn = TimeOfDay.now();
  DateTime in_dateTime = DateTime.now();
  DateTime out_dateTime = DateTime.now();
  bool Sunday = false;
  bool Monday = false;
  bool Tuesday = false;
  bool Wednesday = false;
  bool Thursday = false;
  DateTime dateTimestart = DateTime.now();
  DateTime dateTimeend = DateTime.now();
  bool isloading = true;
  User_Control _user_control = User_Control();
  List<universities_model> universities = [];

  get_universities() {
    _user_control.get_universities().then((value) => setState(() {
          universities = value!;
          isloading = false;
        }));
  }

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
        width: MediaQuery.of(context).size.width,
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
                      height: 50,
                    ),
                    Container(
                      padding: EdgeInsets.all(18),
                      // height: 500,
                      width: wi / 1.2,
                      decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'الجامعة :',
                                style:
                                    TextStyle(fontSize: 18, color: goodcolor),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.5,
                                height: 70,
                                child: DropdownSearch<String>(
                                  popupProps: const PopupProps.menu(
                                    showSelectedItems: true,
                                    showSearchBox: true,
                                  ),
                                  items: universities.map((e) {
                                    return e.name.toString();
                                  }).toList(),
                                  dropdownDecoratorProps:
                                      DropDownDecoratorProps(
                                    textAlign: TextAlign.right,
                                    dropdownSearchDecoration:
                                        InputDecorationStyle('الحي'),
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      UniversityController = value.toString();
                                    });
                                  },
                                ),

                                //  SearchField(
                                //   /// hasOverlay: true,
                                //   controller: UniversityController,
                                //   searchInputDecoration:
                                //       InputDecorationStyle('الجامعة'),
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
                            height: 25,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'اليوم:',
                                style:
                                    TextStyle(fontSize: 18, color: goodcolor),
                              ),
                              Container(
                                width: wi * 0.50,
                                child: Column(
                                  children: [
                                    Container(
                                      width: wi * 0.50,
                                      //   color: Colors.red,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: wi * 0.25,
                                            child: Row(
                                              children: [
                                                Checkbox(
                                                  activeColor: goodcolor,
                                                  value: Sunday,
                                                  onChanged: (bool? newValue) {
                                                    setState(() {
                                                      Sunday = newValue!;
                                                      newValue
                                                          ? _user_control
                                                              .add_days(
                                                                  '1', context)
                                                          : _user_control
                                                              .delete_day(
                                                                  '1', context);
                                                    });
                                                  },
                                                ),
                                                Text('الاحد'),
                                              ],
                                            ),
                                          ),
                                          Expanded(child: SizedBox()),
                                          SizedBox(
                                            width: wi * 0.25,
                                            child: Row(
                                              children: [
                                                Checkbox(
                                                  activeColor: goodcolor,
                                                  value: Monday,
                                                  onChanged: (bool? newValue) {
                                                    setState(() {
                                                      Monday = newValue!;
                                                      newValue
                                                          ? _user_control
                                                              .add_days(
                                                                  '2', context)
                                                          : _user_control
                                                              .delete_day(
                                                                  '2', context);
                                                    });
                                                  },
                                                ),
                                                Text('الاثنين'),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                        width: wi * 0.50,
                                        child: Row(children: [
                                          SizedBox(
                                            width: wi * 0.25,
                                            child: Row(
                                              children: [
                                                Checkbox(
                                                  activeColor: goodcolor,
                                                  value: Tuesday,
                                                  onChanged: (bool? newValue) {
                                                    setState(() {
                                                      Tuesday = newValue!;
                                                      newValue
                                                          ? _user_control
                                                              .add_days(
                                                                  '3', context)
                                                          : _user_control
                                                              .delete_day(
                                                                  '3', context);
                                                    });
                                                  },
                                                ),
                                                Text('الثلاثاء'),
                                              ],
                                            ),
                                          ),
                                          Expanded(child: SizedBox()),
                                          SizedBox(
                                            width: wi * 0.25,
                                            child: Row(
                                              children: [
                                                Checkbox(
                                                  activeColor: goodcolor,
                                                  value: Wednesday,
                                                  onChanged: (bool? newValue) {
                                                    setState(() {
                                                      Wednesday = newValue!;
                                                      newValue
                                                          ? _user_control
                                                              .add_days(
                                                                  '4', context)
                                                          : _user_control
                                                              .delete_day(
                                                                  '4', context);
                                                    });
                                                  },
                                                ),
                                                Text('الاربعاء'),
                                              ],
                                            ),
                                          ),
                                        ])),
                                    Container(
                                      width: wi * 0.50,
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: wi * 0.26,
                                            child: Row(
                                              children: [
                                                Checkbox(
                                                  value: Thursday,
                                                  activeColor: goodcolor,
                                                  onChanged: (bool? newValue) {
                                                    setState(() {
                                                      Thursday = newValue!;
                                                      newValue
                                                          ? _user_control
                                                              .add_days(
                                                                  '5', context)
                                                          : _user_control
                                                              .delete_day(
                                                                  '5', context);
                                                    });
                                                  },
                                                ),
                                                Text('الخميس'),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: SizedBox(),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: wi / 1.2,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text("بداية الدوام: "),
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(color: goodcolor2)),
                                  width: wi * 0.50,
                                  height: 100,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Kbackground,
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                            color: goodcolor2, width: 0.5)),
                                    height: 75,
                                    width: 130,
                                    child: CupertinoDatePicker(
                                      mode: CupertinoDatePickerMode.time,
                                      onDateTimeChanged: (value) {
                                        in_dateTime = value;
                                        print(in_dateTime);
                                      },
                                      initialDateTime: DateTime.now(),
                                      minimumYear: 2000,
                                      maximumYear: 3000,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: wi / 1.2,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text("نهاية الدوام: "),
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                          color: goodcolor2, width: 0.5)),
                                  width: wi * 0.50,
                                  height: 100,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Kbackground,
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(color: goodcolor2)),
                                    height: 75,
                                    width: 130,
                                    child: CupertinoDatePicker(
                                      mode: CupertinoDatePickerMode.time,
                                      onDateTimeChanged: (value) {
                                        out_dateTime = value;
                                        print(out_dateTime);
                                      },
                                      initialDateTime: DateTime.now(),
                                      minimumYear: 2000,
                                      maximumYear: 3000,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (UniversityController != "") {
                          _user_control.register_student_complete(
                              widget.student_name_2.toString(),
                              widget.student_sex_2.toString(),
                              widget.student_city_2.toString(),
                              widget.student_street_2.toString(),
                              widget.student_home_number_2.toString(),
                              widget.student_lant_2.toString(),
                              widget.student_long_2.toString(),
                              UniversityController.toString(),
                              in_dateTime.toString(),
                              out_dateTime.toString(),
                              widget.id,
                              context);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                              'احد الحقول فارغ',
                              textAlign: TextAlign.center,
                            ),
                            backgroundColor: Colors.red,
                          ));
                        }

                        // Navigator.pushAndRemoveUntil(
                        //     context,
                        //     MaterialPageRoute(builder: (context) => login()),
                        //     (route) => false);
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

  Widget form(controllerText, String Title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '${Title} :',
          style: TextStyle(fontSize: 18),
        ),
        Expanded(child: SizedBox()),
        Container(
          height: 40,
          width: MediaQuery.of(context).size.width * 0.5,
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
                suffixIcon: Icon(Icons.search)),
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
}
