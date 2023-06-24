import 'package:flutter/material.dart';
import 'package:masaruna/auth/signUp/signUp.dart';
import 'package:masaruna/auth/signUp/signUpDriver/stepper_driver.dart';
import 'package:masaruna/controls/user_control.dart';
import 'package:masaruna/screen/dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screen_Driver/dashboard_Driver.dart';
import 'Forgot_your_password.dart';

class loginPage extends StatefulWidget {
  const loginPage({super.key});

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  TextEditingController emailCont = TextEditingController();
  TextEditingController passCont = TextEditingController();

  User_Control _user_control = User_Control();

  check() async {
    final prefs = await SharedPreferences.getInstance();

    String token = prefs.get('id').toString();
    String type = prefs.get('type').toString();

    print('123123  ' + token);
    print('asdsad ' + type);

    if (token != 'null') {
      if (type.toString() == '1') {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => dashboard()),
            (Route<dynamic> route) => false);
      } else {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => dashboard_Driver()),
            (Route<dynamic> route) => false);
      }
    } else {}
  }

  @override
  void initState() {
    check();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double hi = MediaQuery.of(context).size.height;
    double wi = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Container(
      width: wi,
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
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
              'تسجيل الدخول',
              style: TextStyle(
                  color: Color(0xff576f72),
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 25,
            ),
            form(emailCont, 'البريد الالكتروني', TextInputType.emailAddress),
            SizedBox(
              height: 25,
            ),
            form(passCont, 'كلمة المرور', TextInputType.visiblePassword),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'هل نسيت كلمة المرور؟',
                  style: TextStyle(
                    color: Color(0xff576f72),
                    fontSize: 16,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                      return Forgot_your_password();
                    }));
                  },
                  child: Text(
                    'اضغط هنا',
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Color(0xff576f72),
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 85,
            ),
            ElevatedButton(
                onPressed: () {
                  _user_control.login(context, emailCont.text.toString(),
                      passCont.text.toString());
                },
                child: Text(
                  'تسجيل الدخول',
                  style: TextStyle(
                      fontSize: 17,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        // side: BorderSide(width: 1.0, color: Colors.black),
                        borderRadius: BorderRadius.circular(15)),
                    minimumSize: const Size(185, 50),
                    primary: Color(0xFF7D9D9C))),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'ليس لديك حساب ؟ ',
                  style: TextStyle(
                    color: Color(0xff576f72),
                    fontSize: 16,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => signUp()));
                  },
                  child: Text(
                    'إنشاء حساب',
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Color(0xff576f72),
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    ));
  }

  Column form(controllerText, String Title, TextInputType type) {
    return Column(
      children: [
        Container(
          height: 50,
          width: 250,
          child: TextFormField(
            textAlign: TextAlign.center,
            obscureText: type == TextInputType.visiblePassword ? true : false,
            keyboardType: type,
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
            ),
          ),
        ),
      ],
    );
  }
}
