import 'package:get/get.dart';

class CurrencyController extends GetxController {
  int selectedCurrency = 1;

  setSelected(int value) {
    selectedCurrency = value;
    update();
  }
}
