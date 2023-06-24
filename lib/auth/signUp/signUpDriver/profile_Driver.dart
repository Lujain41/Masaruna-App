import 'package:flutter/material.dart';
import 'package:masaruna/Utils/URL.dart';
import 'package:masaruna/auth/edit_profile.dart';
import 'package:masaruna/auth/signUp/signUpDriver/edit_profile_Driver.dart';
import 'package:masaruna/constant.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../controls/user_control.dart';
import '../../../model/user_model.dart';
import '../../../screen_Driver/dashboard_Driver.dart';

class profile_Driver extends StatefulWidget {
  const profile_Driver({super.key});

  @override
  State<profile_Driver> createState() => _profile_DriverState();
}

class _profile_DriverState extends State<profile_Driver> {
  String personalName = 'شيماء';
  User_Control _user_control = User_Control();
  user_model? user;
  bool isloading = true;

  get_profile() {
    _user_control.profile().then((value) => setState(() {
          user = value!;
          isloading = false;
        }));
  }

  bool istrue1 = false;
  bool istrue2 = false;

  @override
  void initState() {
    get_profile();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isloading
          ? Container(
              width: double.infinity,
              child: Center(
                  child: CircularProgressIndicator(
                color: goodcolor,
              )),
            )
          : SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 75,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              dashboard_Driver()),
                                      (route) => false);
                                },
                                icon: Icon(
                                  Icons.arrow_back_ios,
                                  color: goodcolor,
                                )),
                            InkWell(
                              onTap: () {
                                print('object');
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          Driver_Edit_Profile(
                                            user: user,
                                          )),
                                );
                              },
                              child: Container(
                                height: 30,
                                width: 75,
                                decoration: BoxDecoration(
                                    color: goodcolor,
                                    borderRadius: BorderRadius.circular(25)),
                                child: Center(
                                  child: Text(
                                    'تعديل',
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              backgroundColor: Kbackground,
                              radius: 60,
                              backgroundImage: NetworkImage(
                                  ImageUrl + user!.image.toString()),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          user!.name.toString(),
                          style: const TextStyle(
                              fontSize: 25,
                              color: goodcolor,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.phone,
                              color: goodcolor,
                              size: 30,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Text(
                                'رقم الجوال : ${user!.phone.toString()}',
                                style:
                                    TextStyle(color: goodcolor, fontSize: 15),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              Icons.email,
                              color: goodcolor,
                              size: 30,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Text(
                                'البريد الالكتروني: ${user!.email.toString()}',
                                style:
                                    TextStyle(color: goodcolor, fontSize: 15),
                              ),
                            ),
                          ],
                        ),
                        Container(
                            width: 250,
                            child: Divider(
                              thickness: 2,
                            )),
                        SizedBox(
                          height: 25,
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        istrue1 = !istrue1;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      color: goodcolor4,
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('معلومات النقل'),
                          istrue1
                              ? SizedBox()
                              : Icon(Icons.keyboard_arrow_down_outlined),
                        ],
                      ),
                    ),
                  ),
                  istrue1
                      ? Container(
                          padding: EdgeInsets.all(8),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'الجهة التعليمية: ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    user!.university_name.toString(),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'الحي:',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    user!.street_name.toString(),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'التكلفة:',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    user!.cost.toString(),
                                  )
                                ],
                              ),
                            ],
                          ),
                        )
                      : SizedBox(),
                  SizedBox(
                    height: 15,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        istrue2 = !istrue2;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      color: goodcolor4,
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('معلومات المركبة'),
                          istrue2
                              ? SizedBox()
                              : Icon(Icons.keyboard_arrow_down_outlined),
                        ],
                      ),
                    ),
                  ),
                  istrue2
                      ? Container(
                          padding: EdgeInsets.all(8),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'طراز السيارة:',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    user!.car.toString(),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'عدد المقاعد:',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    user!.seats.toString(),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'رقم اللوحة:',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    user!.car_number.toString(),
                                  )
                                ],
                              ),
                            ],
                          ),
                        )
                      : SizedBox()
                ],
              ),
            ),
    );
  }
}
