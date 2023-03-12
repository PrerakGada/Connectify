import 'package:beacon_broadcast/beacon_broadcast.dart';
import 'package:connectify/logic/state_management/user_store.dart';
import 'package:connectify/pages/Profile/profile_screen.dart';
import 'package:connectify/theme/app_colors.dart';
import 'package:connectify/theme/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:provider/provider.dart';

class Bluetooth extends StatefulWidget {
  static const String id = '/bluetooth';

  Bluetooth({Key? key}) : super(key: key);

  @override
  State<Bluetooth> createState() => _BluetoothState();
}

class _BluetoothState extends State<Bluetooth> {
  FlutterBluePlus flutterBlue = FlutterBluePlus.instance;
  BeaconBroadcast beaconBroadcast = BeaconBroadcast();

  Future<void> scanForDevices() async {
    // Start scanning
    flutterBlue.startScan(timeout: Duration(milliseconds: 2000));

    flutterBlue.name.then((value) {
      print(value);
    });

    late List<String> macIds = [];
    late List names = [];
    late List localnames = [];
// Listen to scan results
    var subscription = flutterBlue.scanResults.listen((results) {
      // do something with scan results
      for (ScanResult r in results) {
        if (r.device.name != '') {
          macIds.add(r.device.id.toString());
          names.add(r.device.name);
          localnames.add(r.advertisementData.localName);
          // print('|${r.device.name}|${r.device.id}|');
          // print(r);
        }
      }
      macIds = macIds.toSet().toList();
      names = names.toSet().toList();
      localnames = localnames.toSet().toList();
    });
    print(macIds);
    flutterBlue.stopScan();

    await UserStore().getNearbyUsers(macs: [
      "50502800-664C-1019-1AA2-11D2890B7554",
      "20F4D848-AEB9-CDD6-072F-216D61C4D3CE"
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 100),
        height: MediaQuery.of(context).size.height,
        child: Consumer<UserStore>(
          builder: (_, userStore, __) {
            final users = userStore.nearbyUsers;
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Profile(user: user),
                        ),
                      );
                    },
                    child: Container(
                      // decoration: BoxDecoration(
                      //     // color: AppColors.greyDark,
                      //     ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Color.fromARGB(255, 31, 31, 34),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10),
                          Row(
                            children: [
                              SizedBox(width: 16),
                              ClipOval(
                                child: Image.network(
                                  index == 0
                                      ? 'https://pbs.twimg.com/profile_images/1247177666106503168/XYHCBnMC_400x400.jpg'
                                      : 'https://pps.whatsapp.net/v/t61.24694-24/317680896_1860449204301171_3157343086843610506_n.jpg?ccb=11-4&oh=01_AdSF9u1T5v4lBRbkIX2bEF9IIFFe72_bD4HEXYAcadqQlg&oe=641AB8C4',
                                  width: 90,
                                  height: 90,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(width: 16),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${user["username"]}',
                                    style: textTheme.headlineLarge!
                                        .copyWith(color: AppColors.primary),
                                  ),
                                  SizedBox(height: 10),
                                  Text('${user["email"]}'),
                                ],
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${user["keyskills"]}, ${user["domainpreference"]}',
                                  style: textTheme.headlineMedium!.copyWith(
                                    color: AppColors.secondary,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text('${user["address"]}'),
                                SizedBox(height: 10),
                                Text('${user["role"]}'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () {
          scanForDevices();
        },
        child: Icon(Icons.bluetooth),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
