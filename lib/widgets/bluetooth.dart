import 'dart:async';
import 'package:flutter_nearby_messages_api/flutter_nearby_messages_api.dart';
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
  FlutterNearbyMessagesApi nearbyMessagesApi = FlutterNearbyMessagesApi();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    // For iOS
    // await nearbyMessagesApi.setAPIKey('AIzaSyCpOWW1ernJL2FgyUYWIOnJFaFYufyaXOE');

    nearbyMessagesApi.onFound = (message) {
      print('~~~onFound : $message');
    };

    nearbyMessagesApi.onLost = (message) {
      print('~~~onLost : $message');
    };

    nearbyMessagesApi.statusHandler = (status) {
      print('~~~statusHandler : $status');
    };

    nearbyMessagesApi.setPermissionAlert(
        'Your title', 'Your message', 'Deny', 'Grant');

    nearbyMessagesApi.permissionHandler = (status) {
      print(status);
    };

    nearbyMessagesApi.bluetoothPowerErrorHandler = (args) {
      print('~~~ bluetoothPowerErrorHandler');
    };

    nearbyMessagesApi.bluetoothPermissionErrorHandler = (args) {
      print('~~~ bluetoothPermissionErrorHandler');
    };

    nearbyMessagesApi.microphonePermissionErrorHandler = (args) {
      print('~~~ microphonePermissionErrorHandler');
    };
  }

  void scanForDevices() {
    // Start scanning
    flutterBlue.startScan(timeout: Duration(milliseconds: 200));

    flutterBlue.name.then((value) {
      print(value);
    });

// Listen to scan results
    var subscription = flutterBlue.scanResults.listen((results) {
      // do something with scan results
      for (ScanResult r in results) {
        if (r.device.name != '') {
          print('|${r.device.name}|${r.advertisementData.serviceData}|');
          // print(r);
        }
      }
    });

// Stop scanning
    flutterBlue.stopScan();
  }

  void emitBeacon() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: const Text('Flutter Nearby Messages Example'),
      ),
      body: new Container(
        color: Colors.white70,
        child: new Column(children: [
          new TextButton(
              onPressed: () async {
                await nearbyMessagesApi.publish('Hello world!');
              },
              child: new Text("publish")),
          new TextButton(
              onPressed: () async {
                await nearbyMessagesApi.unPublish();
              },
              child: new Text("unPublish")),
          new TextButton(
              onPressed: () async {
                await nearbyMessagesApi.backgroundSubscribe();
              },
              child: new Text("backgroundSubscribe")),
          new TextButton(
              onPressed: () async {
                await nearbyMessagesApi.backgroundUnsubscribe();
              },
              child: new Text("unSubscribe"))
        ]),
      ),
    );
  }
}
