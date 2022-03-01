import 'package:flutter/material.dart';

class FriendsRoute extends StatelessWidget {
  const FriendsRoute({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Friends"),
        ),
        body: const Frnds(),
      ),
    );
  }
}

class Frnds extends StatefulWidget {
  const Frnds({Key? key}) : super(key: key);
  @override
  FrndsHandler createState() {
    return FrndsHandler();
  }
}

class FrndsHandler extends State<Frnds> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: () {}, child: const Text("Friends"));
  }
}
