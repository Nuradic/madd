import 'package:get/get.dart';
import 'package:madd/api/SpotApi.dart';
import 'package:madd/api/api_handler.dart';
import 'package:madd/models/models.dart';

class HomeController extends GetxController {
  late List<SpotType> spotType = [];
  late List<Spot> topSpot = [];
  late List<Spot> nearbySpot = [];
  // touch() async {
  //   await APIHandler.post(
  //       path: "/login/",
  //       body: {"email": "nmercer@example.com", "password": "91BuiwON52"});
  //   var loop = await SpotApi.getTypes();
  // }

  setType() async {
    spotType = await SpotApi.getTypes();
    update();
  }

  setTopSpot() async {
    topSpot = await SpotApi.getAll();
    update();
  }

  @override
  void onInit() async {
    setType();
    setTopSpot();

    super.onInit();
  }
}
