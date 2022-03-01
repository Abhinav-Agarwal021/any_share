import 'package:client/pages/friends.dart';
import 'package:client/pages/messages.dart';
import 'package:client/pages/modifyCreds.dart';
import 'package:client/pages/transferHistory.dart';
import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);
  final title = "Settings";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: title,
        theme: ThemeData.dark(),
        home: Scaffold(
          appBar: AppBar(title: Text(title)),
          body: const SettingsContainer(),
        ));
  }
}

class SettingsContainer extends StatefulWidget {
  const SettingsContainer({Key? key}) : super(key: key);
  @override
  SettingsState createState() {
    return SettingsState();
  }
}

class SettingsState extends State<SettingsContainer> {
  final chatCount = 25; // to be fetched from the server
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const CredsRoute()));
            },
            child: const Text("Modify credentials")),
        ElevatedButton(onPressed: () {}, child: const Text("Privacy")),
        ElevatedButton(onPressed: () {}, child: const Text("Security")),
        ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const TransferRoute()));
            },
            child: const Text("Transfer History")),
        ElevatedButton(onPressed: () {}, child: const Text("Report Bugs"))
      ],
    );
  }
}
