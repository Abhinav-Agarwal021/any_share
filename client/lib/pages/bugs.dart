import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class BugRoute extends StatelessWidget {
  const BugRoute({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Report Bugs"),
        ),
        body: const Bug(),
      ),
    );
  }
}

class Bug extends StatefulWidget {
  const Bug({Key? key}) : super(key: key);
  @override
  BugState createState() {
    return BugState();
  }
}

class BugState extends State<Bug> {
  final _formController = TextEditingController();
  final _bugController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Form(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: TextFormField(
              maxLength: 30,
              controller: _bugController,
              decoration: const InputDecoration(hintText: "Title"),
            )),
        Container(
            color: Colors.tealAccent,
            child: TextFormField(
              controller: _formController,
              decoration: const InputDecoration(
                  hintText: "Say something about the bug",
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 5, vertical: 5)),
              maxLines: 10,
            )),
        ElevatedButton(
            onPressed: () async {
              String uri = "http://10.0.2.2:8000/api/bugs/";
              String description = _formController.text;
              String bugTitle = _bugController.text;
              var data = {"bugDescription": description, "bugTitle": bugTitle};
              var response = await post(Uri.parse(uri),
                  headers: {
                    "Content-Type": "application/json",
                  },
                  body: jsonEncode(data),
                  encoding: Encoding.getByName("utf-8"));
              String resb = response.body;
              debugPrint(resb);
            },
            child: const Text("Submit"))
      ],
    ));
  }
}
