import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:madd/controllers/navigation_controller.dart';

class NavBar extends StatelessWidget {
  NavBar({super.key});
  final navController = Get.find<NavigationController>();
  final List<IconData> listoficons = [
    Icons.home,
    FontAwesomeIcons.calendarAlt,
    FontAwesomeIcons.mapMarkerAlt,
    FontAwesomeIcons.dollarSign
  ];
  final selectedColor = const Color(0xff6750A4);
  final pages = const ["/home", "/calender", "/currency", "/map"];
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GetBuilder<NavigationController>(builder: (context) {
      return Container(
        margin: const EdgeInsets.all(20),
        height: size.width * .155,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.15),
              blurRadius: 30,
              offset: const Offset(0, 10),
            ),
          ],
          borderRadius: BorderRadius.circular(50),
        ),
        child: ListView.builder(
          itemCount: 4,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: size.width * .024),
          itemBuilder: (context, index) => InkWell(
            onTap: () {
              navController.setSelected(index);
              // Get.toNamed(pages[index]);
            },
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 1500),
                  curve: Curves.fastLinearToSlowEaseIn,
                  margin: EdgeInsets.only(
                    bottom:
                        index == navController.selected ? 0 : size.width * .029,
                    right: size.width * .0422,
                    left: size.width * .0422,
                  ),
                  width: size.width * .128,
                  height:
                      index == navController.selected ? size.width * .014 : 0,
                  decoration: BoxDecoration(
                    color: selectedColor,
                    borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(10),
                    ),
                  ),
                ),
                Icon(
                  listoficons[index],
                  size: size.width * .076,
                  color: index == navController.selected
                      ? selectedColor
                      : Colors.black38,
                ),
                SizedBox(height: size.width * .03),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget getNavItem({required IconData icon, int? index}) {
    return GestureDetector(
      onTap: () {
        navController.setSelected(index!);
        switch (index) {
          case 1:
            Get.toNamed("/home");
        }
      },
      child: GetBuilder<NavigationController>(builder: (context) {
        return AnimatedContainer(
          curve: Curves.fastLinearToSlowEaseIn,
          duration: const Duration(milliseconds: 1500),
          child: Container(
            height: 48,
            width: 76,
            decoration: BoxDecoration(
              color: navController.selected == index
                  ? const Color(0xFFE8DEF8)
                  : null,
              borderRadius: BorderRadius.circular(32),
            ),
            child: Center(
              child: FaIcon(
                icon,
                color: MaterialStateColor.resolveWith(
                  (states) => navController.selected == index
                      ? const Color(0xFF6750A4).withAlpha(170)
                      : Colors.black.withAlpha(200),
                ),
                size: 36,
              ),
            ),
          ),
        );
      }),
    );
  }
}
