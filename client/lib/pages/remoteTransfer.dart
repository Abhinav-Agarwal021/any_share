import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:file/file.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';

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
                onPressed: transferFile,
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

  void transferFile() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.any, withReadStream: true);
    if (result == null) {
      return;
    }
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    const receiver = "shadie";
    final userToken = preferences.getString("jwt");
    final file = result.files.first;
    final filePath = file.path;
    final mimeType = lookupMimeType(filePath.toString());
    final contentType = MediaType.parse(mimeType.toString());
    final fileReadStream = file.readStream;
    final size = file.size;
    final fileName = file.name;
    final stream = http.ByteStream(fileReadStream!);
    final multiPartFile = http.MultipartFile('file', stream, size,
        filename: fileName, contentType: contentType);
    const uri = "http://10.0.2.2:8000/api/files/aaaa/";
    final request = http.MultipartRequest("POST", Uri.parse(uri));
    request.files.add(multiPartFile);
    request.fields.addAll(
        {"fileName": fileName, "token": userToken!, "receiver": receiver});
    final httpClient = http.Client();
    final response = await httpClient.send(request);
    print(response);
  }
}
