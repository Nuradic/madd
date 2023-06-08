import 'package:get/get.dart';

class NavigationController extends GetxController {
  int selected = 0;

  setSelected(int a) {
    selected = a;
    update();
  }
}
