// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:madd/api/api_handler.dart';
import 'package:madd/models/models.dart';

List<User> userFromJson(String str) =>
    List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

String userToJson(List<User> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
  int id;
  String fname;
  String password;
  String email;
  String profilePic;

  User({
    required this.id,
    required this.fname,
    required this.password,
    required this.email,
    required this.profilePic,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        fname: json["fname"],
        password: json["password"],
        email: json["email"],
        profilePic: json["profile_pic"],
      );

  Map<String, dynamic> toJson() => {
        "fname": fname,
        "password": password,
        "password2": password,
        "email": email,
      };

  static Future<bool> setComment(Spot spot, String body) async {
    var res = await APIHandler.post(
        path: "/comments", body: {"body": body, "spot": "${spot.id}"});

    if (res.statusCode > 299 || res.statusCode < 200) {
      return false;
    }

    return true;
  }

  static Future<bool> signup({required User user}) async {
    await APIHandler.post(body: user.toJson(), path: "users");
    return true;
  }

  static Future<bool> login(
      {required String email, required String password}) async {
    var res = await APIHandler.post(
        body: {"email": email, "password": password}, path: "login");
    if (res.statusCode == 404) {
      Get.showSnackbar(
        const GetSnackBar(
          duration: Duration(seconds: 3),
          title: "Error Log in",
          message: "Invalid Login Credentials",
        ),
      );
      return false;
    }
    await GetStorage().write("user", res.body);
    return true;
  }
}
