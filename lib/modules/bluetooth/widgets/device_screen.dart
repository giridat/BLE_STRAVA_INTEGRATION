import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:my_strava_ble_app/common/instances.dart';

import 'characteristic_screen.dart';

class DeviceScreen extends StatefulWidget {
  final DiscoveredDevice device;

  const DeviceScreen({Key? key, required this.device}) : super(key: key);

  @override
  _DeviceScreenState createState() => _DeviceScreenState();
}

class _DeviceScreenState extends State<DeviceScreen> {
  StreamSubscription<ConnectionStateUpdate>? _connectionSubscription;
  bool _connected = false;
  bool _connecting = true;

  @override
  void initState() {
    super.initState();

    _connectionSubscription = Instance.flutterReactiveBle
        .connectToDevice(id: widget.device.id,connectionTimeout: const Duration(seconds: 60))
        .listen((update) {
      switch (update.connectionState) {

        case DeviceConnectionState.connecting:
          setState(() {
            _connecting = true;
          });
          print("Connecting");
          break;
        case DeviceConnectionState.connected:
          setState(() {
            _connected = true;
            _connecting = false;
          });
          print("Connected");
          break;
        case DeviceConnectionState.disconnected:
          print("Disconnected");
          setState(() {
            _connected = false;
            _connecting = false;
          });
        case DeviceConnectionState.disconnecting:
          print("Disconnecting");
          setState(() {
            _connected = false;
            _connecting = false;
          });
      }
    }, onError: (error) {
      setState(() => _connecting = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to connect: $error")),
      );
    });
  }

  @override
  void dispose() {
    _connectionSubscription?.cancel();
    super.dispose();
  }

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.device.name.isNotEmpty ? widget.device.name : 'Unknown Device',
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Show connection status text
            Text(
              _connecting
                  ? "Connecting..."
                  : _connected
                  ? "Connected"
                  : "Disconnected",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 24),
            // Show progress indicator or button based on connection state
            _connecting
                ? const CircularProgressIndicator()
                : _connected
                ? ElevatedButton(
              onPressed: () async {
                final services = await Instance.flutterReactiveBle
                    .discoverServices(widget.device.id);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CharacteristicScreen(
                      deviceId: widget.device.id,
                      services: services,
                    ),
                  ),
                );
              },
              child: const Text("View Characteristics"),
            )
                : const SizedBox.shrink(), // Hide button when disconnected
          ],
        ),
      ),
    );
  }
}
