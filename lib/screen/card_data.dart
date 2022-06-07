import 'package:flutter/material.dart';

class MyCard extends StatefulWidget {
  final double? dataVoltage;
  final String title;
  const MyCard({Key? key, required this.title, required this.dataVoltage})
      : super(key: key);

  @override
  State<MyCard> createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: SizedBox(
        height: 150,
        // MediaQuery.of(context).size.height / 3.75,
        child: Row(
          children: [
            Image.asset(
              "lib/asset/solar-panel.png",
              height: 120,
              width: 120,
            ),
            Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      widget.title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                      child: Center(
                    child: SizedBox(
                      child: Text(
                        "${widget.dataVoltage} V",
                        style: const TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
