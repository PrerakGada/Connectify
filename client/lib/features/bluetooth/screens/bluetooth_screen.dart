import 'dart:async';
import 'dart:math';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BluetoothScreen extends StatefulWidget {
  final bool isEmployee;

  const BluetoothScreen({
    super.key,
    required this.isEmployee,
  });

  @override
  State<BluetoothScreen> createState() => _BluetoothScreenState();
}

class _BluetoothScreenState extends State<BluetoothScreen> {
  final String serviceUuid = '6E400001-B5A3-F393-E0A9-E50E24DCCA9E';
  final String characteristicUuid = '6E400002-B5A3-F393-E0A9-E50E24DCCA9E';
  final String myId = Random().nextInt(1000000).toString();
  List<ScanResult> scanResults = [];
  List<BluetoothDevice> connectedDevices = [];
  bool isScanning = false;
  StreamSubscription? _scanSubscription;
  StreamSubscription? _adapterStateSubscription;

  @override
  void initState() {
    super.initState();
    _initBluetooth();
  }

  Future<void> _initBluetooth() async {
    // Check if Bluetooth is supported
    if (await FlutterBluePlus.isSupported == false) {
      print("Bluetooth not supported by this device");
      return;
    }

    // Listen to adapter state changes
    _adapterStateSubscription =
        FlutterBluePlus.adapterState.listen((BluetoothAdapterState state) {
      if (state == BluetoothAdapterState.on) {
        _startScanning();
      }
    });

    // Turn on Bluetooth if we can (Android only)
    if (!kIsWeb && Platform.isAndroid) {
      await FlutterBluePlus.turnOn();
    }
  }

  Future<void> _connectToDevice(BluetoothDevice device) async {
    try {
      // Listen for disconnection
      var subscription =
          device.connectionState.listen((BluetoothConnectionState state) async {
        if (state == BluetoothConnectionState.disconnected) {
          setState(() {
            connectedDevices.remove(device);
          });
          print(
              "${device.disconnectReason?.code} ${device.disconnectReason?.description}");
        }
      });

      // Connect to the device
      await device.connect();

      // Discover services
      List<BluetoothService> services = await device.discoverServices();

      // Find our service and characteristic
      for (var service in services) {
        if (service.uuid == Guid(serviceUuid)) {
          for (var characteristic in service.characteristics) {
            if (characteristic.uuid == Guid(characteristicUuid)) {
              // Write our ID to the characteristic
              await characteristic.write(myId.codeUnits);

              // Subscribe to notifications to receive the other device's ID
              await characteristic.setNotifyValue(true);
              characteristic.onValueReceived.listen((value) {
                final receivedId = String.fromCharCodes(value);
                print('Received ID from device: $receivedId');
              });
            }
          }
        }
      }

      setState(() {
        connectedDevices.add(device);
      });

      // Cleanup subscription when disconnected
      device.cancelWhenDisconnected(subscription, delayed: true);
    } catch (e) {
      print('Error connecting to device: $e');
    }
  }

  Future<void> _startScanning() async {
    try {
      setState(() {
        isScanning = true;
        scanResults = [];
      });

      // Listen to scan results
      _scanSubscription = FlutterBluePlus.onScanResults.listen((results) {
        if (results.isNotEmpty) {
          setState(() {
            scanResults = results;
          });
        }
      }, onError: (e) => print(e));

      // Start scanning with timeout
      await FlutterBluePlus.startScan(
        withServices: [Guid(serviceUuid)],
        timeout: const Duration(seconds: 8),
      );

      // Wait for scanning to stop
      await FlutterBluePlus.isScanning.where((val) => val == false).first;
    } catch (e) {
      print('Error starting scan: $e');
    } finally {
      setState(() {
        isScanning = false;
      });
    }
  }

  @override
  void dispose() {
    _scanSubscription?.cancel();
    _adapterStateSubscription?.cancel();
    FlutterBluePlus.stopScan();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            '${widget.isEmployee ? "Employee" : "Employer"} Bluetooth View'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('My ID: $myId'),
                const SizedBox(height: 8),
                Text('Scanning: ${isScanning ? "Active" : "Inactive"}'),
                const SizedBox(height: 8),
                Text('Connected Devices: ${connectedDevices.length}'),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: scanResults.length,
              itemBuilder: (context, index) {
                final result = scanResults[index];
                final deviceName = result.advertisementData.advName;
                if (deviceName != null &&
                    deviceName.startsWith('Connectify_')) {
                  final deviceId = deviceName.split('_')[1];
                  final isConnected = connectedDevices
                      .any((d) => d.remoteId == result.device.remoteId);
                  return ListTile(
                    title: Text('Device ID: $deviceId'),
                    subtitle: Text('RSSI: ${result.rssi}'),
                    trailing: isConnected
                        ? const Icon(Icons.bluetooth_connected)
                        : ElevatedButton(
                            onPressed: () => _connectToDevice(result.device),
                            child: const Text('Connect'),
                          ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: _startScanning,
              child: const Text('Scan Again'),
            ),
          ),
        ],
      ),
    );
  }
}
