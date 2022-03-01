import 'package:flutter/material.dart';

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
                onPressed: () {
                  print(_unameCtrlr.text);
                  print(_curpassCtrlr.text);
                  print(_newpassCtrlr.text);
                },
                child: const Text("Submit")),
          )
        ],
      ),
    );
  }
}
