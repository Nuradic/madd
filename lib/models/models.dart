import 'dart:convert';

import 'package:madd/api/SpotApi.dart';

List<Spot> spotFromJson(String str) =>
    List<Spot>.from(json.decode(str).map((x) => Spot.fromJson(x)));

String spotToJson(List<Spot> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Spot {
  int id;
  String name;
  String description;
  int cityId;
  String cityName;
  double lat;
  double long;
  String? url;
  Future<String> get rate async => "${await SpotApi.getRate(this)}";

  Spot({
    required this.id,
    required this.name,
    required this.description,
    required this.cityId,
    required this.cityName,
    required this.lat,
    required this.long,
  });

  factory Spot.fromJson(Map<String, dynamic> json) => Spot(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        cityId: json["city_id"],
        cityName: json["city_name"],
        lat: double.parse(json["lat"]),
        long: double.parse(json["long"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "city_id": cityId,
        "city_name": cityName,
        "lat": lat,
        "long": long,
      };
}

List<SpotType> spotTypeFromJson(String str) =>
    List<SpotType>.from(json.decode(str).map((x) => SpotType.fromJson(x)));

String spotTypeToJson(List<SpotType> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SpotType {
  String name;
  int id;

  SpotType({
    required this.name,
    required this.id,
  });

  factory SpotType.fromJson(Map<String, dynamic> json) => SpotType(
        name: json["name"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
      };
}

class City extends SpotType {
  City({
    required name,
    required id,
  }) : super(name: name, id: id);
}

List<ImageApi> imageApiFromJson(String str) =>
    List<ImageApi>.from(json.decode(str).map((x) => ImageApi.fromJson(x)));

String imageApiToJson(List<ImageApi> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ImageApi {
  int id;
  String url;
  int spot;
  int city;
  dynamic placeholder;

  ImageApi({
    required this.id,
    required this.url,
    required this.spot,
    required this.city,
    this.placeholder,
  });

  factory ImageApi.fromJson(Map<String, dynamic> json) => ImageApi(
        id: json["id"],
        url: json["url"],
        spot: json["spot"],
        city: json["city"],
        placeholder: json["placeholder"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
        "spot": spot,
        "city": city,
        "placeholder": placeholder,
      };
}

List<Comment> commentFromJson(String str) =>
    List<Comment>.from(json.decode(str).map((x) => Comment.fromJson(x)));

String commentToJson(List<Comment> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Comment {
  int id;
  String body;
  int userId;
  String username;
  dynamic profile;
  int spot;

  Comment({
    required this.id,
    required this.body,
    required this.userId,
    required this.username,
    this.profile,
    required this.spot,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json["id"],
        body: json["body"],
        userId: json["user_id"],
        username: json["username"],
        profile: json["profile"],
        spot: json["spot"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "body": body,
        "user_id": userId,
        "username": username,
        "profile": profile,
        "spot": spot,
      };
}

List<Rate> rateFromJson(String str) =>
    List<Rate>.from(json.decode(str).map((x) => Rate.fromJson(x)));

String rateToJson(List<Rate> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Rate {
  int id;
  int rateNum;
  int spot;
  static double getAverage(List<Rate> rates) {
    double avg = 0;
    var r = rates.map((e) {
      avg += e.rateNum;
    });
    return avg / rates.length;
  }

  Rate({
    required this.id,
    required this.rateNum,
    required this.spot,
  });

  factory Rate.fromJson(Map<String, dynamic> json) => Rate(
        id: json["id"],
        rateNum: int.parse(json["rate_num"]),
        spot: json["spot"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "rate_num": rateNum,
        "spot": spot,
      };
}
