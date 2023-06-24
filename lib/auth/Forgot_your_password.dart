import 'package:flutter/material.dart';
import 'package:masaruna/controls/user_control.dart';

import 'change_Password.dart';

class Forgot_your_password extends StatefulWidget {
  const Forgot_your_password({super.key});

  @override
  State<Forgot_your_password> createState() => _Forgot_your_passwordState();
}

class _Forgot_your_passwordState extends State<Forgot_your_password> {
  TextEditingController emailCon = TextEditingController();
  User_Control _user_control = User_Control();
  @override
  Widget build(BuildContext context) {
    double hi = MediaQuery.of(context).size.height;
    double wi = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF7D9D9C),
        centerTitle: true,
        title: Text('نسيت كلمة المرور'),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back_ios)),
      ),
      body: Container(
        width: wi,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                height: 25,
              ),
              Text(
                'أدخل البريد الإلكتروني لحسابك',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20,
                    color: Color(0xFF7D9D9C),
                    fontWeight: FontWeight.bold),
              ),
              Text(
                '\n وسيتم ارسال رابط لإعادة تعيين \n كلمة المرور',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 15,
                    color: Color(0xFF7D9D9C),
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                width: wi / 1.2,
                height: 50,
                child: TextFormField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.emailAddress,
                  cursorColor: Colors.black,
                  controller: emailCon,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    filled: true,
                    fillColor: Color.fromARGB(255, 240, 239, 239),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Color(0xff576f72))),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Color(0xff576f72))),
                    hintText: 'البريد الإلكتروني',
                    hintStyle: TextStyle(color: Colors.black54),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                  onPressed: () {
                    _user_control.forget_password(
                        context, emailCon.text.toString());
                  },
                  child: Text(
                    'ارسال',
                    style: TextStyle(
                        fontSize: 17,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          // side: BorderSide(width: 1.0, color: Colors.black),
                          borderRadius: BorderRadius.circular(15)),
                      minimumSize: const Size(300, 50),
                      primary: Color(0xff80a3a2))),
              Image.asset('assets/images/RestPassword.png')
            ],
          ),
        ),
      ),
    );
  }
}
