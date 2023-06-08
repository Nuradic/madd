import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:madd/bindings.dart';
import 'package:madd/view/calender.dart';
import 'package:madd/view/home.dart';
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
          page: () => const Home(),
          bindings: [DrawerBindings()],
        ),
        GetPage(
          name: "/calender",
          page: () => const Calander(),
          bindings: [CalanderBindings()],
        ),
      ],
      initialRoute: '/home',
      themeMode: ThemeMode.light,
      theme: lightTheme,
      darkTheme: darkTheme,
    );
  }
}
