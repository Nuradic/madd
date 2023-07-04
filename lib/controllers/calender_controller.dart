import 'dart:async';

import 'package:abushakir/abushakir.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CalenderController extends GetxController {
  int month = ETC.today().month;
  int year = ETC.today().year;
  final calScrollController = ScrollController(initialScrollOffset: 650);
  final listController = ScrollController();
  late List<List> cal;
  late int currentDay = ETC.today().day;
  late int currentMonth = ETC.today().month;
  late int currentYear = ETC.today().year;
  late Timer timer = Timer(const Duration(seconds: 1), () {});

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
    cal = ff + mm + ll;
    update();
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
    super.onInit();
    getMonthly();
  }

  @override
  void onReady() {
    // calScrollController.animateTo(650,
    //     duration: const Duration(microseconds: 100),
    //     curve: Curves.bounceInOut); // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    listController.dispose();
  }
}
