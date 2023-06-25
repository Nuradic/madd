import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madd/view/map.dart';

class DetailHome extends StatelessWidget {
  final int index;
  DetailHome({super.key, required this.index});
  final _editController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _editController.text =
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris egestas, est vel sollicitudin iaculis, felis nulla convallis ligula, eu mattis quam tellus et magna. Praesent imperdiet ullamcorper augue, a posuere tellus pellentesque non. Vestibulum feugiat consectetur finibus. Sed eget ex eu justo sollicitudin feugiat ut a ligula. Vivamus dui purus, fringilla in sollicitudin nec, tempor ac nisl. Praesent mattis hendrerit ligula, eu tempor nibh faucibus id. Quisque in fermentum odio.";
    return Scaffold(
      body: CustomScrollView(slivers: [
        SliverAppBar(
          expandedHeight: 400,
          stretch: true,
          title: Text("Detail $index"),
          flexibleSpace: FlexibleSpaceBar(background: MapHome()
              //  Image(
              //   image: AssetImage("assets/images/img1.jpeg"),
              //   fit: BoxFit.cover,
              // ),
              ),
        ),
        // sliverAdapter(
        //   widget: Container(
        //     margin: const EdgeInsets.all(10),
        //     height: 200,
        //     decoration: BoxDecoration(
        //       color: Colors.red,
        //       borderRadius: BorderRadius.circular(20),
        //     ),
        //   ),
        // ),
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
