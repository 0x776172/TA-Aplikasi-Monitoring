import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:monitoring_output/data/get_data.dart';
import 'package:monitoring_output/screen/card_data.dart';
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
    _getData2();
    // _getData3();
  }

  void _getData1() {
    _db.child('panel1').onValue.listen((event) {
      data1.clear();
      setState(() {
        for (var snapshot in event.snapshot.children) {
          var values = Map<dynamic, dynamic>.from(
              jsonDecode(jsonEncode(snapshot.value)));
          var rawDate =
              DateTime.fromMillisecondsSinceEpoch(values['Timestamp'] ?? 0);
          var date = DateFormat("dd/MM/yyyy HH:mm").format(rawDate);
          var result = GetData(
            id: snapshot.key ?? "",
            timestamp: date,
            lightIntensity: values['lightIntensity'] ?? 0,
            voltage: values['panel1'] ?? 0,
          );
          data1.add(result);
        }
        print(data1);
      });
    });
  }

  void _getData2() {
    _db.child('panel2').onValue.listen((event) {
      setState(() {
        for (var snapshot in event.snapshot.children) {
          var values = Map<dynamic, dynamic>.from(
              jsonDecode(jsonEncode(snapshot.value)));
          var rawDate =
              DateTime.fromMillisecondsSinceEpoch(values['Timestamp'] ?? 0);
          var date = DateFormat("dd/MM/yyyy HH:mm").format(rawDate);
          var result = GetData(
            id: snapshot.key ?? "",
            timestamp: date,
            lightIntensity: values['lightIntensity'] ?? 0,
            voltage: values['voltage'] ?? 0,
          );
          data2.add(result);
        }
      });
    });
  }

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
          title: const Text(
            'Daya Terkini',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        drawer: Drawer(
            child: ListView(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Colors.blue),
              child: Column(
                children: [
                  Expanded(child: Image.asset("lib/asset/Logo_PENS_putih.png")),
                  // const Text(
                  //   'Menu',
                  //   style: TextStyle(
                  //       fontSize: 20,
                  //       color: Colors.white,
                  //       fontWeight: FontWeight.bold),
                  // ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(15),
              child: Text(
                "History",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 75, 75, 75)),
              ),
            ),
            ListTile(
              leading: Image.asset(
                "lib/asset/solar-panel.png",
                height: 30,
                width: 30,
              ),
              title: const Text(
                "Panel 1",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HistoryScreen(
                        data: data1,
                        title: "DATA PANEL 1",
                      ),
                    ));
              },
            ),
            ListTile(
              leading: Image.asset(
                "lib/asset/solar-panel.png",
                height: 30,
                width: 30,
              ),
              title: const Text(
                "Panel 2",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HistoryScreen(
                        data: data2,
                        title: "DATA PANEL 2",
                      ),
                    ));
              },
            ),
            ListTile(
              leading: Image.asset(
                "lib/asset/solar-panel.png",
                height: 30,
                width: 30,
              ),
              title: const Text(
                "Panel 3",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HistoryScreen(
                        data: data3,
                        title: "DATA PANEL 3",
                      ),
                    ));
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(
                Icons.info_outline,
              ),
              title: const Text(
                "Tentang Kami",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                          title: const Text(
                            "Tentang Kami",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          content: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Text("Asset yang digunakan:"),
                              Text(
                                  "https://www.flaticon.com/free-icon/solar-panel_869745?term=solar%20panel&related_id=869745")
                            ],
                          ),
                        ));
              },
            )
          ],
        )),
        body: ListView(
          children: [
            Card(
              elevation: 2,
              child: Row(children: []),
            ),
            MyCard(
              title: "Tegangan Panel 1",
              dataVoltage:
                  data1.isNotEmpty ? data1[data1.length - 1].voltage : 0,
            ),
            MyCard(
              title: "Tegangan Panel 2",
              dataVoltage:
                  data2.isNotEmpty ? data2[data2.length - 1].voltage : 0,
            ),
            MyCard(
              title: "Tegangan Panel 3",
              dataVoltage:
                  data3.isNotEmpty ? data3[data3.length - 1].voltage : 0,
            ),
          ],
        ),
      ),
    );
  }
}
