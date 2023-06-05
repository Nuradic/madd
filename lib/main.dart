import 'package:flutter/material.dart';
import 'package:madd/view/home.dart';

void main() {
  runApp(
    const TourBase(),
  );
}

class TourBase extends StatelessWidget {
  const TourBase({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: Home());
  }
}
