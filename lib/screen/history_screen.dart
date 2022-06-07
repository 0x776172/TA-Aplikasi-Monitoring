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
  bool isShown = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(widget.title),
          actions: [
            PopupMenuButton(itemBuilder: (context) {
              return [
                PopupMenuItem(
                  child: Text(isShown ? "Hide Current" : "Show Current"),
                  onTap: () {
                    setState(() {
                      isShown = !isShown;
                    });
                  },
                ),
              ];
            })
          ],
        ),
        body: ListView.separated(
          itemCount: widget.data.length,
          separatorBuilder: (context, index) => const Divider(),
          itemBuilder: (context, index) {
            return Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Center(
                child: Container(
                  height: 20,
                  width: 20,
                  child: Visibility(
                    visible: isShown,
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
