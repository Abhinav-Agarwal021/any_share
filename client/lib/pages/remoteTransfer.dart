import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class RemoteTransferRoute extends StatelessWidget {
  const RemoteTransferRoute({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Remote transfer"),
        ),
        body: const RemoteTransfer(),
      ),
    );
  }
}

class RemoteTransfer extends StatefulWidget {
  const RemoteTransfer({Key? key}) : super(key: key);
  @override
  RemoteHandler createState() {
    return RemoteHandler();
  }
}

class RemoteHandler extends State<RemoteTransfer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              ElevatedButton(
                  onPressed: () {},
                  child: const Text("Searchbox to be added here"))
            ],
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () async {
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles();
                  if (result == null) {
                    return;
                  }
                  final file = result.files.first;
                  String uri = "http://10.0.2.2:8000/api/files/aaaa/";
                  final SharedPreferences sharedPreferences =
                      await SharedPreferences.getInstance();
                  var user1 = sharedPreferences.getString("jwt");
                  var data = {"user1": user1};
                  var response = await post(Uri.parse(uri),
                      headers: {"Content-Type": "application/json"},
                      body: jsonEncode(data),
                      encoding: Encoding.getByName("utf-8"));

                  print(file);
                  print(response.body);
                },
                child: const Text("Start Transfer"),
                style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    fixedSize: const Size(100, 100)),
              ),
            ],
          )
        ],
      ),
    );
  }
}
