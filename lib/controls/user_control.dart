import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:masaruna/auth/login.dart';
import 'package:masaruna/auth/signUp/signUpDriver/stepper_driver.dart';
import 'package:masaruna/auth/signUp/stepper_student.dart';
import 'package:masaruna/model/city_model.dart';
import 'package:masaruna/model/universities_model.dart';
import 'package:masaruna/model/user_model.dart';
import 'package:masaruna/screen/dashboard.dart';
import 'package:masaruna/screen_Driver/dashboard_Driver.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Utils/URL.dart';
import '../model/day_model.dart';
import '../model/streets_model.dart';

class User_Control {
  String? type;
  String? id;
  login(context, String email, String password) async {
    print('object');
    var myUrl = Uri.parse("$serverUrl/login_client");
    final response = await http.post(myUrl, body: {
      "email": email,
      "password": password,
    });

    print(response.body);

    if (json.decode(response.body)['status'] == "1") {
      _save(json.decode(response.body)['data']['id'].toString(), 'id');
      _save(json.decode(response.body)['data']['type_id'].toString(), 'type');
      _save(
          json.decode(response.body)['data']['city_id'].toString(), 'city_id');
      type = json.decode(response.body)['data']['type_id'].toString();
      print(type);
      if (type == '1') {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => dashboard()),
            (Route<dynamic> route) => false);
      } else {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => dashboard_Driver()),
            (Route<dynamic> route) => false);
      }
      print('object');
    } else
      return AwesomeDialog(
        context: context,
        dialogType: DialogType.warning,
        animType: AnimType.bottomSlide,
        title: 'الحساب غير موجود',
        desc: 'تأكد من صحة البيانات',
        btnOkOnPress: () {},
      )..show();
  }

  Future register_Stu(
      String phone, String email, String password, String type, context) async {
    var myUrl = Uri.parse("$serverUrl/register_student");
    final response = await http.post(myUrl, body: {
      'password': password,
      'phone': phone,
      'email': email,
      'type_id': type
    });
    print(response.body);
    if (json.decode(response.body)['status'] == "1") {
      id = json.decode(response.body)['data']['id'].toString();
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: ((context) => StepperStudent(id: id.toString()))));
    } else {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.bottomSlide,
        title: 'ERROR',
        // btnOkOnPress: () {},
      ).show();
    }
  }

  Future register_driver(
      String phone, String email, String password, String type, context) async {
    var myUrl = Uri.parse("$serverUrl/register_driver");
    final response = await http.post(myUrl, body: {
      'password': password,
      'phone': phone,
      'email': email,
      'type_id': type
    });
    print(response.body);
    if (json.decode(response.body)['status'] == "1") {
      id = json.decode(response.body)['data']['id'].toString();
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: ((context) => StepperDriver(id: id.toString()))));
    } else {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.bottomSlide,
        title: 'ERROR',
        // btnOkOnPress: () {},
      ).show();
    }
  }

  Future register_student_complete(
      String name,
      String gender,
      String city_id,
      String street_id,
      String home_number,
      String lat,
      String long,
      String university_id,
      String start_time,
      String end_time,
      String Id,
      context) async {
    var myUrl = Uri.parse("$serverUrl/register_student_complete");
    final response = await http.post(myUrl, body: {
      'name': name,
      'gender': gender,
      'city': city_id,
      'street': street_id,
      'home_number': home_number,
      'lat': lat,
      'long': long,
      'university': university_id,
      'start_time': start_time,
      'end_time': end_time,
      'id': Id,
    });
    print('==================================');
    print(response.body);
    print('==================================');

    if (json.decode(response.body)['status'] == "1") {
      // id = json.decode(response.body)['data']['id'].toString();
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: ((context) => loginPage())),
          (route) => false);
    } else {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.bottomSlide,
        title: 'ERROR',
        // btnOkOnPress: () {},
      ).show();
    }
  }

  Future register_driver_complete(
      File image,
      String name,
      String gander,
      String city,
      String street,
      String university,
      String car,
      String seats,
      String car_number,
      String range,
      String time,
      String cost,
      String user_id,
      context) async {
    print('================================');
    print(image);
    String fileName = image.path.split("/").last;
    print(fileName);
    print('================================');

    var formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(image.path, filename: fileName),
      'name': name,
      'gender': gander,
      'city': city,
      'street': street,
      'university': university,
      'car': car,
      'seats': seats,
      'car_number': car_number,
      'range': range,
      'time': time,
      'cost': cost,
      'id': user_id,
    });

    var dio = Dio();

    var response =
        await dio.post('$serverUrl/register_driver_complete', data: formData);
    print(response.data);
    if (response.data['status'] == "1") {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => loginPage()),
          (route) => false);
    } else {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.bottomSlide,
        title: 'Error',
        // btnOkOnPress: () {},
      ).show();
    }
  }

  Future update_profile(
      String name,
      String gender,
      String home_number,
      String lat,
      String long,
      String start_time,
      String end_time,
      String phone,
      String password,
      String email,
      String city,
      String street,
      String university,
      String type_id,
      String car,
      String seats,
      String car_number,
      String cost,
      String range,
      String time,
      context) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'id';
    final client_id = prefs.get(key);

    print(client_id);
    var myUrl = Uri.parse("$serverUrl/update_profile");
    final response = await http.post(myUrl, body: {
      'id': client_id,
      'name': name,
      'gender': gender,
      'home_number': home_number,
      'lat': lat,
      'long': long,
      'start_time': start_time,
      'end_time': end_time,
      'phone': phone,
      'password': password,
      'type_id': type_id,
      'car': car,
      'seats': seats,
      'car_number': car_number,
      'range': range,
      'time': time,
      'cost': '0',
      'city': city,
      'street': street,
      'university': university,
      'email': email,
    });
    print(response.body);
    if (json.decode(response.body)['status'] == "1") {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.success,
        animType: AnimType.bottomSlide,
        title: 'Done!',
        // btnOkOnPress: () {},
      ).show();
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: ((context) => dashboard())),
          (route) => false);
    } else {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.bottomSlide,
        title: 'ERROR',
        // btnOkOnPress: () {},
      ).show();
    }
  }

  Future update_profile_Driver(
      String name,
      String gender,
      String home_number,
      String lat,
      String long,
      String start_time,
      String end_time,
      String phone,
      String password,
      String email,
      String city,
      String street,
      String university,
      String type_id,
      String car,
      String seats,
      String car_number,
      int cost,
      String range,
      String time,
      context) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'id';
    final client_id = prefs.get(key);

    print('===========');
    print(cost);
    var myUrl = Uri.parse("$serverUrl/update_profile");
    final response = await http.post(myUrl, body: {
      'id': client_id,
      'name': name,
      'gender': gender,
      'home_number': '0',
      'lat': lat,
      'long': long,
      'start_time': '10:00:00',
      'end_time': '11:00:00',
      'phone': phone,
      'password': password,
      'type_id': type_id,
      'car': car,
      'seats': seats,
      'car_number': car_number,
      'range': range,
      'time': time,
      'cost': cost,
      'city': city,
      'street': street,
      'university': university,
      'email': email,
    });
    print(response.body);
    if (json.decode(response.body)['status'] == "1") {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.success,
        animType: AnimType.bottomSlide,
        title: 'Done!',
        // btnOkOnPress: () {},
      ).show();
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: ((context) => dashboard_Driver())),
          (route) => false);
    } else {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.bottomSlide,
        title: 'ERROR',
        // btnOkOnPress: () {},
      ).show();
    }
  }

  Future add_days(String day_id, context) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'id';
    final client_id = prefs.get(key);
    var myUrl = Uri.parse("$serverUrl/add_days");
    final response = await http
        .post(myUrl, body: {'client_id': client_id, 'day_id': day_id});
    print(response.body);
    if (json.decode(response.body)['status'] == "1") {
    } else {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.bottomSlide,
        title: 'ERROR',
        // btnOkOnPress: () {},
      ).show();
    }
  }

  Future delete_day(String day_id, context) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'id';
    final client_id = prefs.get(key);
    var myUrl = Uri.parse("$serverUrl/delete_day");
    final response = await http
        .post(myUrl, body: {'client_id': client_id, 'day_id': day_id});
    print(response.body);
    if (json.decode(response.body)['status'] == "1") {
    } else {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.bottomSlide,
        title: 'ERROR',
        // btnOkOnPress: () {},
      ).show();
    }
  }

  Future profile() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'id';
    final client_id = prefs.get(key);

    print(client_id);
    var myUrl = Uri.parse("$serverUrl/get_profile_client");
    final response = await http.post(myUrl, body: {
      'id': client_id,
    });
    print(response.body);
    if (json.decode(response.body)['status'] == "1") {
      try {
        user_model advertisment =
            user_model.fromJson(jsonDecode(response.body)['data']);

        return advertisment;
      } catch (error) {
        print(error);
      }
    } else {}
  }

  Future<List<day_model>?> get_my_days() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'id';
    final client_id = prefs.get(key);

    print(client_id);
    var myUrl = Uri.parse("$serverUrl/get_my_days");
    final response = await http.post(myUrl, body: {
      'client_id': client_id,
    });
    print(response.body);
    if (json.decode(response.body)['status'] == "1") {
      List<dynamic> body = jsonDecode(response.body)['data'];
      try {
        List<day_model> orders = body
            .map(
              (dynamic item) => day_model.fromJson(item),
            )
            .toList();
        return orders;
      } catch (error) {
        print(error);
        return null;
      }
    } else {}
  }

  Future<List<day_model>?> get_my_dayss(id) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'id';
    final client_id = prefs.get(key);

    print(client_id);
    var myUrl = Uri.parse("$serverUrl/get_my_days");
    final response = await http.post(myUrl, body: {
      'client_id': id,
    });
    print(response.body);
    if (json.decode(response.body)['status'] == "1") {
      List<dynamic> body = jsonDecode(response.body)['data'];
      try {
        List<day_model> orders = body
            .map(
              (dynamic item) => day_model.fromJson(item),
            )
            .toList();
        return orders;
      } catch (error) {
        print(error);
        return null;
      }
    } else {}
  }

  Future<List<citie_model>?> get_cities() async {
    var myUrl = Uri.parse("$serverUrl/get_cities");
    final response = await http.get(myUrl);
    print(response.body);
    if (json.decode(response.body)['status'] == "1") {
      List<dynamic> body = jsonDecode(response.body)['data'];
      try {
        List<citie_model> orders = body
            .map(
              (dynamic item) => citie_model.fromJson(item),
            )
            .toList();
        return orders;
      } catch (error) {
        print(error);
        return null;
      }
    } else {}
  }

  Future<List<streets_model>?> get_streets() async {
    var myUrl = Uri.parse("$serverUrl/get_streets");
    final response = await http.get(myUrl);
    print(response.body);
    if (json.decode(response.body)['status'] == "1") {
      List<dynamic> body = jsonDecode(response.body)['data'];
      try {
        List<streets_model> orders = body
            .map(
              (dynamic item) => streets_model.fromJson(item),
            )
            .toList();
        return orders;
      } catch (error) {
        print(error);
        return null;
      }
    } else {}
  }

  Future<List<universities_model>?> get_universities() async {
    var myUrl = Uri.parse("$serverUrl/get_universities");
    final response = await http.get(myUrl);
    print(response.body);
    if (json.decode(response.body)['status'] == "1") {
      List<dynamic> body = jsonDecode(response.body)['data'];
      try {
        List<universities_model> orders = body
            .map(
              (dynamic item) => universities_model.fromJson(item),
            )
            .toList();
        return orders;
      } catch (error) {
        print(error);
        return null;
      }
    } else {}
  }

  forget_password(context, String email) async {
    var myUrl = Uri.parse("$serverUrl/forget_password");
    print(email);
    final response = await http.post(myUrl, body: {
      'email': email,
    });
    print(response.body);
    if (json.decode(response.body)['status'] == "1") {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.success,
        animType: AnimType.bottomSlide,
        title: 'Done',
        // btnOkOnPress: () {},
      ).show();
    } else {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.bottomSlide,
        title: 'الحساب غير موجود',
        // btnOkOnPress: () {},
      ).show();
    }
  }

  delete_client(context) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'id';
    final client_id = prefs.get(key);
    var myUrl = Uri.parse("$serverUrl/delete_client");
    final response = await http.post(myUrl, body: {'client_id': client_id});
    print(response.body);
    if (json.decode(response.body)['status'] == "1") {
      final prefs = await SharedPreferences.getInstance();
      prefs.clear();
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => loginPage()),
          (route) => false);
    } else {}
  }

  _save(String token, String key) async {
    final prefs = await SharedPreferences.getInstance();
    // final key = 'Token';
    // final value = token;
    prefs.setString(key, token);
  }
}
