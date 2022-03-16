import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:file/file.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
  final _receiverController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var receiver = "";
  var receiverName = "invalid";
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _receiverController,
              decoration: const InputDecoration(
                  hintText: "Search a user...",
                  contentPadding: EdgeInsets.all(5.0)),
            ),
            ElevatedButton(onPressed: searchUser, child: const Text("Search"))
          ],
        )),
        Text(
          receiver,
          style: const TextStyle(color: Colors.indigo, fontSize: 20),
        ),
        Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: ElevatedButton(
              onPressed: transferFile,
              child: const Text("Start transfer"),
              style: ElevatedButton.styleFrom(
                  primary: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50))),
            )),
      ],
    );
  }

  void searchUser() async {
    var username = _receiverController.text;
    var uri = "http://10.0.2.2:8000/api/users/$username/";
    var response = await http.get(Uri.parse(uri));
    if (response.body == "1") {
      setState(() {
        receiverName = username;
        receiver = "Transfer a file to $username";
      });
    } else if (response.body == "0") {
      setState(() {
        receiver = "Invalid user, $username";
        receiverName = "invalid";
      });
    }
  }

  void transferFile() async {
    var receiver = receiverName;
    if (receiver != "invalid") {
      FilePickerResult? result = await FilePicker.platform
          .pickFiles(type: FileType.any, withReadStream: true);
      if (result == null) {
        return;
      }
      final SharedPreferences preferences =
          await SharedPreferences.getInstance();
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
    } else {
      Fluttertoast.showToast(
          msg: "Cannot send file to invalid user ",
          textColor: Colors.white,
          backgroundColor: Colors.blue);
    }
  }
}
