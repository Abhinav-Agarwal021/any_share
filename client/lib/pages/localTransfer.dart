import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return const Text("abcde");
  }
}
