import 'package:madd/api/api_handler.dart';
import 'package:madd/models/models.dart';

class SpotApi {
  static Future<List<Spot>> getAll() async {
    var data = await APIHandler.get("spot/");

    if (data == null) {
      return [];
    }
    return spotFromJson(data);
  }

  static Future<bool> rate(Spot spot, int rate) async {
    await APIHandler.post(
        path: "/rates/", body: {"rate_num": rate, "spot": spot.id});
    return true;
  }

  static Future<double> getRate(Spot spot) async {
    String? str = await APIHandler.get("/rates/?spot=${spot.id}");
    if (str == null) {
      return 0;
    }
    var rates = rateFromJson(str);
    return Rate.getAverage(rates);
  }

  static Future<List<SpotType>> getTypes() async {
    String? str = await APIHandler.get("spot-type");
    if (str == null) {
      return [];
    }

    return spotTypeFromJson(str);
  }
}
