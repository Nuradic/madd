import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:madd/bindings.dart';
import 'package:madd/view/Login/login_screen.dart';
import 'package:madd/view/Signup/signup_screen.dart';
import 'package:madd/view/Welcome/welcome_screen.dart';
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
            HomeBindings(),
            CurrencyBind()
          ],
        ),
        GetPage(
          name: "/login",
          page: () => const LoginScreen(),
          bindings: [CalanderBindings(), DrawerBindings()],
        ),
        GetPage(
          name: "/signup",
          page: () => const SignUpScreen(),
          bindings: [DrawerBindings()],
        ),
        GetPage(
          name: "/welcome",
          page: () => const WelcomeScreen(),
          bindings: [DrawerBindings()],
        ),
      ],
      initialRoute: '/home',
      themeMode: ThemeMode.light,
      theme: lightTheme,
      darkTheme: darkTheme,
    );
  }
}
