import 'package:client/pages/chats.dart';
import 'package:client/pages/dashboard.dart';
import 'package:client/pages/login_signup.dart';
import 'package:client/utils/routes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      routes: {
        "/": (context) => const SignupRoute(),
        MyRoutes.dashboard: (context) => const Dashboard(),
        MyRoutes.signupRoute: (context) => const SignupRoute(),
        MyRoutes.chat: (context) => const Chats()
      },
    );
  }
}
