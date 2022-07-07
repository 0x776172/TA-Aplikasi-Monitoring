import 'package:flutter/material.dart';
import 'package:monitoring_output/data/get_data.dart';

class HistoryScreen extends StatefulWidget {
  final List<GetData> data;
  final String title;
  const HistoryScreen({Key? key, required this.data, required this.title})
      : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  // this function return data as per panel that chosen by the list tile
  Widget getText(String title, int index) {
    switch (title) {
      case "DATA PANEL 1":
        {
          return Text("Tegangan: ${widget.data[index].panel1} V");
        }
      case "DATA PANEL 2":
        {
          return Text("Tegangan: ${widget.data[index].panel2} V");
        }
      case "DATA PANEL 3":
        {
          return Text("Tegangan: ${widget.data[index].panel3} V");
        }
      default:
        {
          return const Text("Data Kosong");
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          title: Text(widget.title),
        ),
        body: ListView.separated(
          itemCount: widget.data.length,
          separatorBuilder: (context, index) => const Divider(
              // height: 5,
              ),
          itemBuilder: (context, index) {
            return Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Container(
                padding: const EdgeInsets.only(
                    top: 8.0, bottom: 8.0, left: 10.0, right: 10.0),
                margin: EdgeInsets.zero,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.data[index].timestamp,
                      style: const TextStyle(
                        fontSize: 15,
                        wordSpacing: 5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // Text(""),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                            "Intensitas Cahaya: ${widget.data[index].lightIntensity} lx"),
                        getText(widget.title, index),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
