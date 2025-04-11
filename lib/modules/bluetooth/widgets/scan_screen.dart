import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:my_strava_ble_app/common/instances.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:location/location.dart' as loc;

import 'device_screen.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  final List<DiscoveredDevice> _devices = [];
  late Stream<DiscoveredDevice> _scanStream;
  StreamSubscription<DiscoveredDevice>? _scanSubscription;

  bool _scanning = false;

  @override
  void initState() {
    super.initState();

    _initScanOnStartup();
  }

  Future<void> _initScanOnStartup() async {
    // Wait a frame to ensure context is available
    await Instance.flutterReactiveBle.initialize();
    await Future.delayed(Duration(milliseconds: 500));

    // Step 1: Request permissions
    final statuses = await [
      Permission.bluetoothScan,
      Permission.bluetoothConnect,
      Permission.location,
    ].request();

    if (statuses.values.any((status) => !status.isGranted)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please grant all required permissions")),
      );
      return;
    }

    // Step 2: Check BLE status
    final btStatus = await Instance.flutterReactiveBle.statusStream.first;
    // if (btStatus != BleStatus.ready) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(content: Text("Bluetooth is not available or turned off")),
    //   );
    //   return;
    // }

    // Step 3: Ensure location is enabled
    final location = loc.Location();
    bool isLocationEnabled = await location.serviceEnabled();
    if (!isLocationEnabled) {
      isLocationEnabled = await location.requestService();
      if (!isLocationEnabled) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Location services are required for BLE scan")),
        );
        return;
      }
    }

    // Step 4: Start scan
    _startScan();
  }


  Future<void> _startScan() async {
    _devices.clear();
    _scanSubscription = Instance.flutterReactiveBle.scanForDevices(
      scanMode: ScanMode.lowLatency, withServices: [],
    ).listen((device) {
      if (!_devices.any((d) => d.id == device.id)) {
        setState(() {
          _devices.add(device);
        });
      }
    });

    setState(() => _scanning = true);
  }

  void _stopScan() {
    // Instance.flutterReactiveBle.deinitialize();
    _scanSubscription?.cancel();
    setState(() => _scanning = false);
  }

  @override
  void dispose() {
    // Instance.flutterReactiveBle.deinitialize();
    _scanSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Scan Devices')),
      floatingActionButton: FloatingActionButton(
        onPressed: _scanning ? _stopScan : _initScanOnStartup,
        child: Icon(_scanning ? Icons.stop : Icons.search),
      ),
      body:  ListView.builder(
        itemCount: _devices.length,
        itemBuilder: (_, i) {
          final d = _devices[i];
          return ListTile(
            title: Text(d.name.isNotEmpty ? d.name : "Unknown Device"),
            subtitle: Text(d.id),
            trailing: Text(
              d.rssi.toString(),
            ),
            onTap: () {
              _stopScan();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DeviceScreen(device: d),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
