import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madd/components/navbar.dart';
import 'package:madd/components/sidebar.dart';
import 'package:madd/controllers/navigation_controller.dart';
import 'package:madd/view/calender.dart';
import 'package:madd/view/currency.dart';
import 'package:madd/view/map.dart';

class HomeMain extends StatelessWidget {
  HomeMain({super.key});
  final pages = <Widget>[
    const Calander(),
    const Home(),
    const MapHome(),
    const CurrencyHome()
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavigationController>(builder: (controller) {
      return Scaffold(
        body: pages[controller.selected],
        drawer: SideBar(),
        bottomNavigationBar: NavBar(),
      );
    });
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
        physics: const BouncingScrollPhysics(
            decelerationRate: ScrollDecelerationRate.normal),
        slivers: [
          const SliverAppBar(),
          sliverAdapter(
            widget: SizedBox(
              height: 400,
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: 10,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => getItem(0),
              ),
            ),
          ),
          SliverStickyHeader.builder(
              builder: ((context, state) {
                return Padding(
                  padding: const EdgeInsets.only(top: 16, left: 10),
                  child: ListTile(
                    title: Text(
                      "Nearby Visitables",
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
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
              )
                  // sliver: SliverGrid.builder(
                  //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  //       childAspectRatio: 0.6, crossAxisCount: 2),
                  //   itemBuilder: (context, index) {
                  //     return getItem();
                  //   },

                  //   // delegate: SliverChildBuilderDelegate(
                  //   //     childCount: 10, (context, index) => getItem())),
                  // ),
                  // sliverAdapter(
                  //   widget: StickyHeader(
                  //     header: Padding(
                  //       padding: const EdgeInsets.all(10),
                  //       child: Text(
                  //         "Top Tourist Attraction For You",
                  //         style: GoogleFonts.poppins(
                  //           fontSize: 18,
                  //           fontWeight: FontWeight.bold,
                  //         ),
                  //       ),
                  //     ),
                  //     content: SizedBox(
                  //       height: 300,
                  //       child: ListView.builder(
                  //         scrollDirection: Axis.horizontal,
                  //         shrinkWrap: true,
                  //         itemCount: 100,
                  //         itemBuilder: (context, index) => getItem(),
                  //       ),
                  //     ),
                  //   ),
                  // )
                  ))
        ]);
  }

  Widget getImageLay(int index) {
    return Stack(alignment: Alignment.center, children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image(image: AssetImage("assets/images/img${index + 1}.jpeg")),
      ),
      const AnimatedOpacity(
        opacity: 0.5,
        duration: Duration(milliseconds: 300),
        child: Text(
          "Something",
          textAlign: TextAlign.center,
        ),
      )
    ]);
  }

  Widget getItem(int index) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.blue,
            // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15)),
            child: Image(
                width: 200,
                height: 150,
                fit: BoxFit.fitWidth,
                image: AssetImage("assets/images/img${index + 1}.jpeg")),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 20.0),
          child: Row(
            children: [
              Icon(FontAwesomeIcons.mapMarkerAlt),
              Text("Hello"),
              Text("Hello"),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 20.0, top: 10),
          child: Row(
            children: [
              SizedBox(),
              Text("Hello"),
            ],
          ),
        ),
      ],
    );
  }

  Widget sliverAdapter({Widget? widget}) {
    return SliverToBoxAdapter(child: widget);
  }
}
