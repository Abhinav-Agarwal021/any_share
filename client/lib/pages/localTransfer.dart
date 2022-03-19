import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:app_settings/app_settings.dart';

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
  bool _switchValue = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(children: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  primary: Colors.black),
              onPressed: () {
                startBluetoothScan();
              },
              child: const Text("Start Bluetooth Scan")),
          Container(
              padding: const EdgeInsets.only(left: 50),
              child: CupertinoSwitch(
                  activeColor: Colors.lightBlue,
                  value: _switchValue,
                  onChanged: (value) {
                    setState(() {
                      _switchValue = value;
                    });
                  })),
          const Text(
            "Sender",
            style: TextStyle(color: Colors.orange, fontSize: 20),
          )
        ]),
        Expanded(
            child: ListView(
          children: [
            for (var i = 0; i < availableDevices.length; i++)
              ElevatedButton(onPressed: () {}, child: const Text("hi"))
          ],
        ))
      ],
    );
  }

  void startBluetoothScan() async {
    FlutterBlue flutterBlue = FlutterBlue.instance;
    bool bluetoothAvl = await flutterBlue.isAvailable;
    Fluttertoast.showToast(
        msg: "Starting...", textColor: Colors.purpleAccent, fontSize: 20);
    if (bluetoothAvl == false) {
      Fluttertoast.showToast(msg: "Your device does not support bluetooth");
    } else {
      if (await flutterBlue.isOn) {
        Fluttertoast.showToast(
            msg: "Bluetooth is on",
            fontSize: 20,
            textColor: Colors.purpleAccent);
        setState(() {
          bluetoothEnabled = true;
          Fluttertoast.showToast(
              msg: "Starting bluetooth scan...",
              textColor: Colors.purpleAccent,
              fontSize: 20);
          flutterBlue.startScan(timeout: const Duration(seconds: 5));
          var subscription = flutterBlue.scanResults.listen((results) {
            for (ScanResult r in results) {
              print('${r.device.name} found rssi: ${r.rssi}');
              // print(r);
            }
          });
          AppSettings.openBluetoothSettings();
        });
      } else {
        AppSettings.openBluetoothSettings();
      }
    }
    // AppSettings.openBluetoothSettings();
  }
}
