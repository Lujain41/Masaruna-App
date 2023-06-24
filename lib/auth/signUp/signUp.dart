import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:masaruna/auth/signUp/signUpDriver/stepper_driver.dart';
import 'package:masaruna/constant.dart';

import '../login.dart';
import 'OPT.dart';
import 'infoUser.dart';

class signUp extends StatefulWidget {
  const signUp({super.key});

  @override
  State<signUp> createState() => _signUpState();
}

class _signUpState extends State<signUp> {
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool check = false;
  var Doctor_name;

  var maleOrFemale;
  String type = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 100,
              ),
              Image.asset(
                'assets/images/Logo.png',
                height: 100,
              ),
              SizedBox(
                height: 50,
              ),
              Text(
                'إنشاء حساب',
                style: TextStyle(
                    color: goodcolor, fontSize: 30, fontFamily: 'Tajawal'),
              ),
              SizedBox(
                height: 30,
              ),
              form(emailController, 'البريد الالكتروني',
                  TextInputType.emailAddress),
              SizedBox(
                height: 15,
              ),
              form(phoneController, 'رقم الجوال', TextInputType.phone,
                  lenght: 10),
              SizedBox(
                height: 15,
              ),
              form(passwordController, 'كلمة المرور',
                  TextInputType.visiblePassword),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(),
                  SizedBox(),
                  Row(
                    children: [
                      Radio(
                        activeColor: Colors.black,
                        value: "طالب",
                        groupValue: maleOrFemale,
                        onChanged: (value) {
                          setState(() {
                            maleOrFemale = value;
                            type = '1';
                          });
                        },
                      ),
                      Text('طالب'),
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        activeColor: Colors.black,
                        value: "سائق باص",
                        groupValue: maleOrFemale,
                        onChanged: (value) {
                          setState(() {
                            maleOrFemale = value;
                            type = '2';
                          });
                        },
                      ),
                      Text('سائق باص'),
                    ],
                  ),
                  SizedBox(),
                  SizedBox(),
                ],
              ),
              SizedBox(
                height: 75,
              ),
              ElevatedButton(
                onPressed: () async {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: ((context) => OPT_Page(
                  //               type: type,
                  //               email: emailController.text.toString(),
                  //               pass: passwordController.text.toString(),
                  //               phone: phoneController.text.toString(),
                  //               verificationId: '',
                  //             ))));
                  if (emailController.text.isNotEmpty &&
                      phoneController.text.length > 9 &&
                      passwordController.text.isNotEmpty &&
                      type != "") {
                    await FirebaseAuth.instance.verifyPhoneNumber(
                      phoneNumber: "+966${phoneController.text}",
                      verificationCompleted:
                          (PhoneAuthCredential credential) {},
                      verificationFailed: (FirebaseAuthException e) {},
                      codeSent: (String verificationId, int? resendToken) {
                        setState(() {
                          //  showLoading = false;
                        });
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OPT_Page(
                                      verificationId: verificationId,
                                      email: emailController.text.toString(),
                                      phone: phoneController.text.toString(),
                                      pass: passwordController.text.toString(),
                                      type: type,
                                    )));
                      },
                      codeAutoRetrievalTimeout: (String verificationId) {},
                    );
                  } else {
                    print(emailController.text);
                    print(phoneController.text);
                    print(passwordController.text);
                    print(type);
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
                  'إنشاء حساب',
                  style: TextStyle(
                      color: Colors.white, fontSize: 15, fontFamily: 'Tajawal'),
                ),
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        // side: BorderSide(width: 2.0, color: Colors.black),
                        borderRadius: BorderRadius.circular(15)),
                    minimumSize: const Size(190, 50),
                    primary: Color(0xFF7D9D9C)),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return loginPage();
                  }));
                },
                child: Text(
                  'هل لديك حساب ؟ تسجيل دخول',
                  style: TextStyle(
                      color: Color(0xff576f72),
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column form(controllerText, String Title, TextInputType type, {int? lenght}) {
    return Column(
      children: [
        Container(
          // padding: EdgeInsets.symmetric(ho5),
          //  height: 60,
          width: 250,
          child: TextFormField(
            maxLength: lenght,
            textAlign: TextAlign.center,
            obscureText: type == TextInputType.visiblePassword ? true : false,
            keyboardType: type,
            cursorColor: Colors.black,
            controller: controllerText,
            inputFormatters: lenght == 9
                ? <TextInputFormatter>[
                    // for below version 2 use this
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
// for version 2 and greater youcan also use this
                    FilteringTextInputFormatter.digitsOnly
                  ]
                : null,
            decoration: InputDecoration(
              counter: Offstage(),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black38),
                borderRadius: BorderRadius.circular(15),
              ),
              filled: true,
              fillColor: Color(0xFFF0EFEF),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: Colors.black38)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: Colors.black)),
              hintText: Title,
              hintStyle: TextStyle(
                  color: Colors.black54, fontSize: 12, fontFamily: 'Tajawal'),
            ),
          ),
        ),
      ],
    );
  }

  // Column button(String title, String type) {
  //   return Column(
  //     children: [
  //       ElevatedButton(
  //         onPressed: () {
  //           Navigator.push(context,
  //               MaterialPageRoute(builder: (BuildContext context) {
  //             return OPT_Page(
  //               type: type,
  //             );
  //           }));
  //         },
  //         child: Text(
  //           title,
  //           style: TextStyle(
  //               color: Colors.black, fontSize: 15, fontFamily: 'Tajawal'),
  //         ),
  //         style: ElevatedButton.styleFrom(
  //             shape: RoundedRectangleBorder(
  //                 // side: BorderSide(width: 2.0, color: Colors.black),
  //                 borderRadius: BorderRadius.circular(15)),
  //             minimumSize: const Size(190, 50),
  //             primary: Color(0xFF7D9D9C)),
  //       )
  //     ],
  //   );
  // }
}
