import 'package:flutter/material.dart';

class change_Password extends StatefulWidget {
  const change_Password({super.key});

  @override
  State<change_Password> createState() => _change_PasswordState();
}

class _change_PasswordState extends State<change_Password> {
  TextEditingController passwordContr = TextEditingController();
  TextEditingController ConwordContr = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double hi = MediaQuery.of(context).size.height;
    double wi = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF7D9D9C),
        centerTitle: true,
        title: Text('تغير كلمة المرور'),
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
                height: 50,
              ),
              form(passwordContr, 'كلمة المرور الجديدة',
                  TextInputType.visiblePassword),
              SizedBox(
                height: 30,
              ),
              form(passwordContr, 'التحقق من كلمة المرور الجديدة',
                  TextInputType.visiblePassword),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                  onPressed: () {
                    // loginUser(type);
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

  Column form(controllerText, String Title, TextInputType type) {
    return Column(
      children: [
        Container(
          height: 50,
          width: 250,
          child: TextFormField(
            textAlign: TextAlign.center,
            obscureText: false,
            keyboardType: type,
            cursorColor: Colors.black,
            // controller: controllerText,
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
              hintText: Title,
              hintStyle: TextStyle(color: Colors.black54),
            ),
          ),
        ),
      ],
    );
  }
}
