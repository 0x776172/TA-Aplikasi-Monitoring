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
  List<GetData> data = <GetData>[];
  List<GetData> data2 = <GetData>[];
  List<GetData> data3 = <GetData>[];

  final DatabaseReference _db = FirebaseDatabase.instance.ref();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getData();
    // _getData2();
    // _getData3();
  }

  void _getData() {
    _db.child('data').onValue.listen((event) {
      data.clear();
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
            lightIntensity: double.parse(values['lightIntensity'] == null
                ? '0'
                : values['lightIntensity'].toString()),
            panel1: double.parse(
                values['panel1'] == null ? '0' : values['panel1'].toString()),
            panel2: double.parse(
                values['panel2'] == null ? '0' : values['panel2'].toString()),
            panel3: double.parse(
                values['panel3'] == null ? '0' : values['panel3'].toString()),
          );
          data.add(result);
        }
      });
    });
  }

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
                        data: data,
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
                        data: data,
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
                        data: data,
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
            MyCard(
              title: "Tegangan Panel 1",
              dataVoltage: data.isNotEmpty ? data[data.length - 1].panel1 : 0,
            ),
            MyCard(
              title: "Tegangan Panel 2",
              dataVoltage: data.isNotEmpty ? data[data.length - 1].panel2 : 0,
            ),
            MyCard(
              title: "Tegangan Panel 3",
              dataVoltage: data.isNotEmpty ? data[data.length - 1].panel3 : 0,
            ),
          ],
        ),
      ),
    );
  }
}
