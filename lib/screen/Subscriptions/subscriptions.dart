import 'dart:math';
import 'package:intl/intl.dart' as int;

import 'package:flutter/material.dart';
import 'package:masaruna/constant.dart';
import 'package:masaruna/controls/control.dart';
import 'package:masaruna/model/driver_model.dart';
import 'package:masaruna/screen/Subscriptions/driverrate.dart';
import 'package:masaruna/screen/Subscriptions/payment.dart';
import 'package:masaruna/screen/Subscriptions/subscribenow.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;
import 'package:url_launcher/url_launcher.dart';

import '../notification.dart';
import '../popup.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class SubscriptionsWidget extends StatefulWidget {
  const SubscriptionsWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<SubscriptionsWidget> createState() => _SubscriptionsWidgetState();
}

class _SubscriptionsWidgetState extends State<SubscriptionsWidget> {
  Control _control = Control();
  List<driver_model> Ldriver = [];
  get_student_subscribe() async {
    await _control.get_student_subscribe().then((value) {
      setState(() {
        Ldriver = value!;
      });
    });
  }

  @override
  void initState() {
    get_student_subscribe();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('اشتراكاتي'),
        centerTitle: true,
        leading: SizedBox(),
        actions: [
          Ldriver.length == 0
              ? IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SubscribeNowPage()));
                  },
                  icon: Icon(
                    Icons.add_circle_outline,
                    size: 35,
                  ))
              : SizedBox()
        ],
      ),
      body: Ldriver.isEmpty
          ? Center(
              child: Container(
                child: CircularProgressIndicator(),
              ),
            )
          : Column(
              children: [
                Expanded(
                    child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  width: size.width,
                  child: ListView.builder(
                    itemCount: Ldriver.length,
                    itemBuilder: (context, index) {
                      return SubscriptionsCard(
                        driver: Ldriver[index],
                      );
                    },
                  ),
                ))
              ],
            ),
    );
  }
}

class SubscriptionsCard extends StatelessWidget {
  SubscriptionsCard({Key? key, required this.driver}) : super(key: key);
  driver_model driver;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 30, bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Kbackground,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "اسم السائق: ${driver.name.toString()}",
                style: TextStyle(fontSize: 18),
              ),
              Text(
                "نوع المركبة: ${driver.car.toString()}",
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              IconButton(
                  onPressed: () {
                    UrlLauncher.launch('tel:${driver.phone.toString()}');
                  },
                  icon: Icon(
                    Icons.phone,
                    size: 50,
                    color: goodcolor,
                  )),
              SizedBox(
                width: 100,
                height: 35,
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateColor.resolveWith(
                            (states) => (driver.status.toString() == '1'
                                ? Color.fromARGB(255, 25, 134, 223)
                                : driver.status.toString() == '2'
                                    ? goodcolor3
                                    : driver.status.toString() == '3'
                                        ? Color.fromARGB(255, 238, 211, 56)
                                        : goodcolor4)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ))),
                    onPressed: () {
                      driver.status.toString() == '1'
                          ? Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => PaymentPage(
                                        driver: driver,
                                      ))))
                          : driver.status.toString() == '3'
                              ? showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return StatefulBuilder(
                                        builder: (context, setState) {
                                      return DriverRate();
                                    });
                                  })
                              : null;
                    },
                    child: driver.status.toString() == '0'
                        ? Text("انتظار")
                        : driver.status.toString() == '1'
                            ? Text("أدفع")
                            : driver.status.toString() == '2'
                                ? Text("مشترك")
                                : Text('تقييم')),
              )
            ],
          )
        ],
      ),
    );
  }

  Future<void> _launchUrl(_url) async {
    if (!await launchUrl(_url)) {
      throw 'Could not launch $_url';
    }
  }
}
