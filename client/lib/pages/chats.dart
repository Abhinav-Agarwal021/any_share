import 'package:client/pages/messages.dart';
import 'package:flutter/material.dart';

class Chats extends StatelessWidget {
  const Chats({Key? key}) : super(key: key);
  final title = "Chats";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: title,
        theme: ThemeData(
            scaffoldBackgroundColor: Colors.black87,
            elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                    primary: const Color.fromRGBO(0, 0, 41, 50),
                    onPrimary: Colors.amber))),
        home: Scaffold(
          appBar: AppBar(title: Text(title)),
          body: const ChatContainer(),
        ));
  }
}

class ChatContainer extends StatefulWidget {
  const ChatContainer({Key? key}) : super(key: key);
  @override
  ChatState createState() {
    return ChatState();
  }
}

class ChatState extends State<ChatContainer> {
  final chatCount = 25; // to be fetched from the server
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      children: [
        for (var i = 1; i <= chatCount; i++)
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Messages()));
            },
            child: Text(
              "Chat $i",
              style: const TextStyle(fontSize: 17),
            ),
          )
      ],
    );
  }
}
