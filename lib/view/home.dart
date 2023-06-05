import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TourBase"),
      ),
      drawer: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width * 0.7,
        child: Column(
          children: [
            Container(
              color: Colors.red,
              height: 150,
            ),
            Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.amber.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: getNavItem(text: "Spot", trailer: "100"),
            ),
            getNavItem(icon: FontAwesomeIcons.calendarAlt, text: "Calender"),
            getNavItem(icon: FontAwesomeIcons.mapMarkerAlt, text: "Maps"),
            getNavItem(icon: FontAwesomeIcons.dollarSign, text: "Currency"),
            Container(
              margin: const EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              child: const Divider(
                thickness: 2,
              ),
            ),
            getNavItem(icon: Icons.settings, text: "Settings"),
            getNavItem(icon: Icons.feedback, text: "Feedback"),
            getNavItem(icon: Icons.help, text: "FAQ"),
          ],
        ),
      ),
    );
  }

  Widget getNavItem({IconData? icon, required String text, String? trailer}) {
    return TextButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
      onPressed: () {},
      child: ListTile(
        leading: icon == null ? null : FaIcon(icon, color: Colors.black),
        title: Text(
          text,
          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        trailing: trailer == null ? null : Text(trailer),
      ),
    );
  }
}
