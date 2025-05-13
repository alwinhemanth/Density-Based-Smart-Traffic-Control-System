import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyChatApp());
}

class MyChatApp extends StatelessWidget {
  const MyChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyChatPage(title: 'Police Group Chat'),
    );
  }
}

class ChatMessage {
  String messageContent;
  String messageType;

  ChatMessage({required this.messageContent, required this.messageType});
}

class MyChatPage extends StatefulWidget {
  const MyChatPage({super.key, required this.title});

  final String title;

  @override
  State<MyChatPage> createState() => _MyChatPageState();
}

class _MyChatPageState extends State<MyChatPage> {
  String name = "";
  List<ChatMessage> messages = [];

  _MyChatPageState() {
    Timer.periodic(Duration(seconds: 2), (_) {
      viewMessages();
    });
  }

  TextEditingController messageController = TextEditingController();

  Future<void> viewMessages() async {
    final pref = await SharedPreferences.getInstance();
    name = pref.getString("name").toString();

    List<ChatMessage> chatMessages = [];

    try {
      final pref = await SharedPreferences.getInstance();
      String url = '${pref.getString('url')}/police_and_userviewchat/';

      var data = await http.post(Uri.parse(url), body: {
        'from_id': pref.getString("lid").toString(),
      });

      var jsondata = json.decode(data.body);
      String status = jsondata['status'];

      var arr = jsondata["data"];

      chatMessages.clear();

      for (int i = 0; i < arr.length; i++) {
        if (pref.getString("lid").toString() == arr[i]['from'].toString()) {
          chatMessages.add(ChatMessage(
              messageContent: "me:"+arr[i]['message'], messageType: "sender"));
        } else {
          chatMessages.add(ChatMessage(
              messageContent: arr[i]['tname']+":"+arr[i]['message'], messageType: "receiver"));
        }
      }

      setState(() {
        messages = chatMessages;
      });

      print(status);
    } catch (e) {
      print("Error: " + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: <Widget>[
      ListView.builder(
      itemCount: messages.length,
        shrinkWrap: true,
        padding: EdgeInsets.only(top: 10, bottom: 50),
        physics: ScrollPhysics(),
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
            child: Align(
              alignment: (messages[index].messageType == "receiver"
                  ? Alignment.topLeft
                  : Alignment.topRight),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.7, // Adjust the multiplier as needed
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: (messages[index].messageType == "receiver"
                        ? Colors.grey.shade200
                        : Colors.blue[200]),
                  ),
                  padding: EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Flexible(
                        child: Text(
                          messages[index].messageContent,
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),

      // ListView.builder(
          //   itemCount: messages.length,
          //   shrinkWrap: true,
          //   padding: EdgeInsets.only(top: 10, bottom: 50),
          //   physics: ScrollPhysics(),
          //   itemBuilder: (context, index) {
          //     return Container(
          //       padding: EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
          //       child: Align(
          //         alignment: (messages[index].messageType == "receiver"
          //             ? Alignment.topLeft
          //             : Alignment.topRight),
          //         child: Container(
          //           decoration: BoxDecoration(
          //             borderRadius: BorderRadius.circular(10),
          //             color: (messages[index].messageType == "receiver"
          //                 ? Colors.grey.shade200
          //                 : Colors.blue[200]),
          //           ),
          //           padding: EdgeInsets.all(16),
          //           child: Row(
          //             children: [
          //               Text(
          //                 messages[index].messageContent,
          //                 style: TextStyle(fontSize: 15),
          //               ),
          //             ],
          //           ),
          //         ),
          //       ),
          //     );
          //   },
          // ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
              height: 60,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      decoration: InputDecoration(
                        hintText: "Write message...",
                        hintStyle: TextStyle(color: Colors.black54),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(width: 15),
                  FloatingActionButton(
                    onPressed: () async {
                      String message = messageController.text.toString();

                      try {
                        final pref = await SharedPreferences.getInstance();
                        String url = '${pref.getString('url')}/policeinschat/';

                        var data = await http.post(Uri.parse(url), body: {
                          'message': message,
                          'from_id': pref.getString("lid").toString(),
                        });

                        var jsondata = json.decode(data.body);
                        String status = jsondata['status'];

                        messageController.text = "";
                        setState(() {});

                        print(status);
                      } catch (e) {
                        print("Error: " + e.toString());
                      }
                    },
                    child: Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 18,
                    ),
                    backgroundColor: Colors.blue,
                    elevation: 0,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
