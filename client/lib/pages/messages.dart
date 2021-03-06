import 'dart:ui';
import 'dart:io';
import 'dart:async';
import 'package:client/pages/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Messages extends StatelessWidget {
  Messages({Key? key}) : super(key: key);

  final String chatName =
      "shady"; // to be changed according to the data received from backend
  final messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: chatName,
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: Text(chatName),
        ),
        body: const MessageContainer(),
      ),
    );
  }
}

class MessageContainer extends StatefulWidget {
  const MessageContainer({Key? key}) : super(key: key);

  @override
  MessageState createState() {
    return MessageState();
  }
}

class MessageState extends State<MessageContainer> {
  late Map<String, List<List<String>>> previousMessages;
  late List<List<String>>? messageList;
  var channel;
  final messageController = TextEditingController();
  final scrollController = ScrollController();
  @override
  MessageState() {
    previousMessages = {
      "messages": [
        ["ourMsg1"],
        ["theirMsg1"],
        ["ourMsg2"],
        ["theirMsg2"],
        ["ourMsg3", "ourMsg3Alt"],
        ["theirMsg3"],
        ["ourMsg4"],
        ["theirMsg4", "theirMsg4Alt"],
        ["ourMsg5", "ourMsg5Alt"],
        ["theirMsg6", "theirMsg6Alt"],
        ["ourMsg7", "ourMsg7Alt"],
        ["theirMsg8", "theirMsg8Alt"],
      ],
    };
    messageList = previousMessages["messages"]?.toList();
  }
  @override
  void initState() {
    super.initState();
    channel = WebSocketChannel.connect(
      Uri.parse('wss://echo.websocket.org'),
    );
    if (Platform.isAndroid) WebView.platform = AndroidWebView();

    // scrollController.jumpTo(10);
  }

  @override
  // messages stored in an array where even index represents our message and odd represents their message
  // if in case a user sends multiple messages , create one array and store those multiple messages there

  Widget build(BuildContext context) {
    return const WebView(
      initialUrl: 'https://backdoor.sdslabs.co',
      javascriptMode: JavascriptMode.unrestricted,
    );
    // return SingleChildScrollView(
    //   controller: scrollController,
    //   child: Column(
    //     children: [
    //       for (var i = 0; i < messageList!.length; i++)
    //         for (var j = 0; j < messageList![i].length; j++)
    //           Row(
    //               mainAxisAlignment: i % 2 == 0
    //                   ? MainAxisAlignment.end
    //                   : MainAxisAlignment.start,
    //               children: [
    //                 Container(
    //                   margin: const EdgeInsets.symmetric(
    //                       vertical: 5, horizontal: 5),
    //                   padding: const EdgeInsets.symmetric(
    //                       vertical: 5, horizontal: 5),
    //                   decoration: BoxDecoration(
    //                       color: i % 2 == 0 ? Colors.amber : Colors.cyan,
    //                       borderRadius: BorderRadius.circular(10)),
    //                   child: Text(
    //                     messageList![i][j],
    //                     style: TextStyle(
    //                         fontSize: 20,
    //                         color: i % 2 == 0 ? Colors.red : Colors.deepPurple),
    //                   ),
    //                 ),
    //               ]),
    //       Row(children: [
    //         Flexible(
    //             child: SizedBox(
    //                 height: 50,
    //                 child: TextFormField(
    //                   controller: messageController,
    //                   decoration: const InputDecoration(
    //                       filled: true,
    //                       fillColor: Color.fromRGBO(3, 35, 139, 100),
    //                       hintStyle: TextStyle(fontSize: 20),
    //                       hintText: "Enter your message"),
    //                 ))),
    //         SizedBox(
    //             height: 50,
    //             child: ElevatedButton(
    //                 onPressed: sendMessage, child: const Text("Send")))
    //       ])
    //     ],
    //   ),
    // );
  }

  void sendMessage() {
    channel.sink.add(messageController.text);
  }
}
