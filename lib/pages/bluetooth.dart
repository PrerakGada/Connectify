import 'package:beacon_broadcast/beacon_broadcast.dart';
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
  BeaconBroadcast beaconBroadcast = BeaconBroadcast();

  void scanForDevices() {
    // Start scanning
    flutterBlue.startScan(timeout: Duration(milliseconds: 200));

    flutterBlue.name.then((value) {
      print(value);
    });

    late List macIds = [];
    late List names = [];
    late List localnames = [];
// Listen to scan results
    var subscription = flutterBlue.scanResults.listen((results) {
      // do something with scan results
      for (ScanResult r in results) {
        if (r.device.name != null) {
          macIds.add(r.device.id);
          names.add(r.device.name);
          localnames.add(r.advertisementData.localName);
          print('|${r.device.name}|${r.device.id}|');
          // print(r);
        }
      }
      macIds = macIds.toSet().toList();
      names = names.toSet().toList();
      localnames = localnames.toSet().toList();

      print(macIds);
      print(names);
      print(localnames);


    });

// Stop scanning
    flutterBlue.stopScan();
  }


  Future<void> beacon() async {
    BeaconStatus transmissionSupportStatus = await beaconBroadcast.checkTransmissionSupported();
    switch (transmissionSupportStatus) {
      case BeaconStatus.supported:
        print('supported');
        break;
      case BeaconStatus.notSupportedMinSdk:
        print('notSupportedMinSdk');
        break;
      case BeaconStatus.notSupportedBle:
        print('notSupportedBle');
        break;
      case BeaconStatus.notSupportedCannotGetAdvertiser:
        print('notSupportedCannotGetAdvertiser');
        break;
    }
  }

  void beaconBroad() {
    beaconBroadcast
        .setUUID('39ED98FF-2900-441A-802F-9C398FC199D2')
        .setMajorId(1)
        .setMinorId(100).setAdvertiseMode(AdvertiseMode.lowPower).setExtraData([7,7,77,7])
        .start();
    beaconBroadcast.setAdvertiseMode(AdvertiseMode.lowPower);
    print('Broadcasting');
    print(beaconBroadcast.setAdvertiseMode(AdvertiseMode.lowPower));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                scanForDevices();
              },
              child: Text('Scan'),
            ),
            ElevatedButton(
              onPressed: () {
                beacon();
                beaconBroadcast;
              },
              child: Text('Beacon Broadcast'),
            ),
          ],
        ),
      ),
    );
  }
}
