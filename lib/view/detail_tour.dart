import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madd/api/SpotApi.dart';
import 'package:madd/api/api_handler.dart';
import 'package:madd/models/models.dart';
import 'package:madd/view/currency.dart';
import 'package:madd/view/home.dart';
import 'package:madd/view/map.dart';

class DetailHome extends StatelessWidget {
  final Spot spot;
  DetailHome({super.key, required this.spot});
  final _editController = TextEditingController();
  Widget tileForDetail(context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 15, top: 15, left: 10, right: 10),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).primaryColor,
          boxShadow: const [
            BoxShadow(spreadRadius: 4, blurRadius: 10, color: Colors.black38)
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FutureBuilder(
            initialData: "..",
            future: spot.rate,
            builder: (context, AsyncSnapshot<String> snapshot) => Text(
              snapshot.data ?? "0.0",
              style: GoogleFonts.roboto(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              Get.to(MapHome(spot: spot));
            },
            icon: const FaIcon(
              FontAwesomeIcons.mapMarkerAlt,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {
              Get.bottomSheet(CommentSheet(
                spot: spot,
              ));
            },
            icon: const FaIcon(
              Icons.comment,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _editController.text = spot.description;

    return Scaffold(
      body: CustomScrollView(slivers: [
        SliverAppBar(
          expandedHeight: 400,
          stretch: true,
          title: Text(spot.name),
          flexibleSpace: FlexibleSpaceBar(
            background: FutureBuilder(
              future: spot.images,
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data.length != 0) {
                  return Image(
                    fit: BoxFit.cover,
                    image:
                        NetworkImage(APIHandler.baseUrl + snapshot.data[0].url),
                  );
                }
                return Container();
              },
            ),
          ),
        ),
        sliverAdapter(widget: tileForDetail(context)),
        SliverStickyHeader.builder(
          builder: (contex, state) => Card(
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.only(top: 16, left: 10),
              child: Row(
                children: [
                  const Expanded(flex: 1, child: FaIcon(Icons.dehaze)),
                  Expanded(
                    flex: 2,
                    child: Text(
                      "Description",
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          sliver: sliverAdapter(
            widget: TextField(
              decoration:
                  const InputDecoration(contentPadding: EdgeInsets.all(10)),
              maxLines: null,
              controller: _editController,
              enabled: false,
            ),
          ),
        ),
        SliverStickyHeader.builder(
          builder: ((context, state) {
            return Card(
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.only(top: 16, left: 10),
                child: Row(
                  children: [
                    const Expanded(
                        flex: 1, child: FaIcon(FontAwesomeIcons.images)),
                    Expanded(
                      flex: 2,
                      child: Text(
                        "Gallery",
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
          sliver: sliverAdapter(
            widget: FutureBuilder(
              future: spot.images,
              builder: (context, snapshoot) => snapshoot.hasData
                  ? MasonryGridView.builder(
                      padding: const EdgeInsets.only(bottom: 100),
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshoot.data.length,
                      gridDelegate:
                          const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2),
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SpotImager(
                            spot: spot,
                            url:
                                APIHandler.baseUrl + snapshoot.data[index].url),
                      ),
                    )
                  : const Center(child: Text("Something Went Wrong")),
            ),
          ),
        )
      ]),
    );
  }

  Widget sliverAdapter({Widget? widget}) {
    return SliverToBoxAdapter(child: widget);
  }
}
