import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:madd/bindings.dart';
import 'package:madd/view/home.dart';
import 'package:madd/view/themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  await GetStorage.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
          bindings: [
            DrawerBindings(),
            CalanderBindings(),
            MapBindings(),
            HomeBindings()
          ],
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
