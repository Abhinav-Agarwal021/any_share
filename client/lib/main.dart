import 'package:client/pages/chats.dart';
import 'package:client/pages/dashboard.dart';
import 'package:client/pages/login_signup.dart';
import 'package:client/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:client/pages/messages.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart';
import 'dart:convert';

var userData;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    getAuthentication().whenComplete(() async {
      Navigator.pop(context);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  userData == null ? const SignupRoute() : const Dashboard()));
    });
    super.initState();
  }

  Future getAuthentication() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    var obtainData = sharedPreferences.getString("jwt");

    String uri = "http://10.0.2.2:8000/api/user/";
    var data = {"token": obtainData};
    var response = await post(Uri.parse(uri),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(data),
        encoding: Encoding.getByName("utf-8"));
    String resb = response.body;
    debugPrint(resb);

    setState(() {
      userData = response.body;
    });

    debugPrint(userData);
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      routes: {
        "/": (context) => const Messages(),
        MyRoutes.dashboard: (context) => const Dashboard(),
        MyRoutes.signupRoute: (context) => const SignupRoute(),
        MyRoutes.chat: (context) => const Chats(),
        MyRoutes.messages: (context) => const Messages()
      },
    );
  }
}
