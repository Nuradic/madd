import 'package:flutter/material.dart';
import 'package:madd/components/navbar.dart';
import 'package:madd/components/sidebar.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tour Ethiopia"),
      ),
      // body: const Center(
      //   child: NavBar(),
      // ),
      bottomNavigationBar: NavBar(),
      drawer: SideBar(),
    );
  }
}
