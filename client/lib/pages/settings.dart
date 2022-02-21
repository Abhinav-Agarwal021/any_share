import 'package:client/pages/messages.dart';
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
            onPressed: () {}, child: const Text("Modify credentials")),
        ElevatedButton(onPressed: () {}, child: const Text("Privacy")),
        ElevatedButton(onPressed: () {}, child: const Text("Security")),
        ElevatedButton(onPressed: () {}, child: const Text("Transfer History")),
        ElevatedButton(onPressed: () {}, child: const Text("Report Bugs"))
      ],
    );
  }
}
