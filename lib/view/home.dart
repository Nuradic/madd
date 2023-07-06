import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madd/api/api_handler.dart';
import 'package:madd/components/navbar.dart';
import 'package:madd/components/sidebar.dart';
import 'package:madd/controllers/home_controller.dart';
import 'package:madd/controllers/navigation_controller.dart';
import 'package:madd/models/models.dart';
import 'package:madd/view/calender.dart';
import 'package:madd/view/currency2.dart';
import 'package:madd/view/detail_tour.dart';
import 'package:madd/view/login.dart';
import 'package:madd/view/map.dart';

import 'conver.dart';

class HomeMain extends StatelessWidget {
  HomeMain({super.key});

  final pages = <Widget>[
    Home(),
    Calander(),
    const CurrencyScreen(),
    const CalendarConverterScreen()
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
  Home({super.key});
  final c = Get.find<HomeController>();
  Widget _buildFilterItem(SpotType spotType) => GestureDetector(
        onTap: () {
          // Get.toNamed("/login");
        },
        child: Container(
          width: 160,
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(60),
            boxShadow: [
              BoxShadow(
                offset: const Offset(4, 8),
                blurRadius: 25,
                spreadRadius: 5,
                color: Colors.grey.shade300,
              ),
            ],
            color: Colors.white,
          ),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Expanded(flex: 2, child: CircleAvatar()),
            Expanded(
              flex: 3,
              child: Text(
                spotType.name,
                style: const TextStyle(
                  fontSize: 12,
                ),
              ),
            ),
            const FaIcon(Icons.cancel)
          ]),
        ),
      );
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
        physics: const BouncingScrollPhysics(
            decelerationRate: ScrollDecelerationRate.normal),
        slivers: [
          SliverAppBar(
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: OutlinedButton(
                    onPressed: () {
                      showSearch(
                          context: context, delegate: CustomSearchDelegate());
                    },
                    child: const Icon(Icons.search)),
              )
            ],
          ),
          // SliverStickyHeader.builder(
          //   builder: (context, state) => Card(
          //     elevation: 0,
          //     child: Padding(
          //       padding: const EdgeInsets.only(top: 16, left: 10),
          //       child: Text(
          //         "Filter ",
          //         style: GoogleFonts.poppins(
          //           fontSize: 18,
          //           fontWeight: FontWeight.bold,
          //         ),
          //       ),
          //     ),
          //   ),
          //   sliver: sliverAdapter(
          //     widget: SizedBox(
          //       height: 70,
          //       child: FutureBuilder(
          //         future: Spot.types,
          //         builder: (context, snapshoot) => snapshoot.hasData
          //             ? ListView.builder(
          //                 physics: const BouncingScrollPhysics(),
          //                 itemCount: snapshoot.data.length,
          //                 scrollDirection: Axis.horizontal,
          //                 itemBuilder: (context, index) =>
          //                     _buildFilterItem(snapshoot.data[index]),
          //               )
          //             : const CircularProgressIndicator(),
          //       ),
          //     ),
          //   ),
          // ),
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
                child: GetBuilder<HomeController>(builder: (controller) {
                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: controller.topSpot.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) =>
                        TopAttractionItem(spot: controller.topSpot[index]),
                  );
                }),
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
                    "Visitables",
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            }),
            sliver: sliverAdapter(
              widget: GetBuilder<HomeController>(builder: (controller) {
                return MasonryGridView.builder(
                  padding: const EdgeInsets.all(5),
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: controller.topSpot.length,
                  gridDelegate:
                      const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FutureBuilder(
                      future: controller.topSpot[index].images,
                      builder: (context, snapshoot) => snapshoot.hasData &&
                              snapshoot.data.length != 0
                          ? SpotImager(
                              spot: controller.topSpot[index],
                              url:
                                  "${APIHandler.baseUrl}${snapshoot.data[0].url}")
                          : SpotImager(
                              spot: controller.topSpot[index],
                              url:
                                  "${APIHandler.baseUrl}medias/0f8e5805de94514e25792ae4b26195db1688150039.jpg"),
                    ),
                  ),
                );
              }),
            ),
          )
        ]);
  }

  Widget getImageLay(int index) {
    return GestureDetector(
      onTap: () => {print("error")},
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FaIcon(
                FontAwesomeIcons.cocktail,
              ),
            ],
          ),
        )
      ]),
    );
  }

  Widget getItem(Spot spot) {
    var col = const Color(0xff6750A4);
    return GestureDetector(
      onTap: () {
        // Get.toNamed("/login");
        // print("pressed");
      },
      child: Container(
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
              child: const ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)),
                child: Image(
                    width: 200,
                    height: 150,
                    fit: BoxFit.fitWidth,
                    image: AssetImage("assets/images/default.jpg")),
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
                            spot.cityName,
                            style: TextStyle(color: col, fontSize: 16),
                          )),
                      Expanded(
                        flex: 4,
                        child: Text(spot.name),
                      ),
                    ],
                  ),
                  const Expanded(
                    child: SizedBox(),
                  ),
                  Row(
                    children: [
                      const Expanded(flex: 5, child: SizedBox()),
                      Expanded(
                          flex: 2,
                          child: FutureBuilder(
                              initialData: "..",
                              future: spot.rate,
                              builder:
                                  (context, AsyncSnapshot<String> snapshot) {
                                return Text(
                                  "${snapshot.data}",
                                  style: const TextStyle(
                                    color: Color(0xff25005c),
                                  ),
                                );
                              })),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget sliverAdapter({Widget? widget}) {
    return SliverToBoxAdapter(child: widget);
  }
}

class TopAttractionItem extends StatefulWidget {
  final Spot spot;
  int width = 100;
  int height = 100;
  final col = const Color(0xff6750A4);

  TopAttractionItem({super.key, required this.spot});

  @override
  State<TopAttractionItem> createState() => _TopAttractionItemState();
}

class _TopAttractionItemState extends State<TopAttractionItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Get.to(LoginPage());
        Get.to(DetailHome(spot: widget.spot));
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        margin: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15)),
              child: Image(
                  width: 200,
                  height: 150,
                  fit: BoxFit.fitWidth,
                  image: AssetImage("assets/images/default.jpg")),
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
                          color: widget.col,
                        ),
                      ),
                      Expanded(
                          flex: 4,
                          child: Text(
                            widget.spot.cityName,
                            style: TextStyle(color: widget.col, fontSize: 16),
                          )),
                      Expanded(
                        flex: 4,
                        child: Text(widget.spot.name.split(" ")[0]),
                      ),
                    ],
                  ),
                  const Expanded(
                    child: SizedBox(),
                  ),
                  Row(
                    children: [
                      const Expanded(flex: 5, child: SizedBox()),
                      Expanded(
                          flex: 2,
                          child: FutureBuilder(
                              initialData: "..",
                              future: widget.spot.rate,
                              builder:
                                  (context, AsyncSnapshot<String> snapshot) {
                                return Text(
                                  "${snapshot.data}",
                                  style: const TextStyle(
                                    color: Color(0xff25005c),
                                  ),
                                );
                              })),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SpotImager extends StatefulWidget {
  final Spot? spot;
  final String url;
  const SpotImager({super.key, this.spot, required this.url});

  @override
  State<SpotImager> createState() => _SpotImagerState();
}

class _SpotImagerState extends State<SpotImager> {
  double opacity = 0.5;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (down) => {
        setState(
          () {
            opacity = 1;
          },
        )
      },
      onTapUp: (up) => {
        if (widget.spot != null)
          {
            Get.to(() => DetailHome(spot: widget.spot!)),
          },
        setState(
          () {
            opacity = 0;
          },
        )
      },
      child: Stack(alignment: Alignment.center, children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image(
            image: NetworkImage(widget.url),
          ),
        ),
        AnimatedOpacity(
          opacity: opacity,
          duration: const Duration(milliseconds: 300),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FaIcon(
                FontAwesomeIcons.cocktail,
              ),
            ],
          ),
        )
      ]),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = "";
        },
        icon: const Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(
      future: Spot.query(query),
      builder: (context, snapshot) => snapshot.hasData
          ? ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) => ListTile(
                onTap: () {
                  Get.off(DetailHome(
                    spot: snapshot.data[index],
                  ));
                },
                leading: const CircleAvatar(),
                title: Text(snapshot.data[index].name),
              ),
            )
          : snapshot.hasError
              ? const Center(child: Text("Something Went Wrong"))
              : const Center(child: CircularProgressIndicator()),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      future: Spot.query(query),
      builder: (context, snapshot) => snapshot.hasData
          ? ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) => ListTile(
                onTap: () {
                  Get.off(DetailHome(
                    spot: snapshot.data[index],
                  ));
                },
                leading: const CircleAvatar(),
                title: Text(snapshot.data[index].name),
              ),
            )
          : snapshot.hasError
              ? const Center(child: Text("Something Went Wrong"))
              : const Center(child: CircularProgressIndicator()),
    );
  }
}
