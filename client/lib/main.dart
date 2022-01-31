import 'dart:html';

import 'package:flutter/material.dart';

void main() {
  runApp(const SignupRoute());
}

class LoginRoute extends StatelessWidget {
  const LoginRoute({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    const title = "Login";
    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(title),
        ),
        body: const LoginForm(),
      ),
    );
  }
}

class SignupRoute extends StatelessWidget {
  const SignupRoute({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    const title = "Signup";
    return MaterialApp(
        title: title,
        home: Scaffold(
          appBar: AppBar(
            title: const Text(title),
          ),
          body: const SignupForm(),
        ));
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);
  @override
  LoginFormState createState() {
    return LoginFormState();
  }
}

class SignupForm extends StatefulWidget {
  const SignupForm({Key? key}) : super(key: key);
  @override
  SignupFormState createState() {
    return SignupFormState();
  }
}

class SignupFormState extends State<SignupForm> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            decoration: const InputDecoration(
                hintText: "Enter your name",
                contentPadding: EdgeInsets.all(5.0)),
          ),
          TextFormField(
            decoration: const InputDecoration(
                hintText: "Enter your password",
                contentPadding: EdgeInsets.all(5.0)),
          ),
          TextFormField(
            decoration: const InputDecoration(
                hintText: "Enter your email",
                contentPadding: EdgeInsets.all(5.0)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: ElevatedButton(
              child: const Text("Submit"),
              onPressed: () {},
            ),
          )
        ],
      ),
    );
  }
}

class LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            decoration: const InputDecoration(
                hintText: "Enter your email",
                contentPadding: EdgeInsets.all(5.0)),
          ),
          TextFormField(
            decoration: const InputDecoration(
                hintText: "Enter password",
                contentPadding: EdgeInsets.all(5.0)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: ElevatedButton(
              onPressed: () {},
              child: const Text("Submit"),
            ),
          )
        ],
      ),
    );
  }
}
