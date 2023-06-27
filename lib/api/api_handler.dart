import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class APIHandler {
  static const baseUrl = "http://192.168.0.3:8000/";
  static final store = GetStorage();
  static String getCookie() {
    String? cache = store.read("Cookie");
    cache ??= "";

    return cache;
  }

  static setCookie(String cookie) {
    store.write("Cookie", cookie);
  }

  static Map<String, String> getHeaders() {
    return {"Cookie": getCookie()};
  }

  static Future<String?> get(String path) async {
    var client = http.Client();
    String? res;
    try {
      var response = await client.get(
        Uri.parse(baseUrl + path),
        headers: getHeaders(),
      );
      var cookie = response.headers["set-cookie"] != null
          ? response.headers["set-cookie"]!.split(";")[0]
          : null;
      cookie != null ? setCookie(cookie) : "";
      if (response.statusCode == 401) {
        Get.showSnackbar(const GetSnackBar(
          title: "Needs Authentication",
        ));
        return null;
      }
      if (response.statusCode == 400) {
        Get.showSnackbar(const GetSnackBar(
          title: "Bad Request",
        ));
        return null;
      }
      if (response.statusCode != 200) {
        return null;
      }
      res = response.body;
    } on Exception {
      return null;
    } finally {
      client.close();
    }
    return res;
  }

  static post(
      {required Map<String, dynamic> body, required String path}) async {
    var client = http.Client();
    try {
      var response = await client.post(Uri.parse(baseUrl + path),
          body: body, headers: getHeaders());
    } on Exception {
      print("object");
    } finally {
      client.close();
    }
  }
}
