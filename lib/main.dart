import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:madd/bindings.dart';
import 'package:madd/view/calender.dart';
import 'package:madd/view/currency.dart';
import 'package:madd/view/home.dart';
import 'package:madd/view/map.dart';
import 'package:madd/view/themes.dart';

void main() {
  runApp(
    const TourBase(),
  );
}

class TourBase extends StatelessWidget {
  const TourBase({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(
          name: "/home",
          page: () => HomeMain(),
          bindings: [DrawerBindings(), CalanderBindings(), MapBindings()],
        ),
        // GetPage(
        //   name: "/calender",
        //   page: () => const Calander(),
        //   bindings: [CalanderBindings(), DrawerBindings()],
        // ),
        // GetPage(
        //   name: "/currency",
        //   page: () => const CurrencyHome(),
        //   bindings: [DrawerBindings()],
        // ),
        // GetPage(
        //   name: "/map",
        //   page: () => const MapHome(),
        //   bindings: [DrawerBindings()],
        // ),
      ],
      initialRoute: '/home',
      themeMode: ThemeMode.light,
      theme: lightTheme,
      darkTheme: darkTheme,
    );
  }
}
