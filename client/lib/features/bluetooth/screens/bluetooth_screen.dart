import 'dart:async';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:connectify/features/auth/cubits/auth_cubit/auth_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectify/features/bluetooth/cubits/nearby_jobs_cubit/nearby_jobs_cubit.dart';
import 'package:connectify/features/jobs/screens/employee/employee_job_details_screen.dart';

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
  List<ScanResult> scanResults = [];
  List<BluetoothDevice> connectedDevices = [];
  bool isScanning = false;
  StreamSubscription? _scanSubscription;
  StreamSubscription? _adapterStateSubscription;
  Set<String> receivedUserIds = {};

  @override
  void initState() {
    super.initState();
    _initBluetooth();
  }

  Future<void> _initBluetooth() async {
    if (await FlutterBluePlus.isSupported == false) {
      debugPrint("Bluetooth not supported by this device");
      return;
    }

    _adapterStateSubscription =
        FlutterBluePlus.adapterState.listen((BluetoothAdapterState state) {
      if (state == BluetoothAdapterState.on) {
        _startScanning();
      }
    });

    if (!kIsWeb && Platform.isAndroid) {
      await FlutterBluePlus.turnOn();
    }
  }

  Future<void> _connectToDevice(BluetoothDevice device) async {
    try {
      var subscription =
          device.connectionState.listen((BluetoothConnectionState state) async {
        if (state == BluetoothConnectionState.disconnected) {
          setState(() {
            connectedDevices.remove(device);
          });
          debugPrint(
              "${device.disconnectReason?.code} ${device.disconnectReason?.description}");
        }
      });

      await device.connect();
      List<BluetoothService> services = await device.discoverServices();

      for (var service in services) {
        for (var characteristic in service.characteristics) {
          if (characteristic.properties.write &&
              characteristic.properties.notify) {
            if (!mounted) return;
            final authCubit = context.read<AuthCubit>();
            final authState = authCubit.state;
            if (authState is AuthAuthenticated) {
              await characteristic.write(authState.user.id.codeUnits);
            }

            await characteristic.setNotifyValue(true);
            characteristic.onValueReceived.listen((value) {
              final receivedId = String.fromCharCodes(value);
              setState(() {
                receivedUserIds.add(receivedId);
              });
              if (widget.isEmployee) {
                if (!mounted) return;
                context.read<NearbyJobsCubit>().fetchNearbyJobs(receivedId);
              }
            });
            break;
          }
        }
      }

      setState(() {
        connectedDevices.add(device);
      });

      device.cancelWhenDisconnected(subscription, delayed: true);
    } catch (e) {
      debugPrint('Error connecting to device: $e');
    }
  }

  Future<void> _startScanning() async {
    try {
      setState(() {
        isScanning = true;
        scanResults = [];
      });

      _scanSubscription = FlutterBluePlus.onScanResults.listen((results) {
        if (results.isNotEmpty) {
          setState(() {
            scanResults = results;
          });
        }
      }, onError: (e) => debugPrint(e.toString()));

      await FlutterBluePlus.startScan(
        timeout: const Duration(seconds: 8),
      );

      await FlutterBluePlus.isScanning.where((val) => val == false).first;
    } catch (e) {
      debugPrint('Error starting scan: $e');
    } finally {
      setState(() {
        isScanning = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            '${widget.isEmployee ? "Employee" : "Employer"} Bluetooth View'),
      ),
      body: BlocListener<NearbyJobsCubit, NearbyJobsState>(
        listener: (context, state) {
          if (state is NearbyJobsError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Connected Devices: ${connectedDevices.length}'),
                  if (!widget.isEmployee)
                    const Text('Jobs being broadcasted to nearby applicants'),
                  if (widget.isEmployee)
                    Text('Received Employer IDs: ${receivedUserIds.length}'),
                ],
              ),
            ),
            Expanded(
              child: widget.isEmployee
                  ? ListView.builder(
                      itemCount: scanResults.length,
                      itemBuilder: (context, index) {
                        final result = scanResults[index];
                        final deviceName = result.advertisementData.advName;
                        if (deviceName.isNotEmpty) {
                          final parts = deviceName.split('_');
                          if (parts.length >= 2) {
                            final deviceId = parts[1];
                            final isConnected = connectedDevices.any(
                                (d) => d.remoteId == result.device.remoteId);
                            return Column(
                              children: [
                                ListTile(
                                  title: Text('Device ID: $deviceId'),
                                  subtitle: Text('RSSI: ${result.rssi}'),
                                  trailing: isConnected
                                      ? const Icon(Icons.bluetooth_connected)
                                      : ElevatedButton(
                                          onPressed: () =>
                                              _connectToDevice(result.device),
                                          child: const Text('Connect'),
                                        ),
                                ),
                                if (isConnected)
                                  BlocBuilder<NearbyJobsCubit, NearbyJobsState>(
                                    builder: (context, state) {
                                      if (state is NearbyJobsLoaded) {
                                        final jobs =
                                            state.deviceJobs[deviceId] ?? [];
                                        return Column(
                                          children: jobs
                                              .map((job) => Card(
                                                    child: ListTile(
                                                      title: Text(job.role),
                                                      subtitle: Text(job.pay),
                                                      onTap: () {
                                                        Navigator.of(context)
                                                            .push(
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                EmployeeJobDetailsScreen(
                                                              job: job,
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ))
                                              .toList(),
                                        );
                                      }
                                      return const SizedBox.shrink();
                                    },
                                  ),
                              ],
                            );
                          }
                        }
                        return const SizedBox.shrink();
                      },
                    )
                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.bluetooth,
                            size: 100,
                            color: Colors.blue,
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Your jobs are being broadcasted to nearby applicants',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 18),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Connected Devices: ${connectedDevices.length}',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
            ),
            if (widget.isEmployee)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: _startScanning,
                  child: const Text('Scan Again'),
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scanSubscription?.cancel();
    _adapterStateSubscription?.cancel();
    FlutterBluePlus.stopScan();
    super.dispose();
  }
}
