import 'package:flutter/material.dart';

class TransferRoute extends StatelessWidget {
  const TransferRoute({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Transfer History"),
        ),
        body: const Transfer(),
      ),
    );
  }
}

class Transfer extends StatefulWidget {
  const Transfer({Key? key}) : super(key: key);
  @override
  TransferCont createState() {
    return TransferCont();
  }
}

class TransferCont extends State<Transfer> {
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {}, child: const Text("Transfer Container"));
  }
}
