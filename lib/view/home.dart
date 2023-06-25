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
import 'package:madd/view/detail_tour.dart';
import 'package:madd/view/map.dart';

class HomeMain extends StatelessWidget {
  HomeMain({super.key});
  // final pageitem = const [
  //   BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.home), label: "Hello"),
  //   BottomNavigationBarItem(
  //       icon: Icon(FontAwesomeIcons.ccAmazonPay), label: "Cool"),
  //   BottomNavigationBarItem(
  //       icon: Icon(FontAwesomeIcons.ccAmazonPay), label: "loop"),
  //   BottomNavigationBarItem(
  //       icon: Icon(FontAwesomeIcons.ccAmazonPay), label: "pool"),
  // const Home(),
  // Calander(),
  // const MapHome(),
  // const CurrencyHome()
  // ];
  final pages = <Widget>[
    const Home(),
    Calander(),
    MapHome(),
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
          SliverStickyHeader.builder(
            builder: (context, state) => Card(
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.only(top: 16, left: 10),
                child: Text(
                  "Top Attraction For You",
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            sliver: sliverAdapter(
              widget: SizedBox(
                height: 300,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: 10,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => getItem(0),
                ),
              ),
            ),
          ),
          SliverStickyHeader.builder(
            builder: ((context, state) {
              return Card(
                elevation: 0,
                child: Padding(
                  padding: const EdgeInsets.only(top: 16, left: 10),
                  child: Text(
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
              ),
            ),
          )
        ]);
  }

  Widget getImageLay(int index) {
    return GestureDetector(
      onTap: () => {
        Get.to(
          DetailHome(
            index: index,
          ),
        ),
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
            "Something",
            textAlign: TextAlign.center,
          ),
        )
      ]),
    );
  }

  Widget getItem(int index) {
    var col = const Color(0xff6750A4);
    return Container(
      margin: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              // color: Colors.blue,
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
          Container(
            width: 200,
            height: 100,
            padding: const EdgeInsets.only(left: 10, bottom: 10, top: 4),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15)),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Icon(
                        FontAwesomeIcons.mapMarkerAlt,
                        color: col,
                      ),
                    ),
                    Expanded(
                        flex: 4,
                        child: Text(
                          "Gondar",
                          style: TextStyle(color: col, fontSize: 16),
                        )),
                    const Expanded(flex: 4, child: Text("Fasiladas")),
                  ],
                ),
                const Expanded(
                  child: SizedBox(),
                ),
                const Row(
                  children: [
                    Expanded(flex: 5, child: SizedBox()),
                    Expanded(
                        flex: 2,
                        child: Text(
                          "4.5",
                          style: TextStyle(
                            color: Color(0xff25005c),
                          ),
                        )),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget sliverAdapter({Widget? widget}) {
    return SliverToBoxAdapter(child: widget);
  }
}
