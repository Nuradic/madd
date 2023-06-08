import 'package:flutter/material.dart' hide DrawerController;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madd/controllers/navigation_controller.dart';

class SideBar extends StatelessWidget {
  SideBar({super.key});

  final drawerController = Get.find<NavigationController>();
  Widget getNavItem(
      {IconData? icon, required String text, String? trailer, int? index}) {
    return GetBuilder<NavigationController>(builder: (context) {
      return Card(
        elevation: 0,
        color: MaterialStateColor.resolveWith(
          (states) {
            return drawerController.selected == index && index != 0
                ? const Color(0xFFE8DEF8)
                : Colors.transparent;
          },
        ),
        margin: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
        child: ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          onTap: () {
            drawerController.setSelected(index!);
            Get.back();
          },
          contentPadding:
              const EdgeInsets.only(top: 8, bottom: 8, left: 20, right: 20),
          selected: drawerController.selected == index,
          leading: icon == null
              ? null
              : FaIcon(
                  icon,
                  color: MaterialStateColor.resolveWith(
                    (states) => drawerController.selected == index
                        ? const Color(0xFF6750A4)
                        : Colors.black,
                  ),
                ),
          title: Text(
            text,
            style:
                GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          trailing: trailer == null ? null : Text(trailer),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        width: MediaQuery.of(context).size.width * 0.7,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: const Color(0xFF9747FF).withAlpha(30),
                height: 150,
              ),
              Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.amber.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: getNavItem(text: "Spot", trailer: "100", index: 0),
              ),
              getNavItem(
                  icon: FontAwesomeIcons.calendarAlt,
                  text: "Calender",
                  index: 1),
              getNavItem(
                  icon: FontAwesomeIcons.mapMarkerAlt, text: "Maps", index: 2),
              getNavItem(
                  icon: FontAwesomeIcons.dollarSign,
                  text: "Currency",
                  index: 3),
              Container(
                margin: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                child: const Divider(
                  thickness: 2,
                ),
              ),
              getNavItem(icon: Icons.settings, text: "Settings", index: 4),
              getNavItem(icon: Icons.feedback, text: "Feedback", index: 5),
              getNavItem(icon: Icons.help, text: "FAQ", index: 6),
            ],
          ),
        ));
  }
}
