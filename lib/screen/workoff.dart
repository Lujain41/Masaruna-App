import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:masaruna/constant.dart';
import 'package:masaruna/controls/control.dart';
import 'package:intl/intl.dart';

class WorkOff extends StatefulWidget {
  const WorkOff({
    Key? key,
  }) : super(key: key);

  @override
  State<WorkOff> createState() => _WorkOffState();
}

class _WorkOffState extends State<WorkOff> {
  Control _control = Control();

  DateTime currentDate = DateTime.now();
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextEditingController date0 = TextEditingController();
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0))),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 30,
          ),
          const Text(
            "الإعتذار عن يوم",
            style: TextStyle(
                color: goodcolor, fontWeight: FontWeight.bold, fontSize: 25),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            width: 20,
          ),
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
      content: Form(
        child: SizedBox(
          height: 550,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: 550,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'اليوم المعتذر عنه:',
                      style: TextStyle(fontSize: 20, color: goodcolor2),
                    ),
                    SizedBox(
                      //   width: 300,
                      height: 450,
                      child: DatePickerDialog(
                        cancelText: "",
                        confirmText: "",
                        currentDate: currentDate,
                        initialCalendarMode: DatePickerMode.day,
                        initialEntryMode: DatePickerEntryMode.calendarOnly,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2030),
                      ),
                    ),
                    SizedBox(
                        width: 150,
                        child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateColor.resolveWith(
                                    (states) => goodcolor2),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ))),
                            onPressed: () {
                              String date =
                                  DateFormat('yyyy-MM-dd').format(currentDate);
                              _control.add_execuse(context, date);
                            },
                            child: Text("إرسال")))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
