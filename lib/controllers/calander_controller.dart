import 'dart:async';

import 'package:abushakir/abushakir.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CalanderController extends GetxController {
  int month = ETC.today().month;
  int year = ETC.today().year;
  final listController = ScrollController();
  late List<List> cal;
  late Timer timer = Timer(const Duration(seconds: 1), () {
    getMonthly();
  });

  getMonthly() {
    ETC etc = ETC(year: year, month: month);
    var days = etc.monthDays().toList();
    int offset = days[0][3];
    int onset = 35 - days.length - offset;
    var kool = List.generate(offset, (index) => [30 - index, false]);
    var ff = kool.reversed.toList();
    List<List<Object>> mm =
        List.generate(days.length, (index) => [days[index][2], true]);
    var ll = List.generate(onset, (index) => [index + 1, false]);
    update();
    cal = ff + mm + ll;
    return ff + mm + ll;
  }

  getPrev() {
    if (month >= 1) {
      month--;
    } else {
      year--;
      month = 13;
    }
    getMonthly();
    update();
  }

  getNext() {
    if (month <= 12) {
      month++;
    } else {
      month = 1;
      year++;
    }
    getMonthly();
    update();
  }

  @override
  void onInit() {
    cal = getMonthly();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    listController.dispose();
  }
}
