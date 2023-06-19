import 'package:get/get.dart';
import 'package:madd/controllers/calander_controller.dart';

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
      () => CalanderController(),
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
