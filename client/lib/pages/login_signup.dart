import 'dart:convert';
// import 'dart:html';
import 'package:client/pages/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer';

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
  final _unameController = TextEditingController();
  final _passController = TextEditingController();
  final _emailController = TextEditingController();
  final _x = 1;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            controller: _unameController,
            decoration: const InputDecoration(
                hintText: "Enter your name",
                contentPadding: EdgeInsets.all(5.0)),
          ),
          TextFormField(
            controller: _passController,
            decoration: const InputDecoration(
                hintText: "Enter your password",
                contentPadding: EdgeInsets.all(5.0)),
          ),
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(
                hintText: "Enter your email",
                contentPadding: EdgeInsets.all(5.0)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: ElevatedButton(
              child: const Text("Submit"),
              onPressed: signup,
            ),
          ),
          TextButton(
              onPressed: switchToLogin,
              child: const Text("Already have an account? Login"))
        ],
      ),
    );
  }

  void switchToLogin() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const LoginRoute()));
  }

  void signup() async {
    String username = _unameController.text;
    String password = _passController.text;
    String email = _emailController.text;
    String uri = "http://10.0.2.2:8000/api/register/";
    var data = {"name": username, "password": password, "email": email};
    var response = await post(Uri.parse(uri),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(data),
        encoding: Encoding.getByName("utf-8"));
    String resb = response.body;
    if (resb == '"success"') {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Signup successful"),
        duration: Duration(seconds: 5),
      ));
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => const LoginRoute()));
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var data = {"email": email, "password": password};
      var response = await post(Uri.parse("http://10.0.2.2:8000/api/login/"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(data),
          encoding: Encoding.getByName("utf-8"));
      String resb = response.body;
      debugPrint(resb);
      var jsonResponse;

      if (response.statusCode == 200) {
        jsonResponse = json.decode(response.body);
      }

      if (jsonResponse != null) {
        sharedPreferences.setString("jwt", jsonResponse['jwt']);
        Navigator.pop(context);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const Dashboard()));
      }
    }
  }
}

class LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            controller: _email,
            decoration: const InputDecoration(
                hintText: "Enter your email",
                contentPadding: EdgeInsets.all(5.0)),
          ),
          TextFormField(
            controller: _password,
            decoration: const InputDecoration(
                hintText: "Enter password",
                contentPadding: EdgeInsets.all(5.0)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: ElevatedButton(
              onPressed: login,
              child: const Text("Submit"),
            ),
          ),
          TextButton(
              onPressed: switchToSignup,
              child: const Text("Do not have account? Signup"))
        ],
      ),
    );
  }

  void switchToSignup() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const SignupRoute()));
  }

  void login() async {
    String uri = "http://10.0.2.2:8000/api/login/";
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String email = _email.text;
    String password = _password.text;
    var data = {"email": email, "password": password};
    var response = await post(Uri.parse(uri),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(data),
        encoding: Encoding.getByName("utf-8"));
    String resb = response.body;
    debugPrint(resb);
    var jsonResponse;

    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
    }

    if (jsonResponse != null) {
      sharedPreferences.setString("jwt", jsonResponse['jwt']);
      Navigator.pop(context);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Dashboard()));
    }
  }
}
