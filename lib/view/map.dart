import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:madd/controllers/map_home_controller.dart';
import 'package:madd/models/models.dart';

class MapHome extends StatelessWidget {
  Spot spot;
  MapHome({super.key, required this.spot});

  @override
  Widget build(BuildContext context) {
    return MapSample(spot: spot);
  }
}

class MapSample extends StatefulWidget {
  final Spot spot;
  MapSample({super.key, required this.spot});
  final mapController = Get.put<MapHomeController>(MapHomeController());

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
  late CameraPosition pos;

  @override
  void initState() {
    // TODO: implement initState
    pos = CameraPosition(
        bearing: 192.8334901395799,
        target: LatLng(widget.spot.lat, widget.spot.long),
        tilt: 59.440717697143555,
        zoom: 19.151926040649414);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: pos,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
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
