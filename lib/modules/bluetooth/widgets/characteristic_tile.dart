import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:my_strava_ble_app/common/instances.dart';

class CharacteristicTile extends StatefulWidget {
  final String deviceId;
  final Uuid serviceId;
  final Uuid characteristicId;
  final bool isReadable;
  final bool isWritableWithResponse;
  final bool isWritableWithoutResponse;
  final bool isNotifiable;
  final bool isIndicatable;

  const CharacteristicTile({
    super.key,
    required this.deviceId,
    required this.serviceId,
    required this.characteristicId,
    required this.isReadable,
    required this.isWritableWithResponse,
    required this.isWritableWithoutResponse,
    required this.isNotifiable,
    required this.isIndicatable,
  });

  @override
  State<CharacteristicTile> createState() => _CharacteristicTileState();
}

class _CharacteristicTileState extends State<CharacteristicTile> {
  String? readValueAscii;
  String? readValueHex;
  bool isNotifying = false;
  String? notifyValue;
  final TextEditingController _writeController = TextEditingController();
  StreamSubscription<List<int>>? _notificationSubscription;

  QualifiedCharacteristic get _qChar => QualifiedCharacteristic(
    deviceId: widget.deviceId,
    serviceId: widget.serviceId,
    characteristicId: widget.characteristicId,
  );

  @override
  void dispose() {
    _notificationSubscription?.cancel();
    _writeController.dispose();
    super.dispose();
  }

  void _readCharacteristic() async {
    final value = await Instance.flutterReactiveBle.readCharacteristic(_qChar);
    setState(() {
      readValueAscii = utf8.decode(value, allowMalformed: true);
      readValueHex = value.map((b) => b.toRadixString(16).padLeft(2, '0')).join(' ').toUpperCase();
    });
  }

  void _writeCharacteristic() async {
    final text = _writeController.text.trim();
    final value = utf8.encode(text);
    await Instance.flutterReactiveBle.writeCharacteristicWithResponse(
      _qChar,
      value: value,
    );
    _writeController.clear();
  }

  void _toggleNotification() {
    if (isNotifying) {
      _notificationSubscription?.cancel();
      setState(() {
        isNotifying = false;
        notifyValue = null;
      });
    } else {
      final stream = Instance.flutterReactiveBle.subscribeToCharacteristic(_qChar);
      _notificationSubscription = stream.listen((data) {
        final ascii = utf8.decode(data, allowMalformed: true);
        setState(() {
          notifyValue = ascii;
        });
      });

      setState(() {
        isNotifying = true;
      });
    }
  }

  Widget _sectionTitle(String title) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Text(title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
  );

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Characteristic UUID:\n${widget.characteristicId}",
                style: const TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),

            // Read Section
            if (widget.isReadable) ...[
              _sectionTitle("Read Value"),
              ElevatedButton.icon(
                onPressed: _readCharacteristic,
                icon: const Icon(Icons.download),
                label: const Text("Read"),
              ),
              if (readValueAscii != null) ...[
                const SizedBox(height: 6),
                Text("ASCII: $readValueAscii"),
                Text("HEX: $readValueHex"),
              ]
            ],

            // Write Section
            if (widget.isWritableWithResponse ||
                widget.isWritableWithoutResponse) ...[
              _sectionTitle("Write Value"),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _writeController,
                      decoration: const InputDecoration(
                        hintText: "Enter value (e.g. Hello)",
                        border: OutlineInputBorder(),
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton.icon(
                    onPressed: _writeCharacteristic,
                    icon: const Icon(Icons.send),
                    label: const Text("Send"),
                  ),
                ],
              ),
            ],

            // Notification Section
            if (widget.isNotifiable || widget.isIndicatable) ...[
              _sectionTitle("Notifications"),
              ElevatedButton.icon(
                onPressed: _toggleNotification,
                icon: Icon(isNotifying ? Icons.notifications_off : Icons.notifications_active),
                label: Text(isNotifying ? "Unsubscribe" : "Subscribe"),
              ),
              if (notifyValue != null) ...[
                const SizedBox(height: 6),
                Text("Latest Notification: $notifyValue"),
              ]
            ],
          ],
        ),
      ),
    );
  }
}
