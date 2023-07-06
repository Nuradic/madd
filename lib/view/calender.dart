import 'package:abushakir/abushakir.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madd/controllers/calender_controller.dart';

class Calander extends StatelessWidget {
  Calander({super.key});
  final calController = Get.find<CalenderController>();

  static const weekDays = [
    "M",
    "T",
    "W",
    "T",
    "F",
    "S",
    "S",
  ];

  Widget buildWeekDay() {
    return GridView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(left: 10, right: 10),
      shrinkWrap: true,
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 7),
      itemCount: 7,
      itemBuilder: (context, index) => Card(
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            weekDays[index],
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ),
    );
  }

  Widget monthCalender(BuildContext context) {
    return GetBuilder<CalenderController>(builder: (controller) {
      return SizedBox(
        height: 300,
        width: MediaQuery.of(context).size.width,
        child: GridView.builder(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7),
          itemCount: 35,
          itemBuilder: (context, index) => Card(
            color: controller.currentDay == controller.cal[index][0] &&
                    controller.currentMonth == controller.month &&
                    controller.cal[index][1]
                ? Colors.amber
                : !controller.cal[index][1]
                    ? Colors.grey
                    : (index % 7) % 2 == 0
                        ? Colors.blue.shade100
                        : null,
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
            margin: EdgeInsets.zero,
            child: Center(
              child: Column(
                children: [
                  Text(
                    "${controller.cal[index][0]}".padLeft(2, "0"),
                    style: GoogleFonts.poppins(
                        color: controller.cal[index][1]
                            ? Colors.black.withAlpha(80)
                            : Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${2}".padLeft(2, "0"),
                    style: GoogleFonts.poppins(
                        fontSize: 12, color: Theme.of(context).primaryColor),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CalenderController>(builder: (controller) {
      return CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            actions: [
              Container(
                padding: const EdgeInsets.all(10),
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    // controller.listController.animateTo(
                    //   13,
                    //   duration: const Duration(seconds: 1500),
                    //   curve: Curves.easeInOut,
                    // );
                    // controller.getMonthly();
                    // showDatePicker(
                    //     context: context,
                    //     initialDate: DateTime.now(),
                    //     firstDate: DateTime(1950),
                    //     lastDate: DateTime(2089));
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Pick Date"),
                      SizedBox(
                        width: 10,
                      ),
                      FaIcon(Icons.arrow_downward)
                    ],
                  ),
                ),
              ),
            ],
            pinned: true,
            bottom: PreferredSize(
              preferredSize: const Size(200, 50),
              child: Column(
                children: [
                  buildWeekDay(),
                ],
              ),
            ),
          ),
          SliverStickyHeader.builder(
              builder: ((context, state) => Card(
                    elevation: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            " ${controller.month}: ${controller.year}",
                            style: const TextStyle(
                              fontSize: 24,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: IconButton(
                                  icon: const Icon(Icons.arrow_back_ios),
                                  onPressed: () {
                                    controller.getPrev();
                                  },
                                )
                                // Text(
                                //   "Apr 2023",
                                //   style: GoogleFonts.roboto(
                                //       fontSize: 20, fontWeight: FontWeight.w500),
                                // ),
                                ),
                            Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: IconButton(
                                  icon: const Icon(Icons.arrow_forward_ios),
                                  onPressed: () {
                                    controller.getNext();
                                  },
                                )),
                          ],
                        ),
                      ],
                    ),
                  )),
              sliver: sliverAdapter(widget: monthCalender(context))
              // sliverAdapter(
              //   widget: SizedBox(
              //     height: 300,
              //     child: ListView.builder(
              //       physics: const PageScrollPhysics(),
              //       controller: controller.calScrollController,
              //       scrollDirection: Axis.horizontal,
              //       itemBuilder: (context, index) =>
              //           monthCalender(context, index),
              //     ),
              //   ),
              // ),
              ),
          // SliverStickyHeader.builder(
          //   builder: (context, state) => Card(
          //     elevation: 0,
          //     child: ListTile(
          //       title: Text(
          //         "Converter",
          //         style: GoogleFonts.poppins(
          //           fontSize: 24,
          //           fontWeight: FontWeight.w600,
          //         ),
          //       ),
          //     ),
          //   ),
          //   sliver: SliverList(
          //     delegate: SliverChildBuilderDelegate(
          //         childCount: 10,
          //         (context, index) => ListTile(
          //               onTap: () {},
          //               leading: Column(
          //                 children: [
          //                   Text(
          //                     "${index + 1}".padLeft(2, "0"),
          //                     style: GoogleFonts.poppins(
          //                         fontSize: 20, fontWeight: FontWeight.bold),
          //                   ),
          //                   Text(
          //                     "${index + 1}".padLeft(2, "0"),
          //                     style: GoogleFonts.poppins(
          //                         fontSize: 12,
          //                         color: Theme.of(context).primaryColor),
          //                   ),
          //                 ],
          //               ),
          //               title: const Text("data"),
          //             )),
          //   ),
          // ),
        ],
      );
    });
  }

  Widget sliverAdapter({required Widget widget}) {
    return SliverToBoxAdapter(child: widget);
  }
}
