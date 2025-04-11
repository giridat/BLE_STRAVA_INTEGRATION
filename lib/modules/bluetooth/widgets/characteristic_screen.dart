import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';

import 'characteristic_tile.dart';

class CharacteristicScreen extends StatelessWidget {
  final String deviceId;
  final List<DiscoveredService> services;

  CharacteristicScreen({required this.deviceId, required this.services});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Services & Characteristics")),
      body: ListView(
        children: services
            .map((s) => ExpansionTile(
                  title: Text("Service: ${s.serviceId.toString()}"),
                  children: s.characteristics
                      .map(
                        (c) => CharacteristicTile(
                          deviceId: deviceId,
                          serviceId: s.serviceId,
                          characteristicId: c.characteristicId,
                          isReadable: c.isReadable,
                          isWritableWithResponse: c.isWritableWithResponse,
                          isWritableWithoutResponse: c.isWritableWithoutResponse,
                          isNotifiable: c.isNotifiable,
                          isIndicatable: c.isIndicatable,
                        ),
                      )
                      .toList(),
                ))
            .toList(),
      ),
    );
  }
}
