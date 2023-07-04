import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madd/controllers/currency_controller.dart';
import 'package:madd/models/models.dart';

class CurrencyHome extends StatelessWidget {
  const CurrencyHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: body,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.bottomSheet(
            const CurrencySheet(),
          );
          // Get.showSnackbar(
          //   const GetSnackBar(
          //     title: "Text",
          //     message: "Some Message",
          //   ),
          // );
        },
        child: const Icon(Icons.currency_exchange),
      ),
    );
  }
}

var textController;

get body {
  return GetBuilder<CurrencyController>(builder: (controller) {
    return Column(
      children: [
        Column(
          children: [
            Text(
              "38282 USD",
              style:
                  GoogleFonts.roboto(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              "38282 ETB",
              style: GoogleFonts.roboto(fontSize: 14),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton(
              style: const TextStyle(fontSize: 24, color: Colors.black),
              value: controller.selectedCurrency,
              items: const [
                DropdownMenuItem(
                  value: 1,
                  child: Text("USD"),
                ),
                DropdownMenuItem(
                  value: 2,
                  child: Text("YEN"),
                ),
                DropdownMenuItem(
                  value: 3,
                  child: Text("Rupple"),
                ),
                DropdownMenuItem(
                  value: 4,
                  child: Text("Lirrey"),
                ),
              ],
              onChanged: (value) {
                controller.setSelected(value!);
              },
            ),
            SizedBox(
              width: 150,
              height: 40,
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                controller: textController,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton(
              style: const TextStyle(fontSize: 24, color: Colors.black),
              value: controller.selectedCurrency,
              items: const [
                DropdownMenuItem(
                  value: 1,
                  child: Text("USD"),
                ),
                DropdownMenuItem(
                  value: 2,
                  child: Text("YEN"),
                ),
                DropdownMenuItem(
                  value: 3,
                  child: Text("Rupple"),
                ),
                DropdownMenuItem(
                  value: 4,
                  child: Text("Lirrey"),
                ),
              ],
              onChanged: (value) {
                controller.setSelected(value!);
              },
            ),
            SizedBox(
              width: 150,
              height: 40,
              child: TextField(
                enabled: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                controller: textController,
              ),
            ),
          ],
        )
      ],
    );
  });
}

class CommentSheet extends StatefulWidget {
  final Spot spot;
  const CommentSheet({super.key, required this.spot});

  @override
  State<CommentSheet> createState() => _CommentSheetState();
}

class _CommentSheetState extends State<CommentSheet>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;

  @override
  void initState() {
    animationController = BottomSheet.createAnimationController(this);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BottomSheet(
        elevation: 4,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        showDragHandle: true,
        animationController: animationController,
        onClosing: () {},
        builder: (context) => Container(
          padding: const EdgeInsets.all(10),
          child: FutureBuilder(
            initialData: const [],
            future: widget.spot.comment,
            builder: (context, snapshoot) => snapshoot.hasData
                ? ListView.builder(
                    itemCount: snapshoot.data.length,
                    itemBuilder: (context, index) => CommentItem(
                      comment: snapshoot.data[index],
                    ),
                  )
                : snapshoot.hasError
                    ? const Center(child: Text("Something Went Wrong"))
                    : const Center(
                        child: CircularProgressIndicator(),
                      ),
          ),
        ),
      ),
      floatingActionButton:
          FloatingActionButton(onPressed: () {}, child: const Icon(Icons.add)),
    );
  }
}

class CurrencySheet extends StatefulWidget {
  const CurrencySheet({super.key});

  @override
  State<CurrencySheet> createState() => _CurrencySheetState();
}

class _CurrencySheetState extends State<CurrencySheet>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;

  @override
  void initState() {
    animationController = BottomSheet.createAnimationController(this);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BottomSheet(
        onClosing: () {},
        showDragHandle: true,
        animationController: animationController,
        builder: (context) => Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Currency Market",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 400,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 122,
                itemBuilder: (context, index) =>
                    const TradeItem(currency: "USD", value: 12),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TradeItem extends StatelessWidget {
  final String currency;
  final double value;
  const TradeItem({super.key, required this.currency, required this.value});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Text(r"$"),
      title: Text(currency, style: const TextStyle(fontSize: 16)),
      trailing: Text("$value", style: const TextStyle(fontSize: 16)),
    );
  }
}

class ConverterWidget extends StatelessWidget {
  const ConverterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetSnackBar(
      titleText: Text("Hello"),
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}

class CommentItem extends StatelessWidget {
  final Comment comment;
  const CommentItem({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(
        maxRadius: 25,
        minRadius: 15,
        backgroundImage: AssetImage("assets/images/img2.jpeg"),
      ),
      title: Text(
        comment.username,
        style: GoogleFonts.roboto(
            fontSize: 12, color: Theme.of(context).primaryColor),
      ),
      subtitle: TextField(
        maxLines: null,
        enabled: false,
        controller: TextEditingController(text: comment.body),
        style: GoogleFonts.roboto(
            fontSize: 16, color: Colors.black, fontWeight: FontWeight.w500),
      ),
    );
  }
}
