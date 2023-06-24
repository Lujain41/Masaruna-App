import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:masaruna/constant.dart';
import 'package:masaruna/controls/control.dart';
import 'package:masaruna/controls/user_control.dart';
import 'package:masaruna/model/user_model.dart';
import 'package:masaruna/screen/Subscriptions/driverrate.dart';
import 'package:masaruna/screen/Subscriptions/payment.dart';
import 'package:masaruna/screen/Subscriptions/subscribenow.dart';

import '../../model/day_model.dart';
import '../../model/driver_subscribe_model.dart';

class SubscriptionsWidget_Driver extends StatefulWidget {
  const SubscriptionsWidget_Driver({
    Key? key,
  }) : super(key: key);

  @override
  State<SubscriptionsWidget_Driver> createState() =>
      _SubscriptionsWidget_DriverState();
}

class _SubscriptionsWidget_DriverState
    extends State<SubscriptionsWidget_Driver> {
  Control _control = Control();

  User_Control _user_control = User_Control();
  List<driver_subscribe_model> driver_subscribe = [];

  get_driver_subscribe() {
    _control.get_driver_subscribe().then((value) {
      setState(() {
        driver_subscribe = value!;
      });
    });
  }

  @override
  void initState() {
    get_driver_subscribe();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> items = [
      {
        'name': 'سارة',
        'state': 'جديد',
      },
      {
        'name': 'as',
        'state': 'غير مؤكد',
      },
      {
        'name': 'qqddddqq',
        'state': 'مشترك',
      },
      {
        'name': 'q2312qqq',
        'state': 'تقييم',
      }
    ];

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('المشتركين'),
        centerTitle: true,
        leading: SizedBox(),
      ),
      body: Column(
        children: [
          Expanded(
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  width: size.width,
                  child: ListView.builder(
                    itemCount: driver_subscribe.length,
                    itemBuilder: (context, index) {
                      return SubscriptionsCard(
                        driver_subscribe: driver_subscribe[index],
                        index: index,
                      );
                    },
                  )))
        ],
      ),
    );
  }
}

class SubscriptionsCard extends StatefulWidget {
  SubscriptionsCard(
      {Key? key, required this.driver_subscribe, required this.index})
      : super(key: key);
  driver_subscribe_model driver_subscribe;
  int index;

  @override
  State<SubscriptionsCard> createState() => _SubscriptionsCardState();
}

class _SubscriptionsCardState extends State<SubscriptionsCard> {
  Control _control = Control();

