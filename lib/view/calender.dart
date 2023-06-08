import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madd/components/navbar.dart';
import 'package:madd/components/sidebar.dart';
import 'package:sticky_headers/sticky_headers.dart';

class Calander extends StatelessWidget {
  const Calander({super.key});

  static const weekDays = ["S", "M", "T", "W", "T", "F", "S"];

  Widget buildWeekDay() {
    return GridView.builder(
      padding: const EdgeInsets.only(left: 10, right: 10),
      shrinkWrap: true,
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 7),
      itemCount: 7,
      itemBuilder: (context, index) => Card(
        clipBehavior: Clip.hardEdge,
        elevation: 0,
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

  Widget monthCalender() {
    return GridView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 7),
      itemCount: 35,
      itemBuilder: (context, index) => Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
        margin: EdgeInsets.zero,
        child: Center(
          child: Column(
            children: [
              Text(
                "${index + 1}".padLeft(2, "0"),
                style: GoogleFonts.poppins(
                    fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                "${index + 1}".padLeft(2, "0"),
                style: GoogleFonts.poppins(
                    fontSize: 12, color: Theme.of(context).primaryColor),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideBar(),
      bottomNavigationBar: NavBar(),
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, n) => <Widget>[
          SliverAppBar(
            pinned: true,
            bottom: PreferredSize(
              preferredSize: const Size(200, 90),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          "Apr 2023",
                          style: GoogleFonts.roboto(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Text(
                          "Mar 2023",
                          style: GoogleFonts.roboto(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  buildWeekDay(),
                ],
              ),
            ),
          )
        ],
        body: SingleChildScrollView(
          child: ListView(
            shrinkWrap: true,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              monthCalender(),
              StickyHeader(
                header: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    "This Month's Event",
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                content: ListView.builder(
                    scrollDirection: Axis.vertical,
                    padding: const EdgeInsets.all(20),
                    shrinkWrap: true,
                    itemCount: 30,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {},
                        leading: Column(
                          children: [
                            Text(
                              "${index + 1}".padLeft(2, "0"),
                              style: GoogleFonts.poppins(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "${index + 1}".padLeft(2, "0"),
                              style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: Theme.of(context).primaryColor),
                            ),
                          ],
                        ),
                        title: const Text("data"),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
