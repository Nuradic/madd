import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:madd/controllers/map_home_controller.dart';

class MapHome extends StatelessWidget {
  MapHome({super.key});

  @override
  Widget build(BuildContext context) {
    return MapSample();
  }
}

class MapSample extends StatefulWidget {
  MapSample({
    super.key,
  });
  final mapController = Get.find<MapHomeController>();

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        // markers: widget.mapController.getMarker(),
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: const Text('To My Location'),
        icon: const Icon(Icons.directions_boat),
      ),
      // bottomSheet: const GetMapBottomSheet(),
    );
  }

  // Marker mk = const Marker(
  //     markerId: MarkerId("1"),
  //     position: LatLng(0, 0),
  //     icon: BitmapDescriptor.defaultMarker);

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(
        CameraUpdate.newCameraPosition(await widget.mapController.goto()));
  }
}

class GetMapBottomSheet extends StatefulWidget {
  const GetMapBottomSheet({super.key});

  @override
  State<GetMapBottomSheet> createState() => _GetMapBottomSheetState();
}

class _GetMapBottomSheetState extends State<GetMapBottomSheet>
    with SingleTickerProviderStateMixin {
  @override
  void dispose() {
    //
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      onClosing: () {},
      showDragHandle: true,
      onDragStart: (details) {
        // print("cooling of");
      },
      animationController: BottomSheet.createAnimationController(this),
      onDragEnd: (details, {required isClosing}) => const Text("cool"),
      builder: (context) => SafeArea(
        child: Container(
          height: 400,
        ),
      ),
    );
  }
}
