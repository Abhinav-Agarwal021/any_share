import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:qr_flutter/qr_flutter.dart';

class LocalTransferRoute extends StatelessWidget {
  const LocalTransferRoute({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Local Transfer"),
        ),
        body: const LocalTransfer(),
      ),
    );
  }
}

class LocalTransfer extends StatefulWidget {
  const LocalTransfer({Key? key}) : super(key: key);
  @override
  LocalHandler createState() {
    return LocalHandler();
  }
}

class LocalHandler extends State<LocalTransfer> {
  var bluetoothEnabled = false;
  var availableDevices = [];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                primary: Colors.black),
            onPressed: () {},
            child: const Text("Start Bluetooth Scan")),
        Expanded(
            child: ListView(
          children: [
            for (var i = 0; i < 10; i++)
              ElevatedButton(onPressed: () {}, child: Text("hi"))
          ],
        ))
      ],
    );
  }
}