  User_Control _user_control = User_Control();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 30, bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      // height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Kbackground,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                Icons.account_circle_rounded,
                size: 45,
                color: goodcolor,
              ),
              Text(
                widget.driver_subscribe.name.toString(),
                style: TextStyle(color: goodcolor, fontSize: 18),
              ),
            ],
          ),
          InkWell(
            onTap: () async {
              List<day_model>? days = [];

              widget.driver_subscribe.status.toString() == '0'
                  ? {
                      await _user_control
                          .get_my_dayss(
                              widget.driver_subscribe.student_id.toString())
                          .then((value) => setState(() {
                                days = value!;
                              })),
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return StatefulBuilder(
                                builder: (context, setState) {
                              return New(
                                  context, widget.driver_subscribe.name, days!);
                            });
                          })
                    }
                  : widget.driver_subscribe.status.toString() == '1'
                      ? Colors.red
                      : widget.driver_subscribe.status.toString() == '2'
                          ? Colors.blue
                          : showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return StatefulBuilder(
                                    builder: (context, setState) {
                                  return rate(
                                      context, widget.driver_subscribe.name);
                                });
                              });
            },
            child: Row(
              children: [
                widget.driver_subscribe.status == '2'
                    ? IconButton(onPressed: () {}, icon: Icon(Icons.phone))
                    : SizedBox(),
                Container(
                  padding: EdgeInsets.all(8),
                  child: Center(
                      child: widget.driver_subscribe.status.toString() == '1'
                          ? Text(
                              'غير مؤكد',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            )
                          : widget.driver_subscribe.status.toString() == '2'
                              ? Text(
                                  'مشترك',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                )
                              : widget.driver_subscribe.status.toString() == '3'
                                  ? Text(
                                      'تقييم',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    )
                                  : Text(
                                      'جديد',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    )),
                  width: 80,
                  height: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: widget.driver_subscribe.status.toString() == '0'
                          ? Colors.green
                          : widget.driver_subscribe.status.toString() == '1'
                              ? Colors.red
                              : widget.driver_subscribe.status.toString() == '2'
                                  ? Colors.blue
                                  : Colors.amber),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget rate(context, name) {
    double ratings = 0.0;
    return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
            side: BorderSide(color: goodcolor, width: 2)),
        content: SizedBox(
          height: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.close,
                        size: 35,
                        color: goodcolor,
                      )),
                ],
              ),
              Text(
                "ما مدى تقييمك ل${name}؟",
                style: TextStyle(
                    color: goodcolor,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              RatingBar.builder(
                  initialRating: 0,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    switch (index) {
                      case 0:
                        return Icon(
                          Icons.star,
                          color: goodcolor,
                        );
                      case 1:
                        return Icon(
                          Icons.star,
                          color: goodcolor,
                        );
                      case 2:
                        return Icon(
                          Icons.star,
                          color: goodcolor,
                        );
                      case 3:
                        return Icon(
                          Icons.star,
                          color: goodcolor,
                        );
                      case 4:
                        return Icon(
                          Icons.star,
                          color: goodcolor,
                        );
                    }
                    ;
                    return SizedBox();
                  },
                  onRatingUpdate: (rating) {
                    ratings = rating;
                  }),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 200,
                height: 50,
                child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith(
                          (states) => goodcolor3),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      )),
                    ),
                    onPressed: () {
                      _control.add_student_rate(
                          widget.driver_subscribe.student_id.toString(),
                          ratings.toString(),
                          widget.driver_subscribe.id.toString(),
                          context);
                    },
                    child: Text(
                      "ارسال",
                      style: TextStyle(fontSize: 20),
                    )),
              )
            ],
          ),
        ));
  }

  Widget New(context, name, List<day_model> days) {
    return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
            side: BorderSide(color: goodcolor, width: 2)),
        content: SizedBox(
            //height: 450,
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: goodcolor,
                        ))
                  ],
                ),
                ListTile(
                  title: Text(name.toString()),
                  subtitle: RatingBarIndicator(
                    rating: double.parse('${widget.driver_subscribe.avg}'),
                    itemBuilder: (context, index) => const Icon(
                      Icons.star,
                      color: goodcolor,
                    ),
                    itemCount: 5,
                    itemSize: 20.0,
                    direction: Axis.horizontal,
                  ),
                  leading: Icon(
                    color: goodcolor,
                    Icons.account_circle_outlined,
                    size: 50,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Icon(color: goodcolor, Icons.home_outlined),
                    Text(
                      'العنوان : ${widget.driver_subscribe.street_name}',
                      style: TextStyle(color: goodcolor),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Icon(color: goodcolor, Icons.location_on_outlined),
                    Text('الجامعة : ${widget.driver_subscribe.university_name}',
                        style: TextStyle(color: goodcolor))
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Icon(color: goodcolor, Icons.task_outlined),
                    Text(
                        'تاريخ انتهاء الاشتراك : ${widget.driver_subscribe.end_date}',
                        style: TextStyle(color: goodcolor))
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text('أيام الدوام:', style: TextStyle(color: goodcolor)),
                    Expanded(
                      child: Wrap(
                          alignment: WrapAlignment.center,
                          children: days.map((e) {
                            return Text(
                              e.name.toString() + "  ,  ",
                              style: TextStyle(fontSize: 18, color: goodcolor),
                              textAlign: TextAlign.center,
                            );
                          }).toList()),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Icon(color: goodcolor, Icons.alarm),
                    Column(
                      children: [
                        Text(
                            'الحضور : ${widget.driver_subscribe.start_time.toString()}',
                            style: TextStyle(color: goodcolor)),
                        Text(
                            'الانصراف :  ${widget.driver_subscribe.end_time.toString()}',
                            style: TextStyle(color: goodcolor)),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          _control.update_subscribe('4',
                              widget.driver_subscribe.id.toString(), context);
                          // Navigator.pushAndRemoveUntil(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (BuildContext context) =>
                          //             dashboard_Driver()),
                          //     (route) => false);
                        },
                        child: Text(
                          'رفض',
                          style: TextStyle(
                              fontSize: 17,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                // side: BorderSide(width: 1.0, color: Colors.black),
                                borderRadius: BorderRadius.circular(15)),
                            minimumSize: const Size(50, 50),
                            primary: Colors.red)),
                    ElevatedButton(
                        onPressed: () {
                          _control.update_subscribe('1',
                              widget.driver_subscribe.id.toString(), context);
                          // Navigator.pushAndRemoveUntil(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (BuildContext context) =>
                          //             dashboard_Driver()),
                          //     (route) => false);
                        },
                        child: Text(
                          'قبول',
                          style: TextStyle(
                              fontSize: 17,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                // side: BorderSide(width: 1.0, color: Colors.black),
                                borderRadius: BorderRadius.circular(15)),
                            minimumSize: const Size(50, 50),
                            primary: Color(0xFF7D9D9C))),
                  ],
                )
              ],
            )));
  }
}
