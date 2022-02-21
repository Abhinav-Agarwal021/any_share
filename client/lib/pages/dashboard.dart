import 'package:client/pages/chats.dart';
import 'package:client/pages/login_signup.dart';
import 'package:client/pages/settings.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);
  final title = "Dashboard";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: title,
        home: Scaffold(
          appBar: AppBar(title: Text(title)),
          body: const DashContainer(),
        ));
  }
}

class DashContainer extends StatefulWidget {
  const DashContainer({Key? key}) : super(key: key);
  @override
  DashState createState() {
    return DashState();
  }
}

class DashState extends State<DashContainer> {
  void handleLogout() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.clear();
    Navigator.pop(context);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const SignupRoute()));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Padding(
              padding: const EdgeInsets.only(top: 40, left: 10),
              child: ElevatedButton(
                child: const Text("Transfer Locally"),
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(50, 100),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40, left: 10),
              child: ElevatedButton(
                child: const Text("Transfer Remotely"),
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(40, 100),
                ),
              ),
            )
          ]),
          Container(
            height: MediaQuery.of(context).size.height / 1.6,
            color: Colors.cyan,
            margin: const EdgeInsets.symmetric(vertical: 20),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(onPressed: () {}, child: const Text("Friends")),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Chats()));
                  },
                  child: const Text("Chat")),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Settings()));
                  },
                  child: const Text("Settings")),
              ElevatedButton(
                onPressed: handleLogout,
                child: const Text("Logout"),
              )
            ],
          )
        ],
      ),
    );
  }
}
