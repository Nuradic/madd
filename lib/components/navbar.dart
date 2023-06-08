import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:madd/controllers/navigation_controller.dart';

class NavBar extends StatelessWidget {
  NavBar({super.key});
  final navController = Get.find<NavigationController>();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(20),
      color: const Color(0xFFFFFFFF),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            getNavItem(icon: Icons.home, index: 0),
            getNavItem(icon: FontAwesomeIcons.calendarAlt, index: 1),
            getNavItem(icon: FontAwesomeIcons.mapMarkerAlt, index: 2),
            getNavItem(icon: FontAwesomeIcons.dollarSign, index: 3),
          ],
        ),
      ),
    );
  }

  Widget getNavItem({required IconData icon, int? index}) {
    return GestureDetector(
      onTap: () {
        navController.setSelected(index!);
        switch (index) {
          case 1:
            Get.toNamed("/calender");
        }
      },
      child: GetBuilder<NavigationController>(builder: (context) {
        return InkWell(
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
