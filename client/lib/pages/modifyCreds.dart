import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';

class CredsRoute extends StatelessWidget {
  const CredsRoute({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    const title = "Change Creds";
    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(title),
        ),
        body: const CredsForm(),
      ),
    );
  }
}

class CredsForm extends StatefulWidget {
  const CredsForm({Key? key}) : super(key: key);
  @override
  CredsState createState() {
    return CredsState();
  }
}

class CredsState extends State<CredsForm> {
  final _unameCtrlr = TextEditingController();
  final _curpassCtrlr = TextEditingController();
  final _newpassCtrlr = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            controller: _unameCtrlr,
            decoration: const InputDecoration(
                hintText: "Enter username",
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 5, vertical: 2)),
          ),
          TextFormField(
            controller: _curpassCtrlr,
            decoration: const InputDecoration(
                hintText: "Enter current password",
                contentPadding:
                    EdgeInsets.symmetric(vertical: 2, horizontal: 5)),
          ),
          TextFormField(
            controller: _newpassCtrlr,
            decoration: const InputDecoration(
                hintText: "Enter new password",
                contentPadding:
                    EdgeInsets.symmetric(vertical: 2, horizontal: 5)),
          ),
          Container(
            child: ElevatedButton(
                onPressed: () async {
                  var username = _unameCtrlr.text;
                  var password = _curpassCtrlr.text;
                  var newpassword = _newpassCtrlr.text;
                  String uri = "http://10.0.2.2:8000/api/changepass/";
                  var data = {
                    "username": username,
                    "password": password,
                    "newpassword": newpassword
                  };
                  var response = await post(Uri.parse(uri),
                      headers: {
                        "Content-Type": "application/json",
                      },
                      body: jsonEncode(data),
                      encoding: Encoding.getByName("utf-8"));
                },
                child: const Text("Submit")),
          )
        ],
      ),
    );
  }
}
