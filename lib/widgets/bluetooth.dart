import 'dart:async';
import 'package:flutter_nearby_messages_api/flutter_nearby_messages_api.dart';
import 'package:beacon_broadcast/beacon_broadcast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:permission_handler/permission_handler.dart';

class Bluetooth extends StatefulWidget {
  Bluetooth({Key? key}) : super(key: key);
  static const String id = '/bluetooth';

  @override
  State<Bluetooth> createState() => _BluetoothState();
}

class _BluetoothState extends State<Bluetooth> {
  static const String uuid = '39ED98FF-2900-441A-802F-9C398FC199D2';
  static const int majorId = 1;
  static const int minorId = 100;
  static const int transmissionPower = -59;
  static const String identifier = 'com.example.myDeviceRegion';
  static const AdvertiseMode advertiseMode = AdvertiseMode.lowPower;
  static const String layout = BeaconBroadcast.ALTBEACON_LAYOUT;
  static const int manufacturerId = 0x0118;
  static const List<int> extraData = [100];
  FlutterBluePlus flutterBlue = FlutterBluePlus.instance;
  FlutterNearbyMessagesApi nearbyMessagesApi = FlutterNearbyMessagesApi();
  BeaconBroadcast beaconBroadcast = BeaconBroadcast();

  @override
  void initState() {
    super.initState();
    // emitBeacon();
  }

  void dispose() {
    super.dispose();
    beaconBroadcast.stop();
  }

  // void emitBeacon() {
  //   beaconBroadcast
  //       .setUUID('39ED98FF-2900-441A-802F-9C398FC199D2')
  //       .setMajorId(1)
  //       .setMinorId(100)
  //       .setExtraData([233]).start();
  // }

  Future<void> scanNearby() async {
    await Permission.bluetoothAdvertise.request();
    await Permission.bluetoothConnect.request() ;
    await Permission.bluetoothScan.request() ;
    print(await beaconBroadcast
        .checkTransmissionSupported());
    beaconBroadcast
      .setUUID(uuid)
      .setMajorId(majorId)
      .setMinorId(minorId)
      .setTransmissionPower(transmissionPower)
      .setAdvertiseMode(advertiseMode)
      .setIdentifier(identifier)
      .setLayout(layout)
      .setManufacturerId(manufacturerId)
      .setExtraData(extraData)
      .start();


    var subscription = flutterBlue.scanResults.listen((results) {
      // do something with scan results
      for (ScanResult r in results) {
        print(r.device.name);
        if (r.device.name != '') {
          // print(r);
        }
      }
    });

// Stop scanning
    flutterBlue.stopScan();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Nearby Messages Example'),
      ),
      body: Container(
        color: Colors.white70,
        child: Column(children: [
          TextButton(
              onPressed: () async {
                await scanNearby();
              },
              child: Text("Scan")),
          TextButton(onPressed: () async {}, child: Text("unPublish")),
          TextButton(
              onPressed: () async {}, child: Text("backgroundSubscribe")),
          TextButton(onPressed: () async {}, child: Text("unSubscribe"))
        ]),
      ),
    );
  }
}
