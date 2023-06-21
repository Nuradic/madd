import 'package:get/get.dart';
import 'package:madd/controllers/calender_controller.dart';
import 'package:madd/controllers/map_home_controller.dart';

import 'controllers/navigation_controller.dart';

class DrawerBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => NavigationController(),
    );
  }
}

class CalanderBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => CalenderController(),
    );
  }
}

class CurrencyBindings extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
  }
  // ETC Ethiopian = ETC();
}

class MapBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MapHomeController());
  }
}
