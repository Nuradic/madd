import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import "package:location/location.dart";

class MapHomeController extends GetxController {
  goto() async {
    return CameraPosition(
        bearing: 192.8334901395799,
        target: LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
        tilt: 59.440717697143555,
        zoom: 19.151926040649414);
  }

  Set<Marker> getMarker() {
    return {
      Marker(
          infoWindow: const InfoWindow(
              title: "Hello,Murad Was here", snippet: "Here lies the murad"),
          markerId: const MarkerId("1"),
          position:
              LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
          icon: BitmapDescriptor.defaultMarker)
    };
  }

  LocationData? currentLocation;

  initiateLocation() async {
    Location location = Location();
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
  }

  @override
  void onInit() async {
    await initiateLocation();
    Location location = Location();
    currentLocation = await location.getLocation();
    super.onInit();
  }
}
