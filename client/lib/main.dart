import 'package:client/pages/chats.dart';
import 'package:client/pages/dashboard.dart';
import 'package:client/pages/login_signup.dart';
import 'package:client/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:client/pages/messages.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart';
import 'dart:convert';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/": (context) => const LoginRoute(),
        MyRoutes.dashboard: (context) => const Dashboard(),
        MyRoutes.signupRoute: (context) => const SignupRoute(),
        MyRoutes.chat: (context) => const Chats(),
        MyRoutes.messages: (context) => Messages()
      },
    );
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();

  var obtainData = sharedPreferences.getString("jwt");

  String uri = "http://10.0.2.2:8000/api/user/";
  var data = {"token": obtainData};
  var response = await post(Uri.parse(uri),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(data),
      encoding: Encoding.getByName("utf-8"));
  var userData;

  if (response.statusCode == 200) {
    userData = response.body;
    print(userData);
  }
  runApp(MaterialApp(
      home: userData == '"Invalid"' ? const SignupRoute() : const Dashboard()));
}
