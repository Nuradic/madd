import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madd/models/models.dart';

class DetailHome extends StatelessWidget {
  final Spot spot;
  DetailHome({super.key, required this.spot});
  final _editController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _editController.text = spot.description;

    return Scaffold(
      body: CustomScrollView(slivers: [
        SliverAppBar(
          expandedHeight: 400,
          stretch: true,
          title: Text(spot.name),
          flexibleSpace: const FlexibleSpaceBar(
            background: Image(
              image: AssetImage("assets/images/img1.jpeg"),
              fit: BoxFit.cover,
            ),
          ),
        ),
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
          )),
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
            widget: MasonryGridView.builder(
              padding: const EdgeInsets.all(5),
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: 12,
              gridDelegate:
                  const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: getImageLay(index),
              ),
            ),
          ),
        )
      ]),
    );
  }

  Widget getImageLay(int index) {
    return GestureDetector(
      onTap: () => {
        // Get.to(
        //   DetailHome(
        //     index: index,
        //   ),
        // ),
      },
      child: Stack(alignment: Alignment.center, children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image(
            image: AssetImage("assets/images/img${index + 1}.jpeg"),
          ),
        ),
        const AnimatedOpacity(
          opacity: 0.5,
          duration: Duration(milliseconds: 300),
          child: Text(
            "",
            textAlign: TextAlign.center,
          ),
        )
      ]),
    );
  }

  Widget sliverAdapter({Widget? widget}) {
    return SliverToBoxAdapter(child: widget);
  }
}
