import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class Bluetooth extends StatefulWidget {
  static const String id = '/bluetooth';
  Bluetooth({Key? key}) : super(key: key);

  @override
  State<Bluetooth> createState() => _BluetoothState();
}

class _BluetoothState extends State<Bluetooth> {
  FlutterBluePlus flutterBlue = FlutterBluePlus.instance;

  void scanForDevices() {
    // Start scanning
    flutterBlue.startScan(timeout: Duration(milliseconds: 200));

// Listen to scan results
    var subscription = flutterBlue.scanResults.listen((results) {
      // do something with scan results
      for (ScanResult r in results) {
        if (r.device.name != '')
        print('${r.device.name} found! rssi: ${r.rssi}');
        // print('|${r.device.name}|');
      }
    });

// Stop scanning
    flutterBlue.stopScan();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            scanForDevices();
          },
          child: Text('Scan'),
        ),
      ),
    );
  }
}
