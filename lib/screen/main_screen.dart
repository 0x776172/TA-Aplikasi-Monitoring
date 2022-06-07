import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:monitoring_output/data/get_data.dart';
import 'history_screen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<GetData> data1 = <GetData>[];
  List<GetData> data2 = <GetData>[];
  List<GetData> data3 = <GetData>[];

  final DatabaseReference _db = FirebaseDatabase.instance.ref();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getData1();
    // _getData2();
    // _getData3();
  }

  void _getData1() {
    _db.child('panel1').onValue.listen((event) {
      data1.clear();
      setState(() {
        for (var snapshot in event.snapshot.children) {
          var values =
              Map<String, dynamic>.from(jsonDecode(jsonEncode(snapshot.value)));
          var result = GetData(
            id: snapshot.key ?? "",
            timestamp:
                DateTime.fromMillisecondsSinceEpoch(values['Timestamp'] ?? 0),
            lightIntensity: values['lightIntensity'] ?? 0,
            voltage: values['voltage'] ?? 0,
          );
          data1.add(result);
        }
        print(data1);
      });
    });
  }

  // void _getData2() {
  //   _db.child('panel2').onValue.listen((event) {
  //     setState(() {
  //       for (var snapshot in event.snapshot.children) {
  //         var values =
  //             Map<String, dynamic>.from(jsonDecode(jsonEncode(snapshot.value)));
  //         var result = GetData(
  //           id: snapshot.key!,
  //           timestamp: DateTime.fromMillisecondsSinceEpoch(values['Timestamp']),
  //           lightIntensity: values['lightIntensity'],
  //           voltage: values['voltage'],
  //         );
  //         data2.add(result);
  //       }
  //     });
  //   });
  // }

  // void _getData3() {
  //   _db.child('panel3').onValue.listen((event) {
  //     setState(() {
  //       for (var snapshot in event.snapshot.children) {
  //         var values =
  //             Map<String, dynamic>.from(jsonDecode(jsonEncode(snapshot.value)));
  //         var result = GetData(
  //           id: snapshot.key!,
  //           timestamp: DateTime.fromMillisecondsSinceEpoch(values['Timestamp']),
  //           lightIntensity: values['lightIntensity'],
  //           voltage: values['voltage'],
  //         );
  //         data3.add(result);
  //       }
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text('Daya Terkini'),
        ),
        drawer: Drawer(
            child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(),
              child: Text('List Data Output'),
            ),
            ListTile(
              title: const Text("Panel 1"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HistoryScreen(
                        data: data1,
                        title: "Data Panel 1",
                      ),
                    ));
              },
            ),
            ListTile(
              title: const Text("Panel 2"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HistoryScreen(
                        data: data2,
                        title: "Data Panel 2",
                      ),
                    ));
              },
            ),
            ListTile(
              title: const Text("Panel 3"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HistoryScreen(
                        data: data3,
                        title: "Data Panel 3",
                      ),
                    ));
              },
            ),
          ],
        )),
        body: Column(),
      ),
    );
  }
}
